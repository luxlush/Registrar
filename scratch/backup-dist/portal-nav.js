/*
 * USeP e-Registrar - shared responsive navigation for the Student and Admin portals.
 *
 * Below 1024px (Tailwind `lg`) the fixed sidebar becomes an off-canvas drawer that is opened
 * from a burger button in the top navbar. At >= 1024px the sidebar is always visible, exactly
 * like the original desktop layout, and this script keeps everything reset.
 *
 * Expected markup (identical on every portal page):
 *   #portal-burger         burger button in the navbar (lg:hidden)
 *   #portal-sidebar        the <aside> drawer
 *   #portal-sidebar-close  X button inside the drawer (lg:hidden)
 *   #portal-backdrop       dark overlay behind the drawer
 * Open/closed state is exposed through [data-open="true"] on the sidebar and backdrop,
 * which the Tailwind `data-[open=true]:` variants in the markup react to.
 */
(function () {
  'use strict';

  var sidebar = document.getElementById('portal-sidebar');
  var backdrop = document.getElementById('portal-backdrop');
  var burger = document.getElementById('portal-burger');
  var closeBtn = document.getElementById('portal-sidebar-close');
  if (!sidebar || !backdrop || !burger) return;

  var FOCUSABLE = 'a[href], button:not([disabled]), input:not([disabled]), select:not([disabled]), textarea:not([disabled]), [tabindex]:not([tabindex="-1"])';
  var desktop = window.matchMedia('(min-width: 1024px)');
  var isOpen = false;
  var returnFocusTo = null;
  var savedOverflow = null;

  /* While the drawer is closed on small screens it is off-screen, so also remove it from the
     tab order and the accessibility tree. */
  function setSidebarReachable(reachable) {
    if (reachable) {
      sidebar.removeAttribute('inert');
      sidebar.removeAttribute('aria-hidden');
    } else {
      sidebar.setAttribute('inert', '');
      sidebar.setAttribute('aria-hidden', 'true');
    }
  }

  function lockScroll(lock) {
    var html = document.documentElement;
    var body = document.body;
    if (lock) {
      savedOverflow = { html: html.style.overflow, body: body.style.overflow };
      html.style.overflow = 'hidden';
      body.style.overflow = 'hidden';
    } else if (savedOverflow) {
      html.style.overflow = savedOverflow.html;
      body.style.overflow = savedOverflow.body;
      savedOverflow = null;
    }
  }

  function openDrawer() {
    if (isOpen || desktop.matches) return;
    isOpen = true;
    returnFocusTo = document.activeElement;
    setSidebarReachable(true);
    sidebar.setAttribute('data-open', 'true');
    backdrop.setAttribute('data-open', 'true');
    burger.setAttribute('aria-expanded', 'true');
    lockScroll(true);
    var first = closeBtn || sidebar.querySelector(FOCUSABLE);
    if (first) first.focus({ preventScroll: true });
  }

  function closeDrawer(restoreFocus) {
    if (!isOpen) return;
    isOpen = false;
    sidebar.removeAttribute('data-open');
    backdrop.removeAttribute('data-open');
    burger.setAttribute('aria-expanded', 'false');
    lockScroll(false);
    if (!desktop.matches) setSidebarReachable(false);
    if (restoreFocus !== false) {
      var target = returnFocusTo && document.contains(returnFocusTo) ? returnFocusTo : burger;
      target.focus({ preventScroll: true });
    }
    returnFocusTo = null;
  }

  function syncToViewport() {
    if (desktop.matches) {
      closeDrawer(false);
      setSidebarReachable(true);
    } else if (!isOpen) {
      setSidebarReachable(false);
    }
  }

  burger.addEventListener('click', function () {
    if (isOpen) closeDrawer(); else openDrawer();
  });
  if (closeBtn) closeBtn.addEventListener('click', function () { closeDrawer(); });
  backdrop.addEventListener('click', function () { closeDrawer(); });

  /* Any nav link inside the drawer closes it (the page navigates away anyway). */
  sidebar.addEventListener('click', function (e) {
    if (e.target.closest && e.target.closest('a[href]')) closeDrawer(false);
  });

  document.addEventListener('keydown', function (e) {
    if (!isOpen) return;
    if (e.key === 'Escape' || e.key === 'Esc') {
      e.preventDefault();
      closeDrawer();
      return;
    }
    if (e.key !== 'Tab') return;
    /* Keep keyboard focus inside the open drawer. */
    var items = Array.prototype.filter.call(sidebar.querySelectorAll(FOCUSABLE), function (el) {
      return el.offsetParent !== null || el === document.activeElement;
    });
    if (!items.length) return;
    var firstEl = items[0];
    var lastEl = items[items.length - 1];
    if (e.shiftKey && (document.activeElement === firstEl || !sidebar.contains(document.activeElement))) {
      e.preventDefault();
      lastEl.focus();
    } else if (!e.shiftKey && (document.activeElement === lastEl || !sidebar.contains(document.activeElement))) {
      e.preventDefault();
      firstEl.focus();
    }
  });

  if (desktop.addEventListener) desktop.addEventListener('change', syncToViewport);
  else if (desktop.addListener) desktop.addListener(syncToViewport);

  syncToViewport();
})();

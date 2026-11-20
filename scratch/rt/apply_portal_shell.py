"""Apply the responsive shell (drawer sidebar, burger navbar, responsive padding/headings) to every
portal page. Strict: every shell replacement must match exactly once per page, otherwise abort."""
import re, pathlib, sys

D = pathlib.Path(r'e:\Registrar\dist')
STUDENT = ['student.html', 'document-requests.html', 'records-correction.html', 'request-tracker.html']
ADMIN = ['admin.html', 'document-queue.html', 'add-drop.html', 'shifting-transfer.html',
         'graduation-verification.html', 'loa-readmission.html']
PORTAL = STUDENT + ADMIN
VIEWPORT = 'width=device-width, initial-scale=1, viewport-fit=cover'

BACKDROP = ('<div id="portal-backdrop" aria-hidden="true" class="fixed inset-0 z-[45] bg-black/50 opacity-0 '
            'pointer-events-none transition-opacity duration-300 lg:hidden '
            'data-[open=true]:opacity-100 data-[open=true]:pointer-events-auto"></div>\n')

ASIDE_OLD = 'fixed left-0 top-0 h-full w-72 text-on-primary z-50 flex flex-col justify-between shadow-2xl bg-primary'
ASIDE_NEW = ('fixed left-0 top-0 h-[100dvh] w-72 max-w-[80vw] text-on-primary z-50 flex flex-col justify-between '
             'bg-primary overflow-y-auto overscroll-contain -translate-x-full lg:translate-x-0 '
             'transition-transform duration-300 ease-out shadow-none lg:shadow-2xl '
             'data-[open=true]:translate-x-0 data-[open=true]:shadow-2xl max-lg:pl-[env(safe-area-inset-left)]')

CLOSE_BTN = ('<button id="portal-sidebar-close" type="button" aria-label="Close navigation menu" '
             'class="ml-auto -mr-2 inline-flex h-11 w-11 shrink-0 items-center justify-center rounded-lg text-on-primary '
             'transition-colors hover:bg-black/20 focus:outline-none focus-visible:ring-2 focus-visible:ring-secondary-fixed lg:hidden">'
             '<span class="material-symbols-outlined text-[24px]" aria-hidden="true">close</span></button>')

BURGER = ('<button id="portal-burger" type="button" aria-label="Open navigation menu" aria-controls="portal-sidebar" '
          'aria-expanded="false" class="-ml-2 inline-flex h-11 w-11 shrink-0 items-center justify-center rounded-lg text-primary '
          'transition-colors hover:bg-surface-container-low focus:outline-none focus-visible:ring-2 focus-visible:ring-primary lg:hidden">'
          '<span class="material-symbols-outlined text-[26px]" aria-hidden="true">menu</span></button>')

WRAP_OLD = '<div class="pl-72 flex flex-col min-h-screen">'
WRAP_NEW = ('<div data-overflow-guard class="lg:pl-72 max-lg:pl-[env(safe-area-inset-left)] '
            'max-lg:pr-[env(safe-area-inset-right)] flex flex-col min-h-[100dvh] max-lg:overflow-x-clip">')

HDR_OLD = ('fixed top-0 left-72 right-0 h-16 bg-surface-container-lowest/90 backdrop-blur-xl '
           'shadow-[0_1px_8px_rgba(0,0,0,0.04)] z-40 flex items-center justify-between px-space-lg')
HDR_NEW = ('fixed top-0 left-0 lg:left-72 right-0 h-16 bg-surface-container-lowest/90 backdrop-blur-xl '
           'shadow-[0_1px_8px_rgba(0,0,0,0.04)] z-40 flex items-center justify-between gap-space-sm '
           'pl-[max(0.5rem,env(safe-area-inset-left))] pr-[max(0.75rem,env(safe-area-inset-right))] '
           'sm:pl-[max(1.5rem,env(safe-area-inset-left))] sm:pr-[max(1.5rem,env(safe-area-inset-right))]')

report = []


def once(s, old, new, label, f):
    n = s.count(old)
    if n != 1:
        sys.exit(f'[{f}] {label}: expected 1 match, got {n}')
    return s.replace(old, new)


def once_rx(s, pattern, repl, label, f):
    """Like once(), but `pattern` is a regex where tag openers may be split across lines."""
    found = re.findall(pattern, s)
    if len(found) != 1:
        sys.exit(f'[{f}] {label}: expected 1 match, got {len(found)}')
    return re.sub(pattern, lambda m: repl.replace('{ws}', m.group(1) if m.groups() else ' '), s, count=1)


def patch_header(h, f):
    # left group: burger first, never let it squeeze the right group
    h = once(h, '<div class="flex items-center gap-space-sm">', '<div class="flex items-center gap-space-sm min-w-0">' + BURGER, 'hdr-left', f)
    h = once(h, 'class="font-headline-sm text-headline-sm text-primary font-bold">USeP Portal',
             'class="font-headline-sm text-headline-sm text-primary font-bold whitespace-nowrap">USeP Portal', 'hdr-title', f)
    h = once_rx(h, r'<span(\s+)class="text-outline-variant">/</span>', '<span{ws}class="hidden lg:inline text-outline-variant">/</span>', 'hdr-slash', f)
    h = once_rx(h, r'<div(\s+)class="flex items-center gap-space-xs bg-surface-container-low px-space-sm py-space-xs rounded-full">',
                '<div{ws}class="hidden lg:flex items-center gap-space-xs bg-surface-container-low px-space-sm py-space-xs rounded-full">', 'hdr-campus', f)
    h = once(h, '<div class="flex items-center gap-space-md">',
             '<div class="flex items-center gap-space-sm sm:gap-space-md shrink-0">', 'hdr-right', f)
    h = once_rx(h, r'<div(\s+)class="flex items-center gap-space-xs bg-secondary-fixed text-on-secondary-fixed px-space-md py-space-xs rounded-full shadow-sm">',
                '<div{ws}class="hidden sm:flex items-center gap-space-xs bg-secondary-fixed text-on-secondary-fixed px-space-md py-space-xs rounded-full shadow-sm">', 'hdr-pill', f)
    h = once(h, 'class="flex items-center gap-space-xs text-on-surface-variant hover:text-primary transition-colors"',
             'class="flex items-center gap-space-xs text-on-surface-variant hover:text-primary transition-colors min-h-[44px] px-1 shrink-0 whitespace-nowrap lg:min-h-0 lg:px-0"', 'hdr-signout', f)
    return h


for f in PORTAL:
    p = D / f
    s = p.read_text(encoding='utf-8')
    if 'id="portal-sidebar"' in s:
        print(f'{f}: already converted, skipping shell')
        continue

    # 1. sidebar -> drawer (+ backdrop before it)
    m = re.search(r'<aside(\s+)class="' + re.escape(ASIDE_OLD) + r'">', s)
    if not m:
        sys.exit(f'[{f}] aside not found')
    s = s[:m.start()] + BACKDROP + '<aside id="portal-sidebar" aria-label="Main navigation" class="' + ASIDE_NEW + '">' + s[m.end():]

    # 2. close button inside the drawer's logo row
    pat = re.compile(r'(<div class="h-16 flex items-center gap-space-sm px-space-lg">\s*<img[^>]*>\s*<div class="flex flex-col min-w-0">.*?</div>)(\s*</div>)', re.S)
    if len(pat.findall(s)) != 1:
        sys.exit(f'[{f}] sidebar logo row: expected 1')
    s = pat.sub(lambda m: m.group(1) + '\n' + CLOSE_BTN + m.group(2), s, count=1)

    # 3. wrapper (remove left offset on mobile)
    s = once(s, WRAP_OLD, WRAP_NEW, 'wrapper', f)

    # 4. header: left-0 on mobile, burger, hide non-essential pills
    s = once(s, HDR_OLD, HDR_NEW, 'header-class', f)
    hm = re.search(r'<header\s+class="fixed top-0 left-0 lg:left-72.*?</header>', s, re.S)
    if not hm:
        sys.exit(f'[{f}] header block not found')
    s = s[:hm.start()] + patch_header(hm.group(0), f) + s[hm.end():]

    # 5. 100vh -> 100dvh
    nvh = s.count('min-h-screen')
    s = s.replace('min-h-screen', 'min-h-[100dvh]')

    # 6. responsive page padding (only touches what exists)
    c = 0
    for old, new in [
        ('p-gutter lg:p-space-xl', 'p-4 sm:p-gutter lg:p-space-xl'),
        ('p-space-lg lg:p-space-xl flex flex-col gap-space-xl max-w-7xl', 'p-4 sm:p-space-lg lg:p-space-xl flex flex-col gap-space-xl max-w-7xl'),
    ]:
        c += s.count(old)
        s = s.replace(old, new)
    # px-gutter used by containers (not already prefixed)
    n_px = len(re.findall(r'(?<![\w:-])px-gutter(?![\w-])', s))
    s = re.sub(r'(?<![\w:-])px-gutter(?![\w-])', 'px-4 sm:px-gutter', s)
    c += n_px

    # 7. h1 scales smoothly (36px on desktop exactly as before: font-size caps at 2.25rem, lh 44px at lg)
    def fix_h1(m):
        tag = m.group(0)
        if 'text-headline-xl' not in tag:
            return tag
        return tag.replace('text-headline-xl', 'text-[clamp(1.5rem,5.5vw,2.25rem)] leading-tight lg:leading-[44px]', 1)
    s, nh1 = re.subn(r'<h1[^>]*>', fix_h1, s)

    # 8. load shared drawer script
    s = once(s, '</head>', '<script src="portal-nav.js" defer></script></head>', 'script', f)

    p.write_text(s, encoding='utf-8', newline='')
    report.append(f'{f}: min-h-screen x{nvh}, padding repl x{c}, h1 x{nh1}')

# viewport meta on every page (portal + public)
for p in sorted(D.glob('*.html')):
    s = p.read_text(encoding='utf-8')
    def vp(m):
        tag = m.group(0)
        return re.sub(r'content="width=device-width,\s*initial-scale=1(\.0)?[^"]*"', f'content="{VIEWPORT}"', tag)
    s2 = re.sub(r'<meta[^>]*viewport[^>]*>', vp, s)
    if s2 != s:
        p.write_text(s2, encoding='utf-8', newline='')
        report.append(f'{p.name}: viewport updated')

print('\n'.join(report))

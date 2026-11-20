// Responsive audit: node audit.mjs [--widths 320,390] [--pages a.html,b.html] [--shots] [--out name]
import { chromium } from 'playwright-core';
import fs from 'node:fs';
import path from 'node:path';

const args = Object.fromEntries(process.argv.slice(2).map((a, i, arr) => a.startsWith('--') ? [a.slice(2), (arr[i + 1] && !arr[i + 1].startsWith('--')) ? arr[i + 1] : true] : []).filter(x => x.length));
const BASE = args.base || 'http://localhost:3000';
const WIDTHS = (args.widths || '320,344,360,375,390,412,430,540,600,768,820,884,1024,1280,1440,1920').split(',').map(Number);
const HEIGHT = { default: 800 };
const PUBLIC = ['index.html', 'login.html', 'unauthorized.html'];
const STUDENT = ['student.html', 'document-requests.html', 'records-correction.html', 'request-tracker.html'];
const ADMIN = ['admin.html', 'document-queue.html', 'add-drop.html', 'shifting-transfer.html', 'graduation-verification.html', 'loa-readmission.html'];
const PAGES = (args.pages ? args.pages.split(',') : [...PUBLIC, ...STUDENT, ...ADMIN]);
const SHOTS = !!args.shots;
const outDir = path.resolve('shots');
if (SHOTS) fs.mkdirSync(outDir, { recursive: true });

const browser = await chromium.launch({ executablePath: 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe', headless: true });
const results = [];

for (const page of PAGES) {
  const role = STUDENT.includes(page) ? 'student' : ADMIN.includes(page) ? 'admin' : null;
  const ctx = await browser.newContext({ viewport: { width: 1280, height: 800 }, deviceScaleFactor: 1 });
  if (role) await ctx.addInitScript(r => { localStorage.setItem('currentUserRole', r); }, role);
  for (const w of WIDTHS) {
    const p = await ctx.newPage();
    await p.setViewportSize({ width: w, height: w < 600 ? 740 : 800 });
    const errors = [];
    p.on('pageerror', e => errors.push(String(e).slice(0, 120)));
    try {
      await p.goto(`${BASE}/${page}`, { waitUntil: 'domcontentloaded', timeout: 30000 });
      await p.waitForLoadState('load', { timeout: 15000 }).catch(() => {});
      await p.waitForTimeout(700);
      const m = await p.evaluate(() => {
        const vw = document.documentElement.clientWidth;
        const doc = document.documentElement;
        const clipped = el => {
          for (let n = el.parentElement; n && n !== document.body && n !== doc; n = n.parentElement) {
            if (n.hasAttribute('data-overflow-guard')) continue; // safety net only: do not count as handled
            const o = getComputedStyle(n).overflowX;
            if (o === 'auto' || o === 'scroll' || o === 'hidden' || o === 'clip') {
              const r = n.getBoundingClientRect();
              if (r.right <= vw + 1 && r.left >= -1) return true;
            }
          }
          return false;
        };
        const offenders = [];
        document.querySelectorAll('body *').forEach(el => {
          const cs = getComputedStyle(el);
          if (cs.display === 'none' || cs.visibility === 'hidden') return;
          const r = el.getBoundingClientRect();
          if (r.width === 0 || r.height === 0) return;
          if (r.right <= 0.5) return; // off-canvas left
          if (r.right > vw + 1 && !clipped(el)) {
            offenders.push(`${el.tagName.toLowerCase()}${el.id ? '#' + el.id : ''}.${String(el.className).split(/\s+/).slice(0, 3).join('.')} r=${Math.round(r.right)}`);
          }
        });
        const small = [];
        document.querySelectorAll('a, button, input, select, textarea, summary, [role=button]').forEach(el => {
          const cs = getComputedStyle(el);
          if (cs.display === 'none' || cs.visibility === 'hidden') return;
          const r = el.getBoundingClientRect();
          if (r.width === 0 || r.height === 0) return;
          if (r.right <= 0.5 || r.left >= vw) return;
          if (el.closest('aside') && r.right <= 0.5) return;
          if (r.width < 44 || r.height < 44) small.push(`${el.tagName.toLowerCase()}[${(el.innerText || el.getAttribute('aria-label') || el.id || el.type || '').trim().slice(0, 18)}] ${Math.round(r.width)}x${Math.round(r.height)}`);
        });
        const fs16 = [];
        document.querySelectorAll('input:not([type=checkbox]):not([type=radio]):not([type=hidden]), select, textarea').forEach(el => {
          const cs = getComputedStyle(el);
          if (cs.display === 'none') return;
          const r = el.getBoundingClientRect();
          if (r.width === 0) return;
          if (parseFloat(cs.fontSize) < 16) fs16.push(`${el.tagName.toLowerCase()}#${el.id || el.name || ''}:${cs.fontSize}`);
        });
        return { vw, sw: doc.scrollWidth, bsw: document.body.scrollWidth, offenders: offenders.slice(0, 6), nOff: offenders.length, small: small.slice(0, 40), nSmall: small.length, fs16: fs16.slice(0, 6) };
      });
      const overflow = m.sw > m.vw || m.nOff > 0;
      results.push({ page, w, overflow, sw: m.sw, nOff: m.nOff, offenders: m.offenders, nSmall: m.nSmall, small: m.small, fs16: m.fs16, errors });
      if (SHOTS) await p.screenshot({ path: path.join(outDir, `${args.out || 'cur'}-${page.replace('.html', '')}-${w}.png`), fullPage: false });
    } catch (e) {
      results.push({ page, w, error: String(e).slice(0, 160) });
    } finally {
      await p.close();
    }
  }
  await ctx.close();
}
await browser.close();

fs.writeFileSync(`audit-${args.out || 'cur'}.json`, JSON.stringify(results, null, 1));
let bad = 0;
for (const r of results) {
  if (r.error) { console.log(`ERR  ${r.page}@${r.w}: ${r.error}`); bad++; continue; }
  if (r.overflow) { bad++; console.log(`OVER ${r.page}@${r.w} scrollW=${r.sw} offenders(${r.nOff}): ${r.offenders.slice(0, 3).join(' | ')}`); }
}
console.log(`\nPages x widths: ${results.length}, with horizontal overflow/errors: ${bad}`);
if (args.small) {
  for (const r of results.filter(r => !r.error && r.w <= 430 && r.nSmall)) console.log(`TAP  ${r.page}@${r.w} (${r.nSmall}): ${r.small.slice(0, 5).join('; ')}`);
}
if (args.fs) {
  for (const r of results.filter(r => !r.error && r.w <= 430 && r.fs16.length)) console.log(`FS   ${r.page}@${r.w}: ${r.fs16.join('; ')}`);
}

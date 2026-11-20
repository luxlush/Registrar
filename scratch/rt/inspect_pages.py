import re, pathlib, sys
D = pathlib.Path(r'e:\Registrar\dist')
files = ['student.html','document-requests.html','records-correction.html','request-tracker.html','admin.html','document-queue.html','add-drop.html','shifting-transfer.html','graduation-verification.html','loa-readmission.html']
for f in files:
    s = (D/f).read_text(encoding='utf-8')
    print('=====', f, len(s))
    for label, pat in [
        ('aside', r'<aside\s+[^>]*>'),
        ('wrapper', r'<div class="pl-72[^"]*">'),
        ('header', r'<header\s+class="fixed[^"]*"'),
        ('main', r'<main[^>]*>'),
        ('h1', r'<h1[^>]*>'),
        ('viewport', r'<meta[^>]*viewport[^>]*>'),
        ('min-h-screen', r'min-h-screen'),
        ('100vh', r'100vh|h-screen'),
        ('px-gutter', r'px-gutter|p-gutter|p-space-lg lg:p-space-xl'),
        ('fixed-inset', r'fixed inset-0[^"]*'),
        ('tables', r'<table[^>]*>'),
        ('scripts', r'<script[^>]*src=[^>]*>'),
    ]:
        m = re.findall(pat, s)
        if label in ('min-h-screen','100vh'):
            print(f'  {label}: {len(m)}')
        else:
            seen = []
            for x in m:
                x = re.sub(r'\s+', ' ', x)
                if x not in seen: seen.append(x)
            print(f'  {label} ({len(m)}):', *[('\n      ' + x[:230]) for x in seen[:6]])

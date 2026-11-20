import pathlib, re

D = pathlib.Path('dist')
admin_pages = ['add-drop.html', 'shifting-transfer.html', 'graduation-verification.html', 'loa-readmission.html']

for p in admin_pages:
    s = (D / p).read_text(encoding='utf-8')
    # Find heading and the div next to it
    m = re.search(r'<h1[^>]*>.*?</h1>\s*(?:<p[^>]*>.*?</p>)?\s*</div>\s*(<div[^>]*>.*?</div>)', s, re.S)
    if m:
        print(f"=== {p} top action area ===")
        print(m.group(1)[:300])

import pathlib, re

D = pathlib.Path('dist')
pages = ['admin.html', 'document-queue.html', 'add-drop.html', 'shifting-transfer.html', 'graduation-verification.html', 'loa-readmission.html', 'student.html', 'document-requests.html', 'records-correction.html', 'request-tracker.html']

for p in pages:
    s = (D / p).read_text(encoding='utf-8')
    tables = re.findall(r'<table[^>]*>', s)
    # Check if tables are wrapped in overflow-x-auto
    unwrapped_tables = []
    for m in re.finditer(r'<table[^>]*>', s):
        idx = m.start()
        prefix = s[max(0, idx-200):idx]
        if 'overflow-x-auto' not in prefix:
            unwrapped_tables.append(m.group(0)[:50])
    
    # Check buttons
    print(f"{p}: tables={len(tables)}, unwrapped={len(unwrapped_tables)}")
    if unwrapped_tables:
        print(f"  Unwrapped: {unwrapped_tables}")

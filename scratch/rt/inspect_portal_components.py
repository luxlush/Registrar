import pathlib, re

D = pathlib.Path('dist')
pages = ['admin.html', 'document-queue.html', 'add-drop.html', 'shifting-transfer.html', 'graduation-verification.html', 'loa-readmission.html', 'student.html', 'document-requests.html', 'records-correction.html', 'request-tracker.html']

for p in pages:
    s = (D / p).read_text(encoding='utf-8')
    # find fixed inset-0 or modal
    modals = re.findall(r'<div[^>]*id=\"[^\"]*modal[^\"]*\"[^>]*>', s, re.I)
    forms = re.findall(r'<form[^>]*>', s)
    grids = re.findall(r'grid-cols-[0-9]+', s)
    print(f"=== {p} ===")
    if modals:
        print(f"  Modals: {modals}")
    # find buttons with action texts
    actions = re.findall(r'<button[^>]*>[^<]*(?:Export|Sync|Reset|Batch|Approve|Decline|Filter|Add|Submit)[^<]*</button>', s, re.I)
    if actions:
        print(f"  Action buttons ({len(actions)}): {[a[:60] for a in actions[:4]]}")

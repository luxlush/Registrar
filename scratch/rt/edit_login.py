import pathlib
p = pathlib.Path(r'e:\Registrar\dist\login.html')
s = p.read_text(encoding='utf-8')

old_logo = '''<div class="panel-logo">
          <img src="../src/assets/usep-logo-transparent.png" alt="USeP Logo">
        </div>'''
new_logo = '''<div class="panel-logo">
          <img src="../src/assets/usep-logo-transparent.png" alt="USeP Logo">
          <span class="panel-brand-name">USeP e-Registrar</span>
        </div>'''
assert s.count(old_logo) == 1
s = s.replace(old_logo, new_logo)

old_a = '<a href="index.html" style="font-size: 13px;'
assert s.count(old_a) == 2
s = s.replace(old_a, '<a href="index.html" class="back-link" style="font-size: 13px;')
p.write_text(s, encoding='utf-8', newline='')
print('login.html markup updated')

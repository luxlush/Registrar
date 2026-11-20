import os
import glob

def apply_global_js():
    dist_dir = r"e:\Registrar\dist"
    js_filename = "portal-interactions.js"
    js_path = os.path.join(dist_dir, js_filename)

    # 1. Create the JS file
    js_content = """
// Global interactions for USeP e-Registrar Portal (Student & Admin)
document.addEventListener('DOMContentLoaded', () => {
    
    // --- 1. Dynamic Search / Filter ---
    const searchInputs = document.querySelectorAll('input[type="text"]');
    searchInputs.forEach(input => {
        const ph = (input.getAttribute('placeholder') || '').toLowerCase();
        const id = (input.id || '').toLowerCase();
        if (ph.includes('search') || ph.includes('filter') || id.includes('search')) {
            input.addEventListener('input', (e) => {
                const val = e.target.value.toLowerCase();
                
                // Find closest table tbody
                let tableBody = null;
                const container = input.closest('.bg-surface-container-lowest') || input.closest('.flex-col') || document.body;
                
                if (container.querySelector('table tbody')) {
                    tableBody = container.querySelector('table tbody');
                } else if (document.querySelector('table tbody')) {
                    tableBody = document.querySelector('table tbody');
                }

                if (tableBody) {
                    tableBody.querySelectorAll('tr').forEach(row => {
                        row.style.display = row.innerText.toLowerCase().includes(val) ? '' : 'none';
                    });
                }
            });
        }
    });

    // --- 2. Button Interactions ---
    document.body.addEventListener('click', (e) => {
        // Handle anchor tags that go nowhere
        const a = e.target.closest('a');
        if (a && a.getAttribute('href') === '#') {
            e.preventDefault();
        }

        const btn = e.target.closest('button');
        if (!btn) return;

        // Sign Out
        if (btn.innerText.toLowerCase().includes('sign out') || btn.innerHTML.includes('logout')) {
            window.localStorage.removeItem('currentUserRole');
            window.location.href = 'index.html'; // Assuming index.html is the login/landing
            return;
        }

        // Prevent double click or interacting with disabled/already working buttons
        if (btn.disabled || btn.hasAttribute('data-working')) return;

        const text = btn.innerText.toLowerCase();
        const actionableKeywords = ['approve', 'decline', 'complete', 'issue', 'sign', 'export', 'sync', 'submit', 'download', 'view', 'docket'];
        
        const isActionable = actionableKeywords.some(kw => text.includes(kw));

        // Let inline script handle specific buttons if they want (like reset data)
        if (btn.id && (btn.id.includes('reset') || btn.id.includes('reactivate') || btn.id.includes('finalComplete'))) {
            // These might have their own listeners defined in inline scripts. Let them run.
            // But we can still add a ripple if they don't block. 
            // We'll skip preventing default, but we'll return so our generic logic doesn't override their specific logic.
            return;
        }

        if (isActionable) {
            e.preventDefault();
            const originalHTML = btn.innerHTML;
            btn.setAttribute('data-working', 'true');
            btn.style.opacity = '0.7';
            btn.style.pointerEvents = 'none';
            
            // Determine action type for visual color
            let successColor = 'bg-[#1b5e20]'; // Green for approve/complete
            let icon = 'check_circle';
            let msg = 'Done';

            if (text.includes('decline')) {
                successColor = 'bg-error'; // Red
                icon = 'cancel';
                msg = 'Declined';
            } else if (text.includes('export') || text.includes('download')) {
                successColor = 'bg-secondary';
                icon = 'download_done';
                msg = 'Downloaded';
            }

            // Simulate network request
            setTimeout(() => {
                btn.style.opacity = '1';
                btn.innerHTML = `<span class="material-symbols-outlined text-[16px]">${icon}</span> <span>${msg}</span>`;
                
                // Temporarily override background
                const oldClasses = btn.className;
                btn.className = `px-3 py-1.5 rounded-lg ${successColor} text-white font-label-md text-label-md flex items-center justify-center gap-1 shadow-sm transition-all whitespace-nowrap`;
                
                // Reset back to original after 1.5s
                setTimeout(() => {
                    btn.className = oldClasses;
                    btn.innerHTML = originalHTML;
                    btn.removeAttribute('data-working');
                    btn.style.pointerEvents = 'auto';
                }, 1500);

            }, 600); // 600ms fake delay
        }
    });
});
"""
    with open(js_path, 'w', encoding='utf-8') as f:
        f.write(js_content)
    
    # 2. Inject into all HTML files
    html_files = glob.glob(os.path.join(dist_dir, "*.html"))
    script_tag = '\n<script src="portal-interactions.js"></script>\n'
    
    for html_file in html_files:
        with open(html_file, 'r', encoding='utf-8') as f:
            content = f.read()
            
        # Avoid double injection
        if 'src="portal-interactions.js"' not in content:
            # Inject right before </body>
            if '</body>' in content:
                content = content.replace('</body>', f'{script_tag}</body>')
            else:
                content += script_tag
                
            with open(html_file, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"Updated {os.path.basename(html_file)}")
        else:
            print(f"Skipped {os.path.basename(html_file)} (already has script)")

if __name__ == '__main__':
    apply_global_js()

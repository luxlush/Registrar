import re

def build_shifting():
    with open('e:/Registrar/dist/admin.html', 'r', encoding='utf-8') as f:
        admin_html = f.read()
        
    user_shifting_main = """<main class="w-full pt-16 bg-surface min-h-screen"><div class="flex flex-col w-full">
<div class="p-gutter flex flex-col gap-space-lg">
<!-- Top Administrative Header & Context -->
<div class="flex flex-col md:flex-row md:items-end justify-between gap-space-md">
<div class="flex flex-col gap-1">
<div class="flex items-center gap-space-xs">
<span class="font-label-sm text-label-sm uppercase tracking-wider text-primary font-bold">Registrar Operations</span>
<span class="text-outline-variant font-code-sm text-code-sm">•</span>
<span class="font-label-sm text-label-sm uppercase tracking-wider text-on-surface-variant font-semibold">Ledger Terminal</span>
</div>
<h1 class="font-headline-xl text-headline-xl text-primary font-extrabold tracking-tight">Shifting &amp; Transfer Evaluation</h1>
<p class="font-body-md text-body-md text-on-surface-variant max-w-3xl">
          Process internal college shifting applications, external university transferees, and formal course credit evaluations under the Revised Academic Code.
        </p>
</div>
<div class="flex items-center gap-space-sm self-start md:self-auto">
<button class="flex items-center gap-space-xs px-space-sm py-2 rounded-lg bg-surface-container-high hover:bg-surface-container-highest text-on-surface transition-colors shadow-sm font-label-md text-label-md" id="btn-export-log">
<span class="material-symbols-outlined text-[18px]">download_for_offline</span>
<span>Audit Export</span>
</button>
<button class="flex items-center gap-space-xs px-space-sm py-2 rounded-lg bg-primary text-on-primary hover:bg-primary-container transition-all shadow-sm font-label-md text-label-md" id="btn-refresh">
<span class="material-symbols-outlined text-[18px]">refresh</span>
<span>Sync Records</span>
</button>
</div>
</div>
<!-- Live Performance Metric Bento Grid -->
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-space-md">
<!-- Card 1 -->
<div class="bg-surface-container-lowest rounded-xl p-space-md shadow-sm flex flex-col justify-between relative overflow-hidden group">
<div class="flex items-center justify-between">
<span class="font-label-sm text-label-sm uppercase tracking-wider text-on-surface-variant">Active Shifting Requests</span>
<div class="w-8 h-8 rounded-lg bg-surface-container-high flex items-center justify-center text-primary group-hover:bg-primary group-hover:text-on-primary transition-colors">
<span class="material-symbols-outlined text-[20px]">swap_horiz</span>
</div>
</div>
<div class="mt-space-md flex items-baseline justify-between">
<span class="font-headline-xl text-headline-xl font-bold text-on-surface">1</span>
<span class="inline-flex items-center gap-1 font-label-sm text-label-sm text-secondary font-semibold bg-secondary-fixed/40 px-2 py-0.5 rounded-full">
<span class="w-1.5 h-1.5 rounded-full bg-secondary"></span> 1 Internal CAS
          </span>
</div>
<div class="mt-2 text-on-surface-variant font-body-sm text-body-sm flex items-center gap-1">
<span>Priority action required</span>
</div>
</div>
<!-- Card 2 -->
<div class="bg-surface-container-lowest rounded-xl p-space-md shadow-sm flex flex-col justify-between relative overflow-hidden group">
<div class="flex items-center justify-between">
<span class="font-label-sm text-label-sm uppercase tracking-wider text-on-surface-variant">Pending Dean &amp; Dept Review</span>
<div class="w-8 h-8 rounded-lg bg-surface-container-high flex items-center justify-center text-secondary group-hover:bg-secondary group-hover:text-on-secondary transition-colors">
<span class="material-symbols-outlined text-[20px]">pending_actions</span>
</div>
</div>
<div class="mt-space-md flex items-baseline justify-between">
<span class="font-headline-xl text-headline-xl font-bold text-on-surface">1</span>
<span class="inline-flex items-center gap-1 font-label-sm text-label-sm text-on-surface-variant font-medium bg-surface-container px-2 py-0.5 rounded-full">
            Psychology Dept
          </span>
</div>
<div class="mt-2 text-on-surface-variant font-body-sm text-body-sm flex items-center gap-1">
<span class="material-symbols-outlined text-[14px] text-secondary">verified</span>
<span>Endorsed by CAS Dean</span>
</div>
</div>
<!-- Card 3 -->
<div class="bg-surface-container-lowest rounded-xl p-space-md shadow-sm flex flex-col justify-between relative overflow-hidden group">
<div class="flex items-center justify-between">
<span class="font-label-sm text-label-sm uppercase tracking-wider text-on-surface-variant">Credited Units Pending</span>
<div class="w-8 h-8 rounded-lg bg-surface-container-high flex items-center justify-center text-primary group-hover:bg-primary group-hover:text-on-primary transition-colors">
<span class="material-symbols-outlined text-[20px]">layers</span>
</div>
</div>
<div class="mt-space-md flex items-baseline justify-between">
<div class="flex items-baseline gap-1">
<span class="font-headline-xl text-headline-xl font-bold text-on-surface">32</span>
<span class="font-label-md text-label-md text-on-surface-variant">Units</span>
</div>
<span class="inline-flex items-center gap-1 font-label-sm text-label-sm text-primary font-semibold bg-primary-fixed/50 px-2 py-0.5 rounded-full">
            10 Subjects
          </span>
</div>
<div class="mt-2 text-on-surface-variant font-body-sm text-body-sm">
<span>GE Core + Track Prerequisites</span>
</div>
</div>
<!-- Card 4 -->
<div class="bg-surface-container-lowest rounded-xl p-space-md shadow-sm flex flex-col justify-between relative overflow-hidden group">
<div class="flex items-center justify-between">
<span class="font-label-sm text-label-sm uppercase tracking-wider text-on-surface-variant">Average Transferee GWA</span>
<div class="w-8 h-8 rounded-lg bg-surface-container-high flex items-center justify-center text-secondary group-hover:bg-secondary group-hover:text-on-secondary transition-colors">
<span class="material-symbols-outlined text-[20px]">grade</span>
</div>
</div>
<div class="mt-space-md flex items-baseline justify-between">
<span class="font-headline-xl text-headline-xl font-bold text-on-surface">1.34</span>
<span class="inline-flex items-center gap-1 font-label-sm text-label-sm text-on-primary font-semibold bg-primary px-2 py-0.5 rounded-full">
            Dean's Honors
          </span>
</div>
<div class="mt-2 text-on-surface-variant font-body-sm text-body-sm">
<span>Threshold requirement ≥ 2.00</span>
</div>
</div>
</div>
<!-- Ledger Workflow Section with Context Filters -->
<div class="bg-surface-container-lowest rounded-xl p-space-md shadow-sm flex flex-col gap-space-md">
<!-- Search & Status Navigation -->
<div class="flex flex-col lg:flex-row items-stretch lg:items-center justify-between gap-space-sm">
<!-- Search Input Bar -->
<div class="relative flex-1">
<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-on-surface-variant text-[20px]">search</span>
<input class="w-full pl-10 pr-4 py-2.5 bg-surface-container-low rounded-lg text-body-md text-on-surface placeholder:text-on-surface-variant/70 focus:outline-none focus:bg-surface-container focus:ring-1 focus:ring-primary font-body-md" id="table-search" placeholder="Search student, ID, former program, or target program..." type="text"/>
</div>
<!-- Filter Dropdown & Category Selector -->
<div class="flex items-center gap-space-xs flex-wrap">
<div class="relative">
<select class="appearance-none bg-surface-container-low text-on-surface font-label-md text-label-md pl-3 pr-8 py-2.5 rounded-lg focus:outline-none focus:ring-1 focus:ring-primary cursor-pointer">
<option value="all">All Evaluators</option>
<option value="dean-cas">CAS Dean Endorsed</option>
<option value="dept-psych">Psychology Dept Head</option>
<option value="reg-admin">Registrar Evaluation</option>
</select>
<span class="material-symbols-outlined absolute right-2 top-1/2 -translate-y-1/2 pointer-events-none text-on-surface-variant text-[18px]">expand_more</span>
</div>
<button class="flex items-center gap-1 px-3 py-2.5 bg-surface-container-low hover:bg-surface-container text-on-surface font-label-md text-label-md rounded-lg transition-colors">
<span class="material-symbols-outlined text-[18px]">filter_list</span>
<span>Filters</span>
</button>
</div>
</div>
<!-- Category Filter Pills (Aligned with Screenshot & Design System) -->
<div class="flex items-center gap-2 overflow-x-auto pb-1 border-b border-transparent">
<button class="px-space-sm py-1.5 rounded-full font-label-sm text-label-sm transition-all whitespace-nowrap bg-surface-container text-on-surface-variant hover:text-on-surface hover:bg-surface-container-high">
          Add/Drop &amp; Enrollment
        </button>
<button class="px-space-sm py-1.5 rounded-full font-label-sm text-label-sm transition-all whitespace-nowrap bg-primary text-on-primary font-bold shadow-sm flex items-center gap-1.5">
<span>Shifting &amp; Transfer Evaluation</span>
<span class="w-4 h-4 rounded-full bg-primary-container text-on-primary text-[10px] flex items-center justify-center font-bold">1</span>
</button>
<button class="px-space-sm py-1.5 rounded-full font-label-sm text-label-sm transition-all whitespace-nowrap bg-surface-container text-on-surface-variant hover:text-on-surface hover:bg-surface-container-high">
          Credit Validation &amp; Deficiencies
        </button>
<button class="px-space-sm py-1.5 rounded-full font-label-sm text-label-sm transition-all whitespace-nowrap bg-surface-container text-on-surface-variant hover:text-on-surface hover:bg-surface-container-high">
          LOA &amp; Readmission
        </button>
<button class="px-space-sm py-1.5 rounded-full font-label-sm text-label-sm transition-all whitespace-nowrap bg-surface-container text-on-surface-variant hover:text-on-surface hover:bg-surface-container-high">
          Graduation &amp; Verification
        </button>
</div>
<!-- Main Ledger Table Container -->
<div class="overflow-x-auto">
<table class="w-full text-left font-body-md text-body-md">
<thead>
<tr class="bg-surface-container-low text-on-surface-variant font-label-sm text-label-sm uppercase tracking-wider rounded-lg">
<th class="py-3 px-4 rounded-l-lg">Transaction &amp; Route</th>
<th class="py-3 px-4">Student Identity</th>
<th class="py-3 px-4">Program Transition</th>
<th class="py-3 px-4">Academic Metric</th>
<th class="py-3 px-4">Review Status</th>
<th class="py-3 px-4 text-right rounded-r-lg">Administrative Actions</th>
</tr>
</thead>
<tbody class="divide-y divide-transparent">
<!-- Reference Row: Ana C. Flores -->
<tr class="hover:bg-surface-container-low/50 transition-colors">
<td class="py-4 px-4 align-top">
<div class="flex flex-col gap-1">
<div class="flex items-center gap-1.5">
<span class="material-symbols-outlined text-primary text-[18px]">swap_horizontal_circle</span>
<span class="font-headline-sm text-headline-sm text-on-surface font-bold">Shifting &amp; Transfer</span>
</div>
<div class="flex items-center gap-2">
<span class="font-code-sm text-code-sm text-primary font-semibold bg-primary-fixed/40 px-1.5 py-0.5 rounded">ACA-26068</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">Internal College Shift</span>
</div>
</div>
</td>
<td class="py-4 px-4 align-top">
<div class="flex items-center gap-space-sm">
<div class="w-10 h-10 rounded-full bg-secondary-fixed text-on-secondary-fixed flex items-center justify-center font-headline-sm text-headline-sm font-bold flex-shrink-0">
                    AF
                  </div>
<div class="flex flex-col min-w-0">
<span class="font-label-lg text-label-lg font-bold text-on-surface hover:text-primary cursor-pointer truncate">Ana C. Flores</span>
<span class="font-code-sm text-code-sm text-on-surface-variant">ID: 2022-00612</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">College of Arts and Sciences</span>
</div>
</div>
</td>
<td class="py-4 px-4 align-top">
<div class="flex flex-col gap-1">
<div class="flex items-center gap-2">
<span class="font-label-md text-label-md font-semibold text-on-surface line-through opacity-70">BA Communication</span>
<span class="material-symbols-outlined text-[16px] text-secondary">arrow_forward</span>
<span class="font-label-lg text-label-lg font-bold text-primary">BS Psychology</span>
</div>
<span class="font-body-sm text-body-sm text-on-surface-variant italic">Reason: Medical &amp; Clinical Path Alignment</span>
<div class="flex items-center gap-1 mt-1">
<span class="w-2 h-2 rounded-full bg-secondary"></span>
<span class="font-label-sm text-label-sm font-semibold text-on-surface">32 Units Credited</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">• Regular 2nd Year Standing</span>
</div>
</div>
</td>
<td class="py-4 px-4 align-top">
<div class="flex flex-col gap-1">
<div class="flex items-baseline gap-1">
<span class="font-headline-sm text-headline-sm font-extrabold text-on-surface">1.34</span>
<span class="font-label-sm text-label-sm text-on-surface-variant">Cumulative GWA</span>
</div>
<span class="inline-flex items-center px-2 py-0.5 rounded-full bg-surface-container font-label-sm text-label-sm text-on-surface font-semibold w-max">
                    Upper 5% Rank
                  </span>
<span class="font-body-sm text-body-sm text-on-surface-variant">0 Incomplete / 0 Dropped</span>
</div>
</td>
<td class="py-4 px-4 align-top">
<div class="flex flex-col gap-1.5 items-start">
<span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full bg-secondary-fixed/50 text-on-secondary-fixed font-label-sm text-label-sm font-bold">
<span class="w-2 h-2 rounded-full bg-secondary animate-pulse"></span>
                    Processing
                  </span>
<span class="font-body-sm text-body-sm text-on-surface-variant">Step 3 of 4: Registrar Final</span>
<div class="flex items-center gap-1 text-[11px] text-secondary font-medium">
<span class="material-symbols-outlined text-[14px]">history</span>
<span>CAS Board Signed</span>
</div>
</div>
</td>
<td class="py-4 px-4 align-top text-right">
<div class="flex items-center justify-end gap-1.5 flex-wrap">
<button class="px-2.5 py-1.5 rounded-lg bg-surface-container hover:bg-surface-container-high text-on-surface font-label-md text-label-md transition-colors flex items-center gap-1 shadow-sm" id="btn-open-evaluation" title="Inspect unit equivalency table">
<span class="material-symbols-outlined text-[16px]">rule</span>
<span>Evaluate Units</span>
</button>
<button class="px-2.5 py-1.5 rounded-lg bg-surface-container-high hover:bg-primary-fixed hover:text-on-primary-fixed text-on-surface font-label-md text-label-md transition-colors flex items-center gap-1" id="btn-approve-row" title="Endorse Shifting">
<span class="material-symbols-outlined text-[16px] text-secondary">check</span>
<span>Approve</span>
</button>
<button class="px-2.5 py-1.5 rounded-lg bg-surface-container hover:bg-error-container text-on-surface-variant hover:text-on-error-container font-label-md text-label-md transition-colors flex items-center gap-1" id="btn-decline-row" title="Reject request">
<span class="material-symbols-outlined text-[16px]">close</span>
<span>Decline</span>
</button>
<button class="px-3 py-1.5 rounded-lg bg-primary hover:bg-primary-container text-on-primary font-label-md text-label-md font-bold transition-all shadow-sm flex items-center gap-1" id="btn-complete-row">
<span>Complete</span>
</button>
</div>
</td>
</tr>
</tbody>
</table>
</div>
<!-- Pagination / Footer Info -->
<div class="flex flex-col sm:flex-row items-center justify-between gap-space-sm pt-space-xs text-on-surface-variant font-body-sm text-body-sm">
<div class="flex items-center gap-2">
<span>Showing 1 of 1 pending shifting and credit validation applications</span>
<span class="w-1.5 h-1.5 rounded-full bg-outline-variant"></span>
<span class="font-code-sm text-code-sm">Ledger Hash: 9F20-USEP-CAS</span>
</div>
<div class="flex items-center gap-1">
<button class="w-8 h-8 rounded-lg flex items-center justify-center text-outline-variant bg-surface-container-low cursor-not-allowed" disabled="">
<span class="material-symbols-outlined text-[18px]">chevron_left</span>
</button>
<span class="px-3 py-1 rounded-lg bg-primary text-on-primary font-label-sm text-label-sm font-bold">1</span>
<button class="w-8 h-8 rounded-lg flex items-center justify-center text-outline-variant bg-surface-container-low cursor-not-allowed" disabled="">
<span class="material-symbols-outlined text-[18px]">chevron_right</span>
</button>
</div>
</div>
</div>
<!-- Deep Evaluation & Curriculum Checklist Dual-Panel -->
<div class="grid grid-cols-1 lg:grid-cols-12 gap-space-lg items-start">
<!-- Left Panel: Curriculum Equivalency & Credited Units Audit (8 Cols) -->
<div class="lg:col-span-8 bg-surface-container-lowest rounded-xl p-space-md shadow-sm flex flex-col gap-space-md">
<div class="flex flex-col sm:flex-row sm:items-center justify-between gap-space-xs border-b border-transparent">
<div class="flex items-center gap-2">
<span class="material-symbols-outlined text-primary text-[22px]">checklist_rtl</span>
<div>
<h2 class="font-headline-md text-headline-md text-on-surface font-bold">Curriculum Equivalency Matrix</h2>
<span class="font-body-sm text-body-sm text-on-surface-variant">Validated against CHED CMO 34 s. 2017 &amp; USeP CAS Academic Matrix</span>
</div>
</div>
<span class="px-2.5 py-1 rounded-full bg-secondary-fixed/50 text-on-secondary-fixed font-label-sm text-label-sm font-semibold flex items-center gap-1 self-start sm:self-auto">
<span class="material-symbols-outlined text-[14px]">verified</span>
            10 of 10 Required Subjects Mapped
          </span>
</div>
<!-- Equivalency List -->
<div class="flex flex-col gap-space-sm">
<!-- Subject 1 -->
<div class="p-space-sm rounded-lg bg-surface-container-low flex flex-col md:flex-row md:items-center justify-between gap-3">
<div class="flex items-start gap-space-sm">
<div class="w-7 h-7 rounded-full bg-primary text-on-primary flex items-center justify-center font-label-sm text-label-sm font-bold shrink-0 mt-0.5">
                GE
              </div>
<div class="flex flex-col">
<div class="flex items-center gap-2 flex-wrap">
<span class="font-label-lg text-label-lg font-bold text-on-surface">GE 101 — Understanding the Self</span>
<span class="font-code-sm text-code-sm text-on-surface-variant bg-surface-container px-1.5 py-0.5 rounded">3 Units</span>
</div>
<span class="font-body-sm text-body-sm text-on-surface-variant">Taken in BA Comm: Final Grade <span class="font-semibold text-primary">1.25</span> (PASSED)</span>
</div>
</div>
<div class="flex items-center gap-space-md self-end md:self-center">
<div class="flex flex-col text-right">
<span class="font-label-sm text-label-sm text-secondary font-bold">1:1 EQUIVALENT</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">BS Psych GE Core Req</span>
</div>
<span class="material-symbols-outlined text-secondary text-[22px]">check_circle</span>
</div>
</div>
<!-- Subject 2 -->
<div class="p-space-sm rounded-lg bg-surface-container-low flex flex-col md:flex-row md:items-center justify-between gap-3">
<div class="flex items-start gap-space-sm">
<div class="w-7 h-7 rounded-full bg-primary text-on-primary flex items-center justify-center font-label-sm text-label-sm font-bold shrink-0 mt-0.5">
                GE
              </div>
<div class="flex flex-col">
<div class="flex items-center gap-2 flex-wrap">
<span class="font-label-lg text-label-lg font-bold text-on-surface">GE 102 — Readings in Philippine History</span>
<span class="font-code-sm text-code-sm text-on-surface-variant bg-surface-container px-1.5 py-0.5 rounded">3 Units</span>
</div>
<span class="font-body-sm text-body-sm text-on-surface-variant">Taken in BA Comm: Final Grade <span class="font-semibold text-primary">1.00</span> (PASSED)</span>
</div>
</div>
<div class="flex items-center gap-space-md self-end md:self-center">
<div class="flex flex-col text-right">
<span class="font-label-sm text-label-sm text-secondary font-bold">1:1 EQUIVALENT</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">BS Psych GE Core Req</span>
</div>
<span class="material-symbols-outlined text-secondary text-[22px]">check_circle</span>
</div>
</div>
<!-- Subject 3 -->
<div class="p-space-sm rounded-lg bg-surface-container-low flex flex-col md:flex-row md:items-center justify-between gap-3">
<div class="flex items-start gap-space-sm">
<div class="w-7 h-7 rounded-full bg-secondary text-on-secondary flex items-center justify-center font-label-sm text-label-sm font-bold shrink-0 mt-0.5">
                PSY
              </div>
<div class="flex flex-col">
<div class="flex items-center gap-2 flex-wrap">
<span class="font-label-lg text-label-lg font-bold text-on-surface">COMM 104 → PSYCH 101 — Intro to Psychology</span>
<span class="font-code-sm text-code-sm text-on-surface-variant bg-surface-container px-1.5 py-0.5 rounded">3 Units</span>
</div>
<span class="font-body-sm text-body-sm text-on-surface-variant">Syllabus Comparison: 88% Competency Overlap Approved by Dept Chair</span>
</div>
</div>
<div class="flex items-center gap-space-md self-end md:self-center">
<div class="flex flex-col text-right">
<span class="font-label-sm text-label-sm text-secondary font-bold">SPECIAL CREDITING</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">Grade Credited: 1.50</span>
</div>
<span class="material-symbols-outlined text-secondary text-[22px]">verified</span>
</div>
</div>
<!-- Subject 4 -->
<div class="p-space-sm rounded-lg bg-surface-container-low flex flex-col md:flex-row md:items-center justify-between gap-3">
<div class="flex items-start gap-space-sm">
<div class="w-7 h-7 rounded-full bg-primary text-on-primary flex items-center justify-center font-label-sm text-label-sm font-bold shrink-0 mt-0.5">
                SCI
              </div>
<div class="flex flex-col">
<div class="flex items-center gap-2 flex-wrap">
<span class="font-label-lg text-label-lg font-bold text-on-surface">NATSCI 101 — General Biological Sciences (Lecture &amp; Lab)</span>
<span class="font-code-sm text-code-sm text-on-surface-variant bg-surface-container px-1.5 py-0.5 rounded">5 Units</span>
</div>
<span class="font-body-sm text-body-sm text-on-surface-variant">Taken in BA Comm: Final Grade <span class="font-semibold text-primary">1.50</span> (PASSED)</span>
</div>
</div>
<div class="flex items-center gap-space-md self-end md:self-center">
<div class="flex flex-col text-right">
<span class="font-label-sm text-label-sm text-secondary font-bold">PREREQ SATISFIED</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">Enables Neuroanatomy</span>
</div>
<span class="material-symbols-outlined text-secondary text-[22px]">check_circle</span>
</div>
</div>
</div>
<div class="p-space-sm rounded-lg bg-surface-container flex items-center justify-between">
<div class="flex items-center gap-2">
<span class="material-symbols-outlined text-primary text-[20px]">assignment_turned_in</span>
<span class="font-label-md text-label-md text-on-surface font-semibold">Total Credited Toward BS Psychology:</span>
</div>
<div class="flex items-center gap-space-sm">
<span class="font-headline-sm text-headline-sm font-extrabold text-primary">32 Units</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">(118 Remaining for Graduation)</span>
</div>
</div>
</div>
<!-- Right Panel: Institutional Approval & Audit Seal (4 Cols) -->
<div class="lg:col-span-4 flex flex-col gap-space-md">
<!-- Institutional Verification Card -->
<div class="bg-surface-container-lowest rounded-xl p-space-md shadow-sm flex flex-col gap-space-sm">
<div class="flex items-center gap-2">
<span class="material-symbols-outlined text-primary text-[20px]">security</span>
<span class="font-headline-sm text-headline-sm text-on-surface font-bold">Administrative Clearances</span>
</div>
<p class="font-body-sm text-body-sm text-on-surface-variant">
            Official signatures verified cryptographically via USeP PKI Root CA.
          </p>
<div class="flex flex-col gap-3 mt-2">
<!-- Endorsement 1 -->
<div class="p-space-sm rounded-lg bg-surface-container-low flex items-center justify-between">
<div class="flex flex-col">
<span class="font-label-md text-label-md font-bold text-on-surface">Dr. Arlene M. Ramos</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">Dean, College of Arts &amp; Sciences</span>
<span class="font-code-sm text-code-sm text-secondary">PKI Sign: 0x82A1..39B</span>
</div>
<span class="px-2 py-0.5 rounded-full bg-secondary-fixed/50 text-on-secondary-fixed font-label-sm text-label-sm font-bold">Endorsed</span>
</div>
<!-- Endorsement 2 -->
<div class="p-space-sm rounded-lg bg-surface-container-low flex items-center justify-between">
<div class="flex flex-col">
<span class="font-label-md text-label-md font-bold text-on-surface">Prof. Carlos E. Tan</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">Head, Dept of Psychology</span>
<span class="font-code-sm text-code-sm text-secondary">Accepted Slot (Quota: 45/50)</span>
</div>
<span class="px-2 py-0.5 rounded-full bg-secondary-fixed/50 text-on-secondary-fixed font-label-sm text-label-sm font-bold">Accepted</span>
</div>
<!-- Endorsement 3 (Current) -->
<div class="p-space-sm rounded-lg bg-primary-fixed/30 flex items-center justify-between">
<div class="flex flex-col">
<span class="font-label-md text-label-md font-bold text-primary">Registrar Admin Evaluator</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">Office of the University Registrar</span>
<span class="font-code-sm text-code-sm text-primary">Awaiting Final Confirmation</span>
</div>
<span class="px-2 py-0.5 rounded-full bg-primary text-on-primary font-label-sm text-label-sm font-bold">Pending</span>
</div>
</div>
<div class="mt-space-sm pt-space-sm flex flex-col gap-2">
<button class="w-full py-2.5 rounded-lg bg-primary text-on-primary hover:bg-primary-container transition-all font-label-md text-label-md font-bold shadow-sm flex items-center justify-center gap-1.5" id="btn-modal-endorse">
<span class="material-symbols-outlined text-[18px]">verified_user</span>
<span>Sign &amp; Complete Shifting</span>
</button>
<button class="w-full py-2 rounded-lg bg-surface-container hover:bg-surface-container-high text-on-surface font-label-md text-label-md transition-colors flex items-center justify-center gap-1.5" id="btn-request-deficiency">
<span class="material-symbols-outlined text-[18px]">report_problem</span>
<span>Issue Deficiency Notice</span>
</button>
</div>
</div>
<!-- Student Transcript Thumbnail Card -->
<div class="bg-surface-container-lowest rounded-xl p-space-md shadow-sm flex flex-col gap-space-xs">
<div class="flex items-center justify-between">
<span class="font-label-sm text-label-sm uppercase tracking-wider text-on-surface-variant">Attached Documentation</span>
<span class="material-symbols-outlined text-on-surface-variant text-[18px]">attach_file</span>
</div>
<div class="mt-2 flex items-center gap-3 p-2.5 rounded-lg bg-surface-container-low hover:bg-surface-container transition-colors cursor-pointer">
<div class="w-10 h-10 rounded bg-primary text-on-primary flex items-center justify-center font-bold text-headline-sm">
<span class="material-symbols-outlined text-[20px]">picture_as_pdf</span>
</div>
<div class="flex flex-col min-w-0 flex-1">
<span class="font-label-md text-label-md font-bold text-on-surface truncate">Official_Transcript_Record_2022-00612.pdf</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">2.4 MB • Certified True Copy</span>
</div>
<span class="material-symbols-outlined text-primary text-[20px]">visibility</span>
</div>
<div class="flex items-center gap-3 p-2.5 rounded-lg bg-surface-container-low hover:bg-surface-container transition-colors cursor-pointer">
<div class="w-10 h-10 rounded bg-secondary text-on-secondary flex items-center justify-center font-bold text-headline-sm">
<span class="material-symbols-outlined text-[20px]">description</span>
</div>
<div class="flex flex-col min-w-0 flex-1">
<span class="font-label-md text-label-md font-bold text-on-surface truncate">Formal_Shifting_Intent_Letter.pdf</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">1.1 MB • Signed by Student &amp; Guardian</span>
</div>
<span class="material-symbols-outlined text-secondary text-[20px]">visibility</span>
</div>
</div>
</div>
</div>
</div>
<!-- Interactive Modal: Completion Dialog (Hidden by Default) -->
<div class="fixed inset-0 z-50 bg-inverse-surface/40 backdrop-blur-sm flex items-center justify-center p-space-md opacity-0 pointer-events-none transition-opacity duration-200" id="completion-modal">
<div class="bg-surface-container-lowest rounded-xl max-w-lg w-full p-space-lg shadow-xl flex flex-col gap-space-md">
<div class="flex items-center gap-3">
<div class="w-12 h-12 rounded-full bg-primary text-on-primary flex items-center justify-center">
<span class="material-symbols-outlined text-[28px]">domain_verification</span>
</div>
<div class="flex flex-col">
<span class="font-headline-sm text-headline-sm font-bold text-on-surface">Confirm Shifting Finalization</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">Transaction Record: ACA-26068</span>
</div>
</div>
<p class="font-body-md text-body-md text-on-surface">
        Are you sure you want to approve and execute the program shift of <strong class="text-primary font-bold">Ana C. Flores (2022-00612)</strong> from <strong>BA Communication</strong> to <strong>BS Psychology</strong>?
      </p>
<div class="p-space-sm rounded-lg bg-surface-container-low flex flex-col gap-1 font-body-sm text-body-sm">
<div class="flex justify-between">
<span class="text-on-surface-variant">Credited General Education Units:</span>
<span class="font-bold text-on-surface">32 Units</span>
</div>
<div class="flex justify-between">
<span class="text-on-surface-variant">Incoming Curriculum Year:</span>
<span class="font-bold text-on-surface">Year 2, 1st Semester</span>
</div>
<div class="flex justify-between">
<span class="text-on-surface-variant">Target Department Quota:</span>
<span class="font-bold text-secondary">Updated to 46 / 50</span>
</div>
</div>
<div class="flex items-center justify-end gap-space-sm pt-space-xs">
<button class="px-space-md py-2 rounded-lg bg-surface-container text-on-surface hover:bg-surface-container-high transition-colors font-label-md text-label-md" id="btn-modal-cancel">
          Cancel
        </button>
<button class="px-space-md py-2 rounded-lg bg-primary text-on-primary hover:bg-primary-container transition-all font-label-md text-label-md font-bold shadow-sm" id="btn-modal-confirm">
          Authorize &amp; Update SIS Ledger
        </button>
</div>
</div>
</div>
<script>
    (function() {
      const modal = document.getElementById('completion-modal');
      const openBtn = document.getElementById('btn-complete-row');
      const openBtnSecondary = document.getElementById('btn-modal-endorse');
      const cancelBtn = document.getElementById('btn-modal-cancel');
      const confirmBtn = document.getElementById('btn-modal-confirm');
      const approveBtn = document.getElementById('btn-approve-row');
      const declineBtn = document.getElementById('btn-decline-row');
      const refreshBtn = document.getElementById('btn-refresh');

      function showModal() {
        if (!modal) return;
        modal.classList.remove('opacity-0', 'pointer-events-none');
        modal.classList.add('opacity-100');
      }

      function hideModal() {
        if (!modal) return;
        modal.classList.add('opacity-0', 'pointer-events-none');
        modal.classList.remove('opacity-100');
      }

      if (openBtn) openBtn.addEventListener('click', showModal);
      if (openBtnSecondary) openBtnSecondary.addEventListener('click', showModal);
      if (cancelBtn) cancelBtn.addEventListener('click', hideModal);

      if (confirmBtn) {
        confirmBtn.addEventListener('click', function() {
          this.textContent = 'Processing SIS Sync...';
          setTimeout(() => {
            hideModal();
            alert('Shifting transaction ACA-26068 finalized successfully! Student Ana C. Flores has been transferred to BS Psychology.');
            this.textContent = 'Authorize & Update SIS Ledger';
          }, 800);
        });
      }

      if (approveBtn) {
        approveBtn.addEventListener('click', function() {
          alert('CAS Shifting evaluation endorsed. Awaiting final authorization button click.');
        });
      }

      if (declineBtn) {
        declineBtn.addEventListener('click', function() {
          const reason = prompt('Please enter the institutional reason for declining this request:');
          if (reason) {
            alert('Application ACA-26068 has been flagged for rejection: ' + reason);
          }
        });
      }

      if (refreshBtn) {
        refreshBtn.addEventListener('click', function() {
          const icon = this.querySelector('.material-symbols-outlined');
          if (icon) icon.classList.add('animate-spin');
          setTimeout(() => {
            if (icon) icon.classList.remove('animate-spin');
          }, 700);
        });
      }

      // Quick filter search micro-interaction
      const searchInput = document.getElementById('table-search');
      if (searchInput) {
        searchInput.addEventListener('input', function(e) {
          const val = e.target.value.toLowerCase();
          const row = document.querySelector('tbody tr');
          if (row) {
            if (row.textContent.toLowerCase().includes(val)) {
              row.style.display = '';
            } else {
              row.style.display = 'none';
            }
          }
        });
      }
    })();
  </script>
</div></main>"""

    # We want to replace everything from <main class="..."> to </main> in admin.html with user_shifting_main
    match = re.search(r'(<main[\s\S]*?</main>)', admin_html)
    if not match:
        print("ERROR: could not find <main> in admin_html")
        return
        
    out_html = admin_html.replace(match.group(1), user_shifting_main)
    
    # Dashboard item active -> inactive
    dashboard_old = '''<a aria-current="page" class="flex items-center gap-space-sm px-space-md py-space-sm transition-colors bg-surface-container-lowest text-primary font-headline-sm rounded-lg shadow-sm font-semibold" data-path="dashboard-home" href="admin.html">
          <span class="material-symbols-outlined text-[20px] text-primary">analytics</span>
          <span class="font-body-md text-body-md font-bold">Dashboard</span>
        </a>'''
        
    dashboard_new = '''<a class="flex items-center gap-space-sm px-space-md py-space-sm rounded-lg text-primary-fixed-dim hover:bg-black/20 hover:text-on-primary transition-colors" data-path="dashboard-home" href="admin.html">
          <span class="material-symbols-outlined text-[20px]">analytics</span>
          <span class="font-body-md text-body-md">Dashboard</span>
        </a>'''
        
    out_html = out_html.replace(dashboard_old, dashboard_new)
    
    # Shifting & Transfer item inactive -> active
    shift_old = '''<a class="flex items-center gap-space-sm px-space-md py-space-sm rounded-lg text-primary-fixed-dim hover:bg-black/20 hover:text-on-primary transition-colors" href="#">
          <span class="material-symbols-outlined text-[20px]">move_up</span>
          <span class="font-body-md text-body-md">Shifting &amp; Transfer</span>
        </a>'''
        
    shift_new = '''<a aria-current="page" class="flex items-center gap-space-sm px-space-md py-space-sm transition-colors bg-surface-container-lowest text-primary font-headline-sm rounded-lg shadow-sm font-semibold" href="shifting-transfer.html">
          <span class="material-symbols-outlined text-[20px] text-primary">move_up</span>
          <span class="font-body-md text-body-md font-bold">Shifting &amp; Transfer</span>
        </a>'''
        
    out_html = out_html.replace(shift_old, shift_new)
    
    # Title update
    out_html = out_html.replace('<title>Admin Dashboard — USeP e-Registrar</title>', '<title>Shifting & Transfer — Admin Portal — USeP e-Registrar</title>')
    
    with open('e:/Registrar/dist/shifting-transfer.html', 'w', encoding='utf-8') as f:
        f.write(out_html)
        
    print("Successfully built shifting-transfer.html!")

if __name__ == '__main__':
    build_shifting()

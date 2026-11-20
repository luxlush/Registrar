import re

def build_loa():
    with open('e:/Registrar/dist/admin.html', 'r', encoding='utf-8') as f:
        admin_html = f.read()
        
    user_main = """<main class="w-full pt-16 bg-surface min-h-screen"><div class="flex flex-col w-full">
<div class="px-gutter py-space-lg flex flex-col gap-space-lg">
<!-- Header Block -->
<div class="flex flex-col lg:flex-row lg:items-center justify-between gap-space-md">
<div class="flex flex-col gap-1">
<div class="flex items-center gap-space-xs text-primary font-label-sm uppercase tracking-widest">
<span class="material-symbols-outlined text-[16px]">pause_circle</span>
<span>Registrar Operations • Clearance Ledger</span>
</div>
<h1 class="font-headline-xl text-headline-xl text-primary tracking-tight font-extrabold">
          Leave of Absence (LOA) &amp; Readmission Ledger
        </h1>
<p class="font-body-md text-on-surface-variant max-w-3xl">
          Manage approved institutional leaves, verify returnee medical &amp; guidance clearances, track Maximum Residency Rule (MRR) tenure, and re-activate student accounts.
        </p>
</div>
<div class="flex items-center gap-space-sm self-start lg:self-auto">
<button class="flex items-center gap-space-xs px-space-md py-2 rounded-lg bg-surface-container-high text-on-surface hover:bg-surface-variant transition-colors font-label-md text-label-md shadow-sm" id="resetDemoBtn">
<span class="material-symbols-outlined text-[18px]">history</span>
<span>Reset demo data</span>
</button>
<button class="flex items-center gap-space-xs px-space-md py-2 rounded-lg bg-primary text-on-primary hover:bg-primary-container transition-all font-label-md text-label-md shadow-sm">
<span class="material-symbols-outlined text-[18px]">add_circle</span>
<span>Initiate Manual Readmission</span>
</button>
</div>
</div>
<!-- Metric Summary Bento Grid -->
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-space-md">
<!-- Card 1 -->
<div class="p-space-md rounded-xl bg-surface-container-lowest shadow-sm flex flex-col justify-between">
<div class="flex items-center justify-between">
<span class="font-label-sm uppercase text-on-surface-variant tracking-wider">Active LOA Requests</span>
<span class="w-8 h-8 rounded-lg bg-surface-container-high flex items-center justify-center text-primary">
<span class="material-symbols-outlined text-[20px]">pause</span>
</span>
</div>
<div class="mt-4 flex items-baseline gap-space-xs">
<span class="font-headline-xl text-headline-xl font-bold text-on-surface">4</span>
<span class="font-label-sm text-label-sm text-secondary font-semibold">2 Awaiting Dean Endorsement</span>
</div>
<div class="mt-3 flex items-center gap-1.5 text-on-surface-variant font-body-sm text-body-sm">
<span class="w-2 h-2 rounded-full bg-secondary"></span>
<span>Fall 2026 Batch Term</span>
</div>
</div>
<!-- Card 2 -->
<div class="p-space-md rounded-xl bg-surface-container-lowest shadow-sm flex flex-col justify-between">
<div class="flex items-center justify-between">
<span class="font-label-sm uppercase text-on-surface-variant tracking-wider">Returning Students (Readmission)</span>
<span class="w-8 h-8 rounded-lg bg-secondary-fixed flex items-center justify-center text-on-secondary-fixed">
<span class="material-symbols-outlined text-[20px]">person_check</span>
</span>
</div>
<div class="mt-4 flex items-baseline gap-space-xs">
<span class="font-headline-xl text-headline-xl font-bold text-primary">1</span>
<span class="font-label-sm text-label-sm text-on-surface font-semibold">Action Required</span>
</div>
<div class="mt-3 flex items-center gap-1.5 text-on-surface-variant font-body-sm text-body-sm">
<span class="w-2 h-2 rounded-full bg-primary"></span>
<span>1 Completed Document Packet</span>
</div>
</div>
<!-- Card 3 -->
<div class="p-space-md rounded-xl bg-surface-container-lowest shadow-sm flex flex-col justify-between">
<div class="flex items-center justify-between">
<span class="font-label-sm uppercase text-on-surface-variant tracking-wider">MRR Rule Warnings</span>
<span class="w-8 h-8 rounded-lg bg-error-container flex items-center justify-center text-on-error-container">
<span class="material-symbols-outlined text-[20px]">warning</span>
</span>
</div>
<div class="mt-4 flex items-baseline gap-space-xs">
<span class="font-headline-xl text-headline-xl font-bold text-error">2</span>
<span class="font-label-sm text-label-sm text-error font-medium">&gt; 5.5 Academic Yrs</span>
</div>
<div class="mt-3 flex items-center gap-1.5 text-on-surface-variant font-body-sm text-body-sm">
<span class="w-2 h-2 rounded-full bg-error"></span>
<span>Requires VP-Academic Approval</span>
</div>
</div>
<!-- Card 4 -->
<div class="p-space-md rounded-xl bg-surface-container-lowest shadow-sm flex flex-col justify-between">
<div class="flex items-center justify-between">
<span class="font-label-sm uppercase text-on-surface-variant tracking-wider">Re-Enrolled This Term</span>
<span class="w-8 h-8 rounded-lg bg-surface-container-high flex items-center justify-center text-tertiary">
<span class="material-symbols-outlined text-[20px]">verified</span>
</span>
</div>
<div class="mt-4 flex items-baseline gap-space-xs">
<span class="font-headline-xl text-headline-xl font-bold text-on-surface">12</span>
<span class="font-label-sm text-label-sm text-on-surface-variant font-medium">Enrolled</span>
</div>
<div class="mt-3 flex items-center gap-1.5 text-on-surface-variant font-body-sm text-body-sm">
<span class="w-2 h-2 rounded-full bg-tertiary"></span>
<span>SIS accounts fully restored</span>
</div>
</div>
</div>
<!-- Academic Transactions Operational Ledger Container -->
<div class="bg-surface-container-lowest rounded-xl shadow-sm p-space-md flex flex-col gap-space-md">
<!-- Filter and Workflow Sub-Navigation -->
<div class="flex flex-col gap-space-sm">
<div class="flex flex-wrap items-center gap-2">
<a class="px-space-sm py-1.5 rounded-full bg-surface-container text-on-surface-variant hover:text-on-surface font-label-md text-label-md transition-colors" href="add-drop.html">Add/Drop &amp; Enrollment</a>
<a class="px-space-sm py-1.5 rounded-full bg-surface-container text-on-surface-variant hover:text-on-surface font-label-md text-label-md transition-colors" href="shifting-transfer.html">Shifting &amp; Transfer Evaluation</a>
<a class="px-space-sm py-1.5 rounded-full bg-surface-container text-on-surface-variant hover:text-on-surface font-label-md text-label-md transition-colors" href="#">Credit Validation &amp; Deficiencies</a>
<a class="px-space-md py-1.5 rounded-full bg-primary text-on-primary font-label-md text-label-md shadow-sm" href="loa-readmission.html">LOA &amp; Readmission</a>
<a class="px-space-sm py-1.5 rounded-full bg-surface-container text-on-surface-variant hover:text-on-surface font-label-md text-label-md transition-colors" href="graduation-verification.html">Graduation &amp; Verification</a>
</div>
<!-- Search Bar and Dropdown Controls -->
<div class="flex flex-col md:flex-row items-center gap-space-sm pt-space-xs">
<div class="relative flex-1 w-full">
<span class="material-symbols-outlined absolute left-3.5 top-1/2 -translate-y-1/2 text-on-surface-variant text-[20px]">search</span>
<input class="w-full pl-10 pr-space-md py-2.5 rounded-lg bg-surface-container-low text-on-surface placeholder:text-outline text-body-md font-body-md focus:bg-surface-container-lowest transition-all outline-none" id="ledgerSearchInput" placeholder="Search student, ID, reason, or readmission docket..." type="text"/>
</div>
<div class="flex items-center gap-space-sm w-full md:w-auto">
<select class="px-space-md py-2.5 rounded-lg bg-surface-container-low text-on-surface font-label-md text-label-md outline-none cursor-pointer">
<option>LOA &amp; Readmission</option>
<option>Medical Leave Cases</option>
<option>MRR Review Queue</option>
<option>Completed Archival</option>
</select>
<select class="px-space-md py-2.5 rounded-lg bg-surface-container-low text-on-surface font-label-md text-label-md outline-none cursor-pointer">
<option>All Colleges &amp; Units</option>
<option>College of Business Administration</option>
<option>College of Engineering</option>
<option>College of Teacher Education</option>
<option>College of Technology</option>
</select>
</div>
</div>
<!-- Filter Count Pills -->
<div class="flex items-center gap-space-xs pt-1 overflow-x-auto text-label-sm font-label-sm">
<button class="px-3 py-1 rounded-full bg-primary-container text-on-primary font-semibold">All Requests (1)</button>
<button class="px-3 py-1 rounded-full bg-surface-container text-on-surface-variant hover:text-on-surface font-medium">Returnee Applications (1)</button>
<button class="px-3 py-1 rounded-full bg-surface-container text-on-surface-variant hover:text-on-surface font-medium">Active Leaves (0)</button>
<button class="px-3 py-1 rounded-full bg-surface-container text-on-surface-variant hover:text-on-surface font-medium">Archive (0)</button>
</div>
</div>
<!-- Ledger Table -->
<div class="overflow-x-auto rounded-lg">
<table class="w-full text-left border-collapse">
<thead>
<tr class="bg-surface-container-high text-on-surface-variant uppercase text-label-sm font-label-sm tracking-wider">
<th class="py-3 px-space-md">Transaction</th>
<th class="py-3 px-space-md">Student</th>
<th class="py-3 px-space-md">Course / Academic Unit</th>
<th class="py-3 px-space-md">Clearance Status</th>
<th class="py-3 px-space-md text-right">Actions</th>
</tr>
</thead>
<tbody class="divide-y divide-surface-container-high font-body-md text-body-md text-on-surface">
<!-- Row matching Reference Image -->
<tr class="hover:bg-surface-container-low transition-colors">
<td class="py-space-md px-space-md">
<div class="flex flex-col">
<div class="flex items-center gap-space-xs">
<span class="font-headline-sm text-headline-sm font-bold text-on-surface">LOA &amp; Readmission</span>
<span class="px-1.5 py-0.5 rounded text-[10px] font-code-sm bg-secondary-fixed text-on-secondary-fixed uppercase">Returnee</span>
</div>
<span class="font-code-sm text-code-sm text-on-surface-variant mt-0.5">ACA-26043 • Readmission after one semester LOA</span>
<div class="flex items-center gap-1.5 mt-1.5">
<span class="material-symbols-outlined text-[16px] text-tertiary">check_circle</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">Cleared: 1st Sem 2025-2026 LOA</span>
</div>
</div>
</td>
<td class="py-space-md px-space-md">
<div class="flex items-center gap-space-sm">
<div class="w-10 h-10 rounded-full bg-primary-container text-on-primary font-headline-sm text-headline-sm flex items-center justify-center font-bold">
                    LR
                  </div>
<div class="flex flex-col">
<span class="font-headline-sm text-headline-sm text-on-surface font-semibold">Lea B. Ramos</span>
<span class="font-code-sm text-code-sm text-on-surface-variant">2021-01048</span>
<span class="font-body-sm text-body-sm text-secondary font-medium">Regular Standing</span>
</div>
</div>
</td>
<td class="py-space-md px-space-md">
<div class="flex flex-col">
<span class="font-label-lg text-label-lg font-semibold text-on-surface">BS Entrepreneurship</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">College of Business Administration</span>
<span class="font-code-sm text-code-sm text-on-surface-variant">Curriculum 2021-V2</span>
</div>
</td>
<td class="py-space-md px-space-md">
<div class="flex flex-col gap-1.5 items-start">
<span class="inline-flex items-center gap-1 px-3 py-1 rounded-full bg-[#1b5e20] text-white font-label-sm text-label-sm font-semibold tracking-wide">
<span class="w-1.5 h-1.5 rounded-full bg-white animate-pulse"></span>
                    Completed
                  </span>
<span class="font-body-sm text-body-sm text-on-surface-variant">
                    Eligible for S.Y. 2026-2027 Re-enrollment
                  </span>
</div>
</td>
<td class="py-space-md px-space-md text-right">
<div class="flex items-center justify-end gap-space-xs">
<button class="flex items-center gap-1 px-3 py-1.5 rounded-lg bg-surface-container text-on-surface-variant hover:bg-surface-variant transition-colors font-label-md text-label-md opacity-60 cursor-not-allowed" title="Already validated">
<span class="material-symbols-outlined text-[16px]">check</span>
<span>Approve</span>
</button>
<button class="flex items-center gap-1 px-3 py-1.5 rounded-lg bg-surface-container text-on-surface-variant hover:bg-surface-variant transition-colors font-label-md text-label-md opacity-60 cursor-not-allowed">
<span class="material-symbols-outlined text-[16px]">close</span>
<span>Decline</span>
</button>
<button class="flex items-center gap-1 px-4 py-1.5 rounded-lg bg-[#b4777a] text-white hover:bg-primary-container transition-all font-label-md text-label-md font-semibold shadow-sm">
<span>Complete</span>
</button>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<!-- Asymmetric Detailed Evaluation & Checklist Mosaic -->
<div class="grid grid-cols-1 lg:grid-cols-12 gap-space-lg">
<!-- Student Docket & Academic Standing Card (8 cols) -->
<div class="lg:col-span-8 bg-surface-container-lowest rounded-xl shadow-sm p-space-md flex flex-col gap-space-md">
<div class="flex items-center justify-between pb-space-xs">
<div class="flex items-center gap-space-xs">
<span class="material-symbols-outlined text-primary text-[22px]">assignment_turned_in</span>
<span class="font-headline-md text-headline-md text-primary">Returnee Evaluation &amp; Clearances Review</span>
</div>
<span class="px-space-sm py-1 rounded bg-surface-container text-on-surface-variant font-code-sm text-code-sm">Docket ID: ACA-26043</span>
</div>
<!-- Student Dossier Snapshot -->
<div class="grid grid-cols-1 md:grid-cols-3 gap-space-md p-space-md rounded-lg bg-surface-container-low">
<div class="flex flex-col">
<span class="font-label-sm text-label-sm text-on-surface-variant uppercase">Full Legal Name</span>
<span class="font-label-lg text-label-lg font-bold text-on-surface mt-0.5">Lea B. Ramos</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">lea.ramos@usep.edu.ph</span>
</div>
<div class="flex flex-col">
<span class="font-label-sm text-label-sm text-on-surface-variant uppercase">Approved Leave Span</span>
<span class="font-label-lg text-label-lg font-bold text-on-surface mt-0.5">1 Academic Semester</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">S.Y. 2025-2026, 2nd Semester</span>
</div>
<div class="flex flex-col">
<span class="font-label-sm text-label-sm text-on-surface-variant uppercase">Residency Rule (MRR) Status</span>
<span class="font-label-lg text-label-lg font-bold text-[#1b5e20] mt-0.5">Safe • 3.0 of 6.0 Yrs Elapsed</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">38 Units Remaining for Graduation</span>
</div>
</div>
<!-- Comprehensive Clearance Stage Progression -->
<div class="flex flex-col gap-space-sm">
<span class="font-label-sm uppercase tracking-wider text-on-surface-variant font-semibold">Institutional Clearance Sequence</span>
<div class="space-y-3">
<!-- Stage 1 -->
<div class="p-3.5 rounded-lg bg-surface-container-lowest flex items-center justify-between shadow-sm">
<div class="flex items-center gap-space-sm">
<span class="w-8 h-8 rounded-full bg-[#1b5e20] text-white flex items-center justify-center">
<span class="material-symbols-outlined text-[18px]">verified</span>
</span>
<div class="flex flex-col">
<span class="font-label-md text-label-md font-semibold text-on-surface">USeP Health Services Clinic Certificate</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">Physician Medical Clearance verified and filed • Fit to Resume Studies</span>
</div>
</div>
<span class="px-space-sm py-1 rounded bg-surface-container font-label-sm text-label-sm text-[#1b5e20] font-semibold">Verified by Dr. M. Cruz</span>
</div>
<!-- Stage 2 -->
<div class="p-3.5 rounded-lg bg-surface-container-lowest flex items-center justify-between shadow-sm">
<div class="flex items-center gap-space-sm">
<span class="w-8 h-8 rounded-full bg-[#1b5e20] text-white flex items-center justify-center">
<span class="material-symbols-outlined text-[18px]">verified</span>
</span>
<div class="flex flex-col">
<span class="font-label-md text-label-md font-semibold text-on-surface">OSAS Student Guidance &amp; Counseling Endorsement</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">Re-orientation interview conducted • Exit &amp; Re-entry documentation sealed</span>
</div>
</div>
<span class="px-space-sm py-1 rounded bg-surface-container font-label-sm text-label-sm text-[#1b5e20] font-semibold">Signed by OSAS Director</span>
</div>
<!-- Stage 3 -->
<div class="p-3.5 rounded-lg bg-surface-container-lowest flex items-center justify-between shadow-sm">
<div class="flex items-center gap-space-sm">
<span class="w-8 h-8 rounded-full bg-[#1b5e20] text-white flex items-center justify-center">
<span class="material-symbols-outlined text-[18px]">verified</span>
</span>
<div class="flex flex-col">
<span class="font-label-md text-label-md font-semibold text-on-surface">College Dean &amp; Department Chairperson Approval</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">Curriculum alignment preserved • Course block assignments unlocked</span>
</div>
</div>
<span class="px-space-sm py-1 rounded bg-surface-container font-label-sm text-label-sm text-[#1b5e20] font-semibold">Endorsed by Dean CBA</span>
</div>
<!-- Stage 4 -->
<div class="p-3.5 rounded-lg bg-surface-container-lowest flex items-center justify-between shadow-sm">
<div class="flex items-center gap-space-sm">
<span class="w-8 h-8 rounded-full bg-secondary text-white flex items-center justify-center">
<span class="material-symbols-outlined text-[18px]">lock_open</span>
</span>
<div class="flex flex-col">
<span class="font-label-md text-label-md font-semibold text-on-surface">Registrar Enrollment Portal Reactivation</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">Reactivate Student Information System (SIS) access and issue Certificate of Re-admission</span>
</div>
</div>
<button class="px-space-md py-1.5 rounded-lg bg-primary text-on-primary hover:bg-primary-container font-label-md text-label-md font-semibold shadow-sm transition-all" id="reactivateSisBtn">
                Re-activate SIS Account
              </button>
</div>
</div>
</div>
<!-- Academic Re-integration Notice Banner -->
<div class="p-space-sm rounded-lg bg-secondary-fixed flex items-start gap-space-sm text-on-secondary-fixed">
<span class="material-symbols-outlined text-[20px] mt-0.5">info</span>
<div class="flex flex-col">
<span class="font-label-md text-label-md font-bold">Policy Note on Readmission After Approved LOA</span>
<span class="font-body-sm text-body-sm">
              Under USeP Code Chapter IV, Section 12: Students who went on official leave of absence for not more than one year may be readmitted directly upon submission of clinic clearance and dean endorsement without retaking the University Admission Assessment.
            </span>
</div>
</div>
</div>
<!-- Quick Action Console & Clearance Summary (4 cols) -->
<div class="lg:col-span-4 flex flex-col gap-space-md">
<!-- Action Rail Box -->
<div class="bg-surface-container-lowest rounded-xl shadow-sm p-space-md flex flex-col gap-space-md">
<div class="flex items-center gap-space-xs text-primary font-headline-sm text-headline-sm font-bold">
<span class="material-symbols-outlined text-[20px]">print</span>
<span>Documents &amp; Output</span>
</div>
<p class="font-body-sm text-body-sm text-on-surface-variant">
            Generate institutional administrative forms, certification receipts, and official return slips for Lea B. Ramos.
          </p>
<div class="flex flex-col gap-2">
<button class="w-full flex items-center justify-between px-space-md py-2.5 rounded-lg bg-surface-container-low hover:bg-surface-container text-on-surface transition-colors font-label-md text-label-md">
<div class="flex items-center gap-2">
<span class="material-symbols-outlined text-[18px] text-primary">description</span>
<span>Print Returnee Slip (Form 104)</span>
</div>
<span class="material-symbols-outlined text-[16px] text-on-surface-variant">download</span>
</button>
<button class="w-full flex items-center justify-between px-space-md py-2.5 rounded-lg bg-surface-container-low hover:bg-surface-container text-on-surface transition-colors font-label-md text-label-md">
<div class="flex items-center gap-2">
<span class="material-symbols-outlined text-[18px] text-primary">badge</span>
<span>Issue Certificate of Eligibility</span>
</div>
<span class="material-symbols-outlined text-[16px] text-on-surface-variant">download</span>
</button>
<button class="w-full flex items-center justify-between px-space-md py-2.5 rounded-lg bg-surface-container-low hover:bg-surface-container text-on-surface transition-colors font-label-md text-label-md">
<div class="flex items-center gap-2">
<span class="material-symbols-outlined text-[18px] text-primary">verified_user</span>
<span>Export Audit Log Trail</span>
</div>
<span class="material-symbols-outlined text-[16px] text-on-surface-variant">file_open</span>
</button>
</div>
<div class="pt-space-xs">
<button class="w-full py-2.5 rounded-lg bg-primary text-on-primary hover:bg-primary-container font-label-lg text-label-lg font-bold shadow-md transition-all flex items-center justify-center gap-2" id="finalCompleteBtn">
<span class="material-symbols-outlined text-[20px]">task_alt</span>
<span>Finalize &amp; Seal Ledger Entry</span>
</button>
</div>
</div>
<!-- System Activity Ledger -->
<div class="bg-surface-container-lowest rounded-xl shadow-sm p-space-md flex flex-col gap-space-sm">
<div class="flex items-center justify-between">
<span class="font-label-sm uppercase tracking-wider text-on-surface-variant font-bold">Audit History</span>
<span class="font-code-sm text-code-sm text-on-surface-variant">Live</span>
</div>
<div class="space-y-3 text-body-sm text-body-sm pt-2">
<div class="flex gap-2">
<span class="w-1.5 h-1.5 rounded-full bg-primary mt-1.5 flex-shrink-0"></span>
<div class="flex flex-col">
<span class="font-semibold text-on-surface">Clinic Clearance Verified</span>
<span class="text-on-surface-variant font-code-sm text-[11px]">Today at 09:24 AM by Clinic Staff</span>
</div>
</div>
<div class="flex gap-2">
<span class="w-1.5 h-1.5 rounded-full bg-primary mt-1.5 flex-shrink-0"></span>
<div class="flex flex-col">
<span class="font-semibold text-on-surface">OSAS Re-admission Interview Passed</span>
<span class="text-on-surface-variant font-code-sm text-[11px]">Yesterday at 03:15 PM by OSAS Counselor</span>
</div>
</div>
<div class="flex gap-2">
<span class="w-1.5 h-1.5 rounded-full bg-primary mt-1.5 flex-shrink-0"></span>
<div class="flex flex-col">
<span class="font-semibold text-on-surface">Dean Endorsement Signed</span>
<span class="text-on-surface-variant font-code-sm text-[11px]">2 days ago by CBA Dean</span>
</div>
</div>
</div>
</div>
</div>
</div>
<!-- Institutional Footer Compliance Statement -->
<div class="py-space-md flex flex-col sm:flex-row items-center justify-between text-on-surface-variant text-body-sm font-body-sm gap-space-sm">
<div class="flex items-center gap-2">
<span class="material-symbols-outlined text-[18px]">verified</span>
<span>University of Southeastern Philippines • Office of the University Registrar • Official Digital Ledger</span>
</div>
<div class="flex items-center gap-space-md font-label-sm text-label-sm">
<a class="hover:text-primary transition-colors" href="#">Academic Residency Code</a>
<span>•</span>
<a class="hover:text-primary transition-colors" href="#">Data Privacy Compliance</a>
<span>•</span>
<a class="hover:text-primary transition-colors" href="#">Audit Protocol</a>
</div>
</div>
</div>
</div>
<script>
  // Interactive behavior for Ledger demonstration
  const searchInput = document.getElementById('ledgerSearchInput');
  const reactivateBtn = document.getElementById('reactivateSisBtn');
  const finalizeBtn = document.getElementById('finalCompleteBtn');
  const resetBtn = document.getElementById('resetDemoBtn');

  if (reactivateBtn) {
    reactivateBtn.addEventListener('click', () => {
      reactivateBtn.disabled = true;
      reactivateBtn.innerHTML = `
        <span class="material-symbols-outlined text-[18px] animate-spin">refresh</span>
        <span>Reactivating Account...</span>
      `;
      setTimeout(() => {
        reactivateBtn.innerHTML = `
          <span class="material-symbols-outlined text-[18px]">check_circle</span>
          <span>SIS Active</span>
        `;
        reactivateBtn.classList.remove('bg-primary', 'hover:bg-primary-container');
        reactivateBtn.classList.add('bg-[#1b5e20]', 'text-white');
      }, 900);
    });
  }

  if (finalizeBtn) {
    finalizeBtn.addEventListener('click', () => {
      finalizeBtn.disabled = true;
      finalizeBtn.innerHTML = `
        <span class="material-symbols-outlined text-[20px]">lock</span>
        <span>Entry Sealed &amp; Archival Created</span>
      `;
      finalizeBtn.classList.remove('bg-primary', 'hover:bg-primary-container');
      finalizeBtn.classList.add('bg-tertiary', 'text-on-tertiary');
    });
  }

  if (resetBtn) {
    resetBtn.addEventListener('click', () => {
      location.reload();
    });
  }
</script></main>"""

    match = re.search(r'(<main[\s\S]*?</main>)', admin_html)
    if not match:
        print("ERROR: could not find <main> in admin_html")
        return
        
    out_html = admin_html.replace(match.group(1), user_main)
    
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
    
    # LOA item inactive -> active
    loa_old = '''<a class="flex items-center gap-space-sm px-space-md py-space-sm rounded-lg text-primary-fixed-dim hover:bg-black/20 hover:text-on-primary transition-colors" href="#">
          <span class="material-symbols-outlined text-[20px]">pause_circle</span>
          <span class="font-body-md text-body-md">LOA &amp; Readmission</span>
        </a>'''
        
    loa_new = '''<a aria-current="page" class="flex items-center gap-space-sm px-space-md py-space-sm transition-colors bg-surface-container-lowest text-primary font-headline-sm rounded-lg shadow-sm font-semibold" href="loa-readmission.html">
          <span class="material-symbols-outlined text-[20px] text-primary">pause_circle</span>
          <span class="font-body-md text-body-md font-bold">LOA &amp; Readmission</span>
        </a>'''
        
    out_html = out_html.replace(loa_old, loa_new)
    
    # Title update
    out_html = out_html.replace('<title>Admin Dashboard — USeP e-Registrar</title>', '<title>LOA & Readmission — Admin Portal — USeP e-Registrar</title>')
    
    with open('e:/Registrar/dist/loa-readmission.html', 'w', encoding='utf-8') as f:
        f.write(out_html)
        
    print("Successfully built loa-readmission.html!")

if __name__ == '__main__':
    build_loa()

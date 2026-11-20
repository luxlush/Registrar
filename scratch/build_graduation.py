import re
import os

def build_graduation():
    with open('e:/Registrar/dist/admin.html', 'r', encoding='utf-8') as f:
        admin_html = f.read()
        
    user_main = """<main class="w-full pt-16 bg-surface min-h-screen"><div class="flex flex-col w-full">
<div class="px-gutter py-space-lg flex flex-col gap-space-lg">
<!-- Header Block -->
<div class="flex flex-col md:flex-row md:items-end justify-between gap-space-md">
<div class="flex flex-col gap-1">
<div class="flex items-center gap-space-xs text-primary font-label-sm text-label-sm uppercase tracking-wider">
<span class="w-2 h-2 rounded-full bg-primary inline-block"></span>
<span>Registrar Operations • Official Ledger</span>
</div>
<h1 class="font-headline-xl text-headline-xl text-primary font-bold tracking-tight">
          Graduation Verification &amp; Evaluation Ledger
        </h1>
<p class="font-body-md text-body-md text-on-surface-variant max-w-3xl">
          Audit curriculum checklist completions, Latin honor qualifications, and Board of Regents commencement endorsements for Academic Year 2026-2027.
        </p>
</div>
<div class="flex items-center gap-space-sm self-start md:self-auto">
<button class="px-space-md py-2 bg-surface-container-high hover:bg-surface-container-highest text-on-surface font-label-md text-label-md rounded-lg flex items-center gap-2 transition-colors shadow-sm">
<span class="material-symbols-outlined text-[18px]">history</span>
<span>Audit History</span>
</button>
<button class="px-space-md py-2 bg-primary hover:bg-primary-container text-on-primary font-label-md text-label-md rounded-lg flex items-center gap-2 transition-all shadow-md">
<span class="material-symbols-outlined text-[18px]">verified</span>
<span>BOR Endorsement Docket</span>
</button>
</div>
</div>
<!-- Metric KPI Bento Grid -->
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-space-md">
<!-- KPI 1 -->
<div class="bg-surface-container-lowest p-space-md rounded-xl shadow-sm flex flex-col justify-between gap-space-sm relative overflow-hidden group hover:shadow-md transition-shadow">
<div class="flex items-start justify-between">
<span class="font-label-sm text-label-sm uppercase tracking-wider text-on-surface-variant font-semibold">Candidates for Conferment</span>
<span class="p-2 rounded-lg bg-surface-container-low text-primary">
<span class="material-symbols-outlined text-[20px]">school</span>
</span>
</div>
<div class="flex items-baseline gap-2">
<span class="font-headline-xl text-headline-xl font-bold text-on-surface">148</span>
<span class="font-label-sm text-label-sm text-secondary font-medium">Batch 2026</span>
</div>
<div class="w-full bg-surface-container-high h-1.5 rounded-full overflow-hidden">
<div class="bg-primary h-full rounded-full" style="width: 100%;"></div>
</div>
</div>
<!-- KPI 2 -->
<div class="bg-surface-container-lowest p-space-md rounded-xl shadow-sm flex flex-col justify-between gap-space-sm relative overflow-hidden group hover:shadow-md transition-shadow">
<div class="flex items-start justify-between">
<span class="font-label-sm text-label-sm uppercase tracking-wider text-on-surface-variant font-semibold">Final Audit Cleared</span>
<span class="p-2 rounded-lg bg-surface-container-low text-secondary-container">
<span class="material-symbols-outlined text-[20px]">task_alt</span>
</span>
</div>
<div class="flex items-baseline gap-2">
<span class="font-headline-xl text-headline-xl font-bold text-on-surface">147</span>
<span class="font-label-sm text-label-sm text-on-surface-variant">99.3% Rate</span>
</div>
<div class="w-full bg-surface-container-high h-1.5 rounded-full overflow-hidden">
<div class="bg-secondary-container h-full rounded-full" style="width: 99.3%;"></div>
</div>
</div>
<!-- KPI 3 -->
<div class="bg-surface-container-lowest p-space-md rounded-xl shadow-sm flex flex-col justify-between gap-space-sm relative overflow-hidden group hover:shadow-md transition-shadow">
<div class="flex items-start justify-between">
<span class="font-label-sm text-label-sm uppercase tracking-wider text-on-surface-variant font-semibold">Deficiencies / Incomplete</span>
<span class="p-2 rounded-lg bg-error-container text-on-error-container">
<span class="material-symbols-outlined text-[20px]">pending_actions</span>
</span>
</div>
<div class="flex items-baseline gap-2">
<span class="font-headline-xl text-headline-xl font-bold text-error">1</span>
<span class="font-label-sm text-label-sm text-error font-semibold">Action Required</span>
</div>
<div class="w-full bg-surface-container-high h-1.5 rounded-full overflow-hidden">
<div class="bg-error h-full rounded-full" style="width: 0.7%;"></div>
</div>
</div>
<!-- KPI 4 -->
<div class="bg-surface-container-lowest p-space-md rounded-xl shadow-sm flex flex-col justify-between gap-space-sm relative overflow-hidden group hover:shadow-md transition-shadow">
<div class="flex items-start justify-between">
<span class="font-label-sm text-label-sm uppercase tracking-wider text-on-surface-variant font-semibold">Latin Honors Shortlist</span>
<span class="p-2 rounded-lg bg-secondary-fixed text-on-secondary-fixed">
<span class="material-symbols-outlined text-[20px]">military_tech</span>
</span>
</div>
<div class="flex items-baseline gap-2">
<span class="font-headline-xl text-headline-xl font-bold text-on-surface">24</span>
<span class="font-code-sm text-code-sm text-on-surface-variant">S:1 • M:8 • C:15</span>
</div>
<div class="flex items-center gap-1">
<span class="px-1.5 py-0.5 rounded bg-secondary text-on-secondary font-label-sm text-label-sm">Summa: 1</span>
<span class="px-1.5 py-0.5 rounded bg-surface-container-high text-on-surface font-label-sm text-label-sm">Magna: 8</span>
<span class="px-1.5 py-0.5 rounded bg-surface-container-high text-on-surface font-label-sm text-label-sm">Cum: 15</span>
</div>
</div>
</div>
<!-- Ledger Command Center & Navigation Filter Tabs -->
<div class="bg-surface-container-lowest p-space-md rounded-xl shadow-sm flex flex-col gap-space-md">
<!-- Search and Secondary Dropdown -->
<div class="flex flex-col lg:flex-row items-stretch lg:items-center gap-space-sm">
<div class="relative flex-1">
<span class="material-symbols-outlined absolute left-3.5 top-1/2 -translate-y-1/2 text-[20px] text-outline">search</span>
<input class="w-full pl-11 pr-4 py-2.5 bg-surface-container-low rounded-lg text-on-surface font-body-md text-body-md focus:bg-surface-container-lowest focus:outline-none focus:ring-2 focus:ring-primary shadow-inner" placeholder="Search by student, ID, course, or transaction..." type="text" value="Mark T. Lim"/>
</div>
<div class="flex items-center gap-space-sm">
<select class="px-space-md py-2.5 bg-surface-container-low text-on-surface font-label-md text-label-md rounded-lg focus:outline-none focus:ring-2 focus:ring-primary shadow-inner cursor-pointer">
<option>All Colleges (Engineering, Computing, Arts)</option>
<option selected="">College of Engineering (CoE)</option>
<option>College of Information and Computing (CIC)</option>
<option>College of Applied Economics (CAEc)</option>
<option>College of Teacher Education and Technology (CTET)</option>
</select>
<button class="p-2.5 bg-surface-container-low hover:bg-surface-container text-on-surface-variant rounded-lg transition-colors" title="Export Ledger">
<span class="material-symbols-outlined text-[20px]">download</span>
</button>
</div>
</div>
<!-- Transaction Category Pills -->
<div class="flex items-center gap-2 overflow-x-auto pb-1">
<button class="px-space-md py-1.5 rounded-full font-label-md text-label-md whitespace-nowrap bg-surface-container-low text-on-surface-variant hover:bg-surface-container hover:text-on-surface transition-colors">
          Add/Drop &amp; Enrollment
        </button>
<button class="px-space-md py-1.5 rounded-full font-label-md text-label-md whitespace-nowrap bg-surface-container-low text-on-surface-variant hover:bg-surface-container hover:text-on-surface transition-colors">
          Shifting &amp; Transfer Evaluation
        </button>
<button class="px-space-md py-1.5 rounded-full font-label-md text-label-md whitespace-nowrap bg-surface-container-low text-on-surface-variant hover:bg-surface-container hover:text-on-surface transition-colors">
          Credit Validation &amp; Deficiencies
        </button>
<button class="px-space-md py-1.5 rounded-full font-label-md text-label-md whitespace-nowrap bg-surface-container-low text-on-surface-variant hover:bg-surface-container hover:text-on-surface transition-colors">
          LOA &amp; Readmission
        </button>
<button class="px-space-md py-1.5 rounded-full font-label-md text-label-md whitespace-nowrap bg-primary text-on-primary shadow-sm flex items-center gap-1.5">
<span class="material-symbols-outlined text-[16px]">school</span>
<span>Graduation &amp; Verification</span>
</button>
</div>
</div>
<!-- Active Candidate Spotlight & Detailed Evaluation Ledger Row -->
<div class="bg-surface-container-lowest rounded-xl shadow-sm overflow-hidden flex flex-col">
<div class="px-space-md py-space-sm bg-surface-container-low flex items-center justify-between">
<span class="font-label-sm text-label-sm uppercase tracking-wider text-on-surface-variant font-bold">
          Primary Verification Case • Docket ACA-26055
        </span>
<div class="flex items-center gap-2">
<span class="w-2 h-2 rounded-full bg-secondary animate-pulse"></span>
<span class="font-code-sm text-code-sm text-on-surface-variant">Live Synchronized BOR Session</span>
</div>
</div>
<!-- Main Ledger Table Layout -->
<div class="overflow-x-auto">
<table class="w-full text-left border-collapse">
<thead>
<tr class="bg-surface-container-high/40 text-on-surface-variant font-label-sm text-label-sm uppercase tracking-wider">
<th class="py-3 px-space-md">Transaction</th>
<th class="py-3 px-space-md">Student</th>
<th class="py-3 px-space-md">Course &amp; College</th>
<th class="py-3 px-space-md">Curriculum &amp; Honors</th>
<th class="py-3 px-space-md">Status</th>
<th class="py-3 px-space-md text-right">Actions</th>
</tr>
</thead>
<tbody class="divide-y divide-surface-container font-body-md text-body-md">
<tr class="bg-surface-container-lowest hover:bg-surface-container-low/50 transition-colors">
<td class="py-4 px-space-md align-top">
<div class="flex flex-col">
<span class="font-headline-sm text-headline-sm text-on-surface font-semibold">Graduation &amp; Verification</span>
<span class="font-code-sm text-code-sm text-on-surface-variant">ACA-26055</span>
<span class="font-body-sm text-body-sm text-on-surface-variant mt-1">Final graduation evaluation</span>
</div>
</td>
<td class="py-4 px-space-md align-top">
<div class="flex items-center gap-space-sm">
<div class="w-10 h-10 rounded-full bg-primary-fixed text-on-primary-fixed flex items-center justify-center font-bold text-headline-sm shrink-0">
                    ML
                  </div>
<div class="flex flex-col">
<span class="font-headline-sm text-headline-sm text-on-surface font-semibold">Mark T. Lim</span>
<span class="font-code-sm text-code-sm text-on-surface-variant">2020-00389</span>
<span class="font-label-sm text-label-sm text-secondary font-medium">Regular Resident Student</span>
</div>
</div>
</td>
<td class="py-4 px-space-md align-top">
<div class="flex flex-col">
<span class="font-headline-sm text-headline-sm text-on-surface font-semibold">BS Civil Engineering</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">College of Engineering</span>
<span class="font-label-sm text-label-sm text-on-surface-variant mt-1">Curriculum CMO 92 s. 2017</span>
</div>
</td>
<td class="py-4 px-space-md align-top">
<div class="flex flex-col gap-1">
<div class="flex items-center gap-1.5 text-secondary font-label-md text-label-md font-bold">
<span class="material-symbols-outlined text-[16px]">stars</span>
<span>Magna Cum Laude Candidate</span>
</div>
<span class="font-code-sm text-code-sm text-on-surface-variant">GWA: 1.34 • 0 Failures / Dropped</span>
<span class="font-label-sm text-label-sm text-on-surface-variant">148 / 148 Units Completed (100%)</span>
</div>
</td>
<td class="py-4 px-space-md align-top">
<div class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-secondary-fixed text-on-secondary-fixed font-label-md text-label-md font-semibold">
<span class="w-2 h-2 rounded-full bg-secondary"></span>
<span>Ready for Pickup/Delivery</span>
</div>
<div class="mt-1 font-body-sm text-body-sm text-on-surface-variant">
                  Dean &amp; VPAA Signatures Confirmed
                </div>
</td>
<td class="py-4 px-space-md align-top text-right">
<div class="flex items-center justify-end gap-2">
<button class="px-3 py-1.5 bg-surface-container-high hover:bg-surface-container-highest text-on-surface font-label-md text-label-md rounded-lg flex items-center gap-1 transition-colors">
<span class="material-symbols-outlined text-[16px]">check</span>
<span>Approve</span>
</button>
<button class="px-3 py-1.5 bg-surface-container-high hover:bg-surface-container-highest text-error font-label-md text-label-md rounded-lg flex items-center gap-1 transition-colors">
<span class="material-symbols-outlined text-[16px]">close</span>
<span>Decline</span>
</button>
<button class="px-4 py-1.5 bg-primary hover:bg-primary-container text-on-primary font-label-md text-label-md rounded-lg font-semibold shadow transition-all">
                    Complete
                  </button>
</div>
</td>
</tr>
</tbody>
</table>
</div>
<!-- Expandable Deep Audit Drawer / Curriculum Completion Breakdown -->
<div class="p-space-lg bg-surface-container-low flex flex-col lg:flex-row gap-space-lg">
<!-- Left: Academic Audit & Unit Completion Progress -->
<div class="flex-1 flex flex-col gap-space-md bg-surface-container-lowest p-space-md rounded-xl shadow-sm">
<div class="flex items-center justify-between">
<div class="flex items-center gap-2">
<span class="p-1.5 rounded-lg bg-primary-fixed text-on-primary-fixed">
<span class="material-symbols-outlined text-[18px]">verified_user</span>
</span>
<span class="font-headline-sm text-headline-sm text-on-surface font-bold">Curriculum Compliance Audit Matrix</span>
</div>
<span class="font-label-sm text-label-sm px-2.5 py-1 bg-secondary text-on-secondary rounded-full font-bold uppercase tracking-wider">
              148 of 148 Units Cleared
            </span>
</div>
<!-- Unit Breakdown Progress Bars -->
<div class="grid grid-cols-1 sm:grid-cols-2 gap-space-md pt-2">
<!-- Major -->
<div class="flex flex-col gap-1 p-space-sm bg-surface-container-low rounded-lg">
<div class="flex justify-between items-center font-label-md text-label-md">
<span class="text-on-surface font-semibold">Major Professional Courses</span>
<span class="font-code-sm text-code-sm text-secondary font-bold">88 / 88 Units</span>
</div>
<div class="w-full bg-surface-container-high h-2 rounded-full overflow-hidden">
<div class="bg-primary h-full rounded-full" style="width: 100%;"></div>
</div>
<span class="font-body-sm text-body-sm text-on-surface-variant">Includes Capstone Project I &amp; II (Passed: 1.25)</span>
</div>
<!-- General Ed -->
<div class="flex flex-col gap-1 p-space-sm bg-surface-container-low rounded-lg">
<div class="flex justify-between items-center font-label-md text-label-md">
<span class="text-on-surface font-semibold">General Education Core</span>
<span class="font-code-sm text-code-sm text-secondary font-bold">36 / 36 Units</span>
</div>
<div class="w-full bg-surface-container-high h-2 rounded-full overflow-hidden">
<div class="bg-primary h-full rounded-full" style="width: 100%;"></div>
</div>
<span class="font-body-sm text-body-sm text-on-surface-variant">All CHED mandatory competencies verified</span>
</div>
<!-- Practicum / OJT -->
<div class="flex flex-col gap-1 p-space-sm bg-surface-container-low rounded-lg">
<div class="flex justify-between items-center font-label-md text-label-md">
<span class="text-on-surface font-semibold">Practicum / On-the-Job Training</span>
<span class="font-code-sm text-code-sm text-secondary font-bold">6 / 6 Units</span>
</div>
<div class="w-full bg-surface-container-high h-2 rounded-full overflow-hidden">
<div class="bg-secondary-container h-full rounded-full" style="width: 100%;"></div>
</div>
<span class="font-body-sm text-body-sm text-on-surface-variant">DPWH Region XI • 480 Hours Completed</span>
</div>
<!-- Electives -->
<div class="flex flex-col gap-1 p-space-sm bg-surface-container-low rounded-lg">
<div class="flex justify-between items-center font-label-md text-label-md">
<span class="text-on-surface font-semibold">Technical &amp; Cognate Electives</span>
<span class="font-code-sm text-code-sm text-secondary font-bold">18 / 18 Units</span>
</div>
<div class="w-full bg-surface-container-high h-2 rounded-full overflow-hidden">
<div class="bg-primary h-full rounded-full" style="width: 100%;"></div>
</div>
<span class="font-body-sm text-body-sm text-on-surface-variant">Structural Engineering Track</span>
</div>
</div>
<!-- Non-Academic Clearance Grid -->
<div class="pt-2">
<span class="font-label-sm text-label-sm uppercase tracking-wider text-on-surface-variant font-bold block mb-2">
              Statutory &amp; Institutional Clearances
            </span>
<div class="grid grid-cols-2 sm:grid-cols-4 gap-2">
<div class="flex items-center gap-2 p-2 rounded-lg bg-surface-container-low">
<span class="material-symbols-outlined text-[18px] text-secondary">check_circle</span>
<div class="flex flex-col">
<span class="font-label-sm text-label-sm font-semibold text-on-surface">NSTP 1 &amp; 2</span>
<span class="font-code-sm text-code-sm text-on-surface-variant">ROTC Unit</span>
</div>
</div>
<div class="flex items-center gap-2 p-2 rounded-lg bg-surface-container-low">
<span class="material-symbols-outlined text-[18px] text-secondary">check_circle</span>
<div class="flex flex-col">
<span class="font-label-sm text-label-sm font-semibold text-on-surface">Physical Ed (1-4)</span>
<span class="font-code-sm text-code-sm text-on-surface-variant">8 Units Clear</span>
</div>
</div>
<div class="flex items-center gap-2 p-2 rounded-lg bg-surface-container-low">
<span class="material-symbols-outlined text-[18px] text-secondary">check_circle</span>
<div class="flex flex-col">
<span class="font-label-sm text-label-sm font-semibold text-on-surface">Main Library</span>
<span class="font-code-sm text-code-sm text-on-surface-variant">Zero Accountability</span>
</div>
</div>
<div class="flex items-center gap-2 p-2 rounded-lg bg-surface-container-low">
<span class="material-symbols-outlined text-[18px] text-secondary">check_circle</span>
<div class="flex flex-col">
<span class="font-label-sm text-label-sm font-semibold text-on-surface">Cashier &amp; Finance</span>
<span class="font-code-sm text-code-sm text-on-surface-variant">Zero Balance</span>
</div>
</div>
</div>
</div>
</div>
<!-- Right: Governance & Commencement Directives -->
<div class="w-full lg:w-80 flex flex-col gap-space-md bg-surface-container-lowest p-space-md rounded-xl shadow-sm justify-between">
<div class="flex flex-col gap-space-sm">
<span class="font-headline-sm text-headline-sm text-on-surface font-bold">Endorsement Details</span>
<div class="p-space-sm bg-surface-container-low rounded-lg flex flex-col gap-1">
<span class="font-label-sm text-label-sm text-on-surface-variant uppercase">BOR Resolution Reference</span>
<span class="font-code-sm text-code-sm font-bold text-primary">BOR-2026-RES-88</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">Enacted at 142nd Regular Board Session</span>
</div>
<div class="flex flex-col gap-1.5 pt-1">
<div class="flex items-center justify-between text-body-sm font-body-sm text-on-surface-variant">
<span>College Dean:</span>
<span class="text-on-surface font-semibold">Dr. R. Alcantara, PE</span>
</div>
<div class="flex items-center justify-between text-body-sm font-body-sm text-on-surface-variant">
<span>VPAA Sign-off:</span>
<span class="text-secondary font-semibold flex items-center gap-1">
<span class="material-symbols-outlined text-[14px]">lock</span>
<span>PKI Certified</span>
</span>
</div>
<div class="flex items-center justify-between text-body-sm font-body-sm text-on-surface-variant">
<span>Commencement Date:</span>
<span class="text-on-surface font-semibold">April 24, 2027</span>
</div>
</div>
</div>
<div class="flex flex-col gap-2 pt-space-sm">
<button class="w-full py-2 bg-secondary hover:bg-secondary/90 text-on-secondary font-label-md text-label-md rounded-lg flex items-center justify-center gap-2 shadow-sm transition-all">
<span class="material-symbols-outlined text-[18px]">verified</span>
<span>Issue Conferment Docket</span>
</button>
<button class="w-full py-2 bg-surface-container-high hover:bg-surface-container-highest text-on-surface font-label-md text-label-md rounded-lg flex items-center justify-center gap-2 transition-colors">
<span class="material-symbols-outlined text-[18px]">print</span>
<span>Print Official Clearance Slip</span>
</button>
</div>
</div>
</div>
</div>
<!-- Candidate Cohort Secondary Registry List -->
<div class="bg-surface-container-lowest rounded-xl shadow-sm p-space-md flex flex-col gap-space-md">
<div class="flex items-center justify-between">
<div class="flex items-center gap-space-xs">
<span class="font-headline-sm text-headline-sm text-on-surface font-bold">Upcoming Evaluated Batches</span>
<span class="px-2 py-0.5 rounded-full bg-surface-container-high text-on-surface font-label-sm text-label-sm">3 Records Awaiting Release</span>
</div>
<button class="text-primary hover:text-primary-container font-label-md text-label-md font-semibold flex items-center gap-1">
<span>View All Cohorts</span>
<span class="material-symbols-outlined text-[16px]">arrow_forward</span>
</button>
</div>
<div class="overflow-x-auto">
<table class="w-full text-left border-collapse">
<thead>
<tr class="bg-surface-container-high/40 text-on-surface-variant font-label-sm text-label-sm uppercase tracking-wider">
<th class="py-2.5 px-space-md">Student Candidate</th>
<th class="py-2.5 px-space-md">Program</th>
<th class="py-2.5 px-space-md">Standing</th>
<th class="py-2.5 px-space-md">GWA / Latin Honor</th>
<th class="py-2.5 px-space-md">Status</th>
<th class="py-2.5 px-space-md text-right">Action</th>
</tr>
</thead>
<tbody class="divide-y divide-surface-container font-body-md text-body-md">
<tr class="hover:bg-surface-container-low/50 transition-colors">
<td class="py-3 px-space-md">
<div class="flex items-center gap-2">
<div class="w-8 h-8 rounded-full bg-surface-container-high text-on-surface flex items-center justify-center font-bold text-label-md">
                    AS
                  </div>
<div>
<span class="font-headline-sm text-headline-sm text-on-surface font-semibold block">Althea S. Ramos</span>
<span class="font-code-sm text-code-sm text-on-surface-variant">2020-01124</span>
</div>
</div>
</td>
<td class="py-3 px-space-md">
<span class="text-on-surface">BS Computer Science</span>
<span class="block font-body-sm text-body-sm text-on-surface-variant">College of Information and Computing</span>
</td>
<td class="py-3 px-space-md">
<span class="font-label-sm text-label-sm px-2 py-0.5 rounded bg-surface-container-high text-on-surface font-semibold">146/146 Units</span>
</td>
<td class="py-3 px-space-md">
<span class="font-headline-sm text-headline-sm text-secondary font-bold">1.18 • Summa Cum Laude</span>
</td>
<td class="py-3 px-space-md">
<span class="px-2.5 py-1 rounded-full bg-secondary-fixed text-on-secondary-fixed font-label-sm text-label-sm font-semibold">
                  BOR Docket Issued
                </span>
</td>
<td class="py-3 px-space-md text-right">
<button class="px-3 py-1 bg-surface-container-high hover:bg-surface-container-highest text-on-surface font-label-md text-label-md rounded transition-colors">
                  Review
                </button>
</td>
</tr>
<tr class="hover:bg-surface-container-low/50 transition-colors">
<td class="py-3 px-space-md">
<div class="flex items-center gap-2">
<div class="w-8 h-8 rounded-full bg-surface-container-high text-on-surface flex items-center justify-center font-bold text-label-md">
                    JB
                  </div>
<div>
<span class="font-headline-sm text-headline-sm text-on-surface font-semibold block">Joshua B. Dela Cruz</span>
<span class="font-code-sm text-code-sm text-on-surface-variant">2019-04421</span>
</div>
</div>
</td>
<td class="py-3 px-space-md">
<span class="text-on-surface">BS Electronics Engineering</span>
<span class="block font-body-sm text-body-sm text-on-surface-variant">College of Engineering</span>
</td>
<td class="py-3 px-space-md">
<span class="font-label-sm text-label-sm px-2 py-0.5 rounded bg-surface-container-high text-on-surface font-semibold">154/154 Units</span>
</td>
<td class="py-3 px-space-md">
<span class="font-body-md text-body-md text-on-surface">1.62 • Magna Cum Laude</span>
</td>
<td class="py-3 px-space-md">
<span class="px-2.5 py-1 rounded-full bg-secondary-fixed text-on-secondary-fixed font-label-sm text-label-sm font-semibold">
                  BOR Docket Issued
                </span>
</td>
<td class="py-3 px-space-md text-right">
<button class="px-3 py-1 bg-surface-container-high hover:bg-surface-container-highest text-on-surface font-label-md text-label-md rounded transition-colors">
                  Review
                </button>
</td>
</tr>
<tr class="hover:bg-surface-container-low/50 transition-colors">
<td class="py-3 px-space-md">
<div class="flex items-center gap-2">
<div class="w-8 h-8 rounded-full bg-surface-container-high text-on-surface flex items-center justify-center font-bold text-label-md">
                    CV
                  </div>
<div>
<span class="font-headline-sm text-headline-sm text-on-surface font-semibold block">Catherine V. Mercado</span>
<span class="font-code-sm text-code-sm text-on-surface-variant">2020-00892</span>
</div>
</div>
</td>
<td class="py-3 px-space-md">
<span class="text-on-surface">BS Information Technology</span>
<span class="block font-body-sm text-body-sm text-on-surface-variant">College of Information and Computing</span>
</td>
<td class="py-3 px-space-md">
<span class="font-label-sm text-label-sm px-2 py-0.5 rounded bg-error-container text-on-error-container font-semibold">140/143 Units</span>
</td>
<td class="py-3 px-space-md">
<span class="font-body-md text-body-md text-on-surface-variant">1.78 • Non-Honors (INC)</span>
</td>
<td class="py-3 px-space-md">
<span class="px-2.5 py-1 rounded-full bg-error-container text-on-error-container font-label-sm text-label-sm font-semibold">
                  Deficiency Audit Flag
                </span>
</td>
<td class="py-3 px-space-md text-right">
<button class="px-3 py-1 bg-surface-container-high hover:bg-surface-container-highest text-on-surface font-label-md text-label-md rounded transition-colors">
                  Resolve
                </button>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<!-- Security & Institutional Sealing Notice -->
<div class="p-space-md bg-surface-container-low rounded-xl flex flex-col sm:flex-row items-center justify-between gap-space-sm text-on-surface-variant">
<div class="flex items-center gap-space-sm">
<span class="material-symbols-outlined text-primary text-[24px]">verified</span>
<div class="flex flex-col">
<span class="font-label-md text-label-md font-bold text-on-surface">Cryptographic PKI Document Authentication</span>
<span class="font-body-sm text-body-sm">All registrar verification approvals are digitally stamped using RSA-4096 state-grade institutional keys.</span>
</div>
</div>
<span class="font-code-sm text-code-sm text-outline shrink-0">SHA-256: 8f42e391b0...d8c</span>
</div>
</div>
</div></main>"""

    # We want to replace everything from <main class="..."> to </main> in admin.html with user_main
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
    
    # Graduation item inactive -> active
    grad_old = '''<a class="flex items-center gap-space-sm px-space-md py-space-sm rounded-lg text-primary-fixed-dim hover:bg-black/20 hover:text-on-primary transition-colors" href="#">
          <span class="material-symbols-outlined text-[20px]">school</span>
          <span class="font-body-md text-body-md">Graduation Verification</span>
        </a>'''
        
    grad_new = '''<a aria-current="page" class="flex items-center gap-space-sm px-space-md py-space-sm transition-colors bg-surface-container-lowest text-primary font-headline-sm rounded-lg shadow-sm font-semibold" href="graduation-verification.html">
          <span class="material-symbols-outlined text-[20px] text-primary">school</span>
          <span class="font-body-md text-body-md font-bold">Graduation Verification</span>
        </a>'''
        
    out_html = out_html.replace(grad_old, grad_new)
    
    # Title update
    out_html = out_html.replace('<title>Admin Dashboard — USeP e-Registrar</title>', '<title>Graduation Verification — Admin Portal — USeP e-Registrar</title>')
    
    with open('e:/Registrar/dist/graduation-verification.html', 'w', encoding='utf-8') as f:
        f.write(out_html)
        
    print("Successfully built graduation-verification.html!")

if __name__ == '__main__':
    build_graduation()

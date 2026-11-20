import re

def build_add_drop():
    with open('e:/Registrar/dist/admin.html', 'r', encoding='utf-8') as f:
        admin_html = f.read()
        
    user_add_drop_main = """<main class="w-full pt-16 bg-surface min-h-screen"><div class="flex flex-col w-full">
<div class="px-gutter-lg py-space-xl max-w-7xl mx-auto w-full space-y-space-lg">
<!-- Header Section with State University Academic Crest Badge & Meta -->
<div class="flex flex-col md:flex-row md:items-end justify-between gap-space-md">
<div class="space-y-space-xs">
<div class="flex items-center gap-space-xs">
<span class="font-label-sm text-label-sm uppercase tracking-wider text-primary font-bold">Registrar Operations</span>
<span class="w-1.5 h-1.5 rounded-full bg-outline-variant"></span>
<span class="font-label-sm text-label-sm text-on-surface-variant font-medium">SIS Integration Module</span>
</div>
<h1 class="font-headline-xl text-headline-xl text-primary font-extrabold tracking-tight">Add/Drop &amp; Enrollment Adjustment Ledger</h1>
<p class="font-body-md text-body-md text-on-surface-variant max-w-3xl">
          Evaluate and authorize subject schedule alterations, unit overloads, and prerequisite waivers in accordance with University Academic Policies.
        </p>
</div>
<div class="flex items-center gap-space-sm flex-shrink-0">
<button class="px-space-md py-2 rounded-lg bg-surface-container-high hover:bg-surface-container-highest text-on-surface font-label-md text-label-md flex items-center gap-space-xs shadow-sm transition-all duration-200" id="btn-reset-demo">
<span class="material-symbols-outlined text-[18px]">history</span>
<span>Reset demo data</span>
</button>
<button class="px-space-md py-2 rounded-lg bg-primary text-on-primary hover:bg-primary-container font-label-md text-label-md flex items-center gap-space-xs shadow-md transition-all duration-200">
<span class="material-symbols-outlined text-[18px]">publish</span>
<span>Batch SIS Sync</span>
</button>
</div>
</div>
<!-- Term Context & Countdown Alert Banner -->
<div class="grid grid-cols-1 lg:grid-cols-12 gap-space-md">
<div class="lg:col-span-8 rounded-xl bg-surface-container-lowest p-space-md shadow-sm flex flex-col sm:flex-row sm:items-center justify-between gap-space-md">
<div class="flex items-center gap-space-md">
<div class="w-12 h-12 rounded-xl bg-primary-fixed flex items-center justify-center text-primary">
<span class="material-symbols-outlined text-[26px]">calendar_today</span>
</div>
<div>
<div class="font-label-sm text-label-sm uppercase tracking-wider text-outline font-semibold">Active Academic Term</div>
<div class="font-headline-sm text-headline-sm text-on-surface">S.Y. 2026-2027 • 1st Semester</div>
<div class="font-body-sm text-body-sm text-on-surface-variant">Regular Student Adjustment &amp; Section Transfer Period</div>
</div>
</div>
<div class="flex sm:flex-col items-end justify-between sm:justify-center">
<span class="inline-flex items-center gap-1.5 px-space-sm py-1 rounded-full bg-surface-container-high text-on-surface font-label-sm text-label-sm font-semibold">
<span class="w-2 h-2 rounded-full bg-secondary-container animate-pulse"></span>
            Window Active
          </span>
<span class="font-code-sm text-code-sm text-on-surface-variant sm:mt-1">Policy: IRR-2024-C</span>
</div>
</div>
<div class="lg:col-span-4 rounded-xl bg-secondary-fixed/40 p-space-md shadow-sm flex items-center gap-space-md">
<div class="w-11 h-11 rounded-xl bg-secondary text-on-secondary flex items-center justify-center flex-shrink-0">
<span class="material-symbols-outlined text-[24px]">hourglass_top</span>
</div>
<div class="space-y-0.5">
<div class="font-label-sm text-label-sm uppercase tracking-wider text-on-secondary-fixed-variant font-bold">Enforcement Cut-off</div>
<div class="font-headline-sm text-headline-sm text-on-secondary-fixed font-bold">Closes in 4 Days</div>
<div class="font-body-sm text-body-sm text-on-secondary-fixed-variant">October 20, 2026 • 23:59 PST</div>
</div>
</div>
</div>
<!-- Search, College Filters & Ledger Classification Pills -->
<div class="space-y-space-sm">
<div class="flex flex-col md:flex-row gap-space-sm items-stretch">
<div class="relative flex-1">
<span class="material-symbols-outlined absolute left-3.5 top-1/2 -translate-y-1/2 text-on-surface-variant text-[20px]">search</span>
<input class="w-full pl-10 pr-4 py-2.5 rounded-lg bg-surface-container-lowest text-on-surface font-body-md text-body-md placeholder-on-surface-variant/60 shadow-sm focus:outline-none focus:ring-2 focus:ring-primary focus:bg-surface-container-lowest transition-all" id="ledger-search-input" placeholder="Search by student name, ID, course, or subject code..." type="text"/>
</div>
<div class="flex gap-space-sm items-center">
<select class="px-space-md py-2.5 rounded-lg bg-surface-container-lowest text-on-surface font-label-md text-label-md shadow-sm focus:outline-none focus:ring-2 focus:ring-primary cursor-pointer">
<option value="all">All Colleges</option>
<option value="cic">College of Information and Computing (CIC)</option>
<option value="cas">College of Arts and Sciences (CAS)</option>
<option value="coe">College of Engineering (CoE)</option>
<option value="cba">College of Business Administration (CBA)</option>
</select>
<select class="px-space-md py-2.5 rounded-lg bg-surface-container-lowest text-on-surface font-label-md text-label-md shadow-sm focus:outline-none focus:ring-2 focus:ring-primary cursor-pointer">
<option value="all-txn">Add/Drop &amp; Enrollment</option>
<option value="overload">Unit Overload Waiver</option>
<option value="cross">Cross-Enrollment Approval</option>
<option value="simultaneous">Simultaneous Prerequisite</option>
</select>
</div>
</div>
<!-- Navigation & Category Filter Pills -->
<div class="flex items-center gap-space-xs overflow-x-auto pb-1">
<button class="px-space-md py-1.5 rounded-full bg-primary text-on-primary font-label-md text-label-md shadow-sm transition-colors whitespace-nowrap">
          Add/Drop &amp; Enrollment (1)
        </button>
<button class="px-space-md py-1.5 rounded-full bg-surface-container-lowest text-on-surface-variant hover:text-on-surface hover:bg-surface-container-high font-label-md text-label-md transition-colors whitespace-nowrap shadow-sm">
          Pending Dean Endorsement (1)
        </button>
<button class="px-space-md py-1.5 rounded-full bg-surface-container-lowest text-on-surface-variant hover:text-on-surface hover:bg-surface-container-high font-label-md text-label-md transition-colors whitespace-nowrap shadow-sm">
          Registrar Authorized (0)
        </button>
<button class="px-space-md py-1.5 rounded-full bg-surface-container-lowest text-on-surface-variant hover:text-on-surface hover:bg-surface-container-high font-label-md text-label-md transition-colors whitespace-nowrap shadow-sm">
          Declined / Rejected (0)
        </button>
<div class="h-4 w-[1px] bg-surface-container-highest mx-1 flex-shrink-0"></div>
<button class="px-space-md py-1.5 rounded-full bg-surface-container-low text-outline font-label-md text-label-md hover:bg-surface-container-high transition-colors whitespace-nowrap">
          Shifting &amp; Transfer Evaluation
        </button>
<button class="px-space-md py-1.5 rounded-full bg-surface-container-low text-outline font-label-md text-label-md hover:bg-surface-container-high transition-colors whitespace-nowrap">
          Credit Validation &amp; Deficiencies
        </button>
<button class="px-space-md py-1.5 rounded-full bg-surface-container-low text-outline font-label-md text-label-md hover:bg-surface-container-high transition-colors whitespace-nowrap">
          Graduation Verification
        </button>
</div>
</div>
<!-- Master Transaction Card & Inspection Details Grid -->
<div class="grid grid-cols-1 xl:grid-cols-12 gap-space-lg items-start">
<!-- Primary Transaction Record -->
<div class="xl:col-span-8 space-y-space-md">
<div class="rounded-xl bg-surface-container-lowest shadow-sm overflow-hidden transition-all duration-300">
<!-- Table Header / Card Title bar -->
<div class="px-space-lg py-space-md bg-surface-container-low flex items-center justify-between">
<div class="flex items-center gap-space-sm">
<span class="font-label-sm text-label-sm uppercase tracking-wider text-outline font-bold">Record Reference</span>
<span class="font-code-sm text-code-sm font-semibold text-primary px-space-xs py-0.5 rounded bg-primary-fixed">ACA-26071</span>
</div>
<span class="inline-flex items-center gap-1.5 px-space-sm py-0.5 rounded-full bg-secondary-fixed text-on-secondary-fixed-variant font-label-sm text-label-sm font-bold">
<span class="w-1.5 h-1.5 rounded-full bg-secondary animate-ping"></span>
              Pending Registrar Authorization
            </span>
</div>
<!-- Transaction Body -->
<div class="p-space-lg space-y-space-md">
<!-- Student Header Block -->
<div class="flex flex-col sm:flex-row sm:items-center justify-between gap-space-sm pb-space-md">
<div class="flex items-center gap-space-md">
<div class="w-12 h-12 rounded-xl bg-primary text-on-primary font-headline-md text-headline-md flex items-center justify-center font-bold shadow-sm">
                  PR
                </div>
<div>
<div class="flex items-center gap-2">
<h2 class="font-headline-md text-headline-md text-on-surface font-bold">Paolo R. Reyes</h2>
<span class="px-space-xs py-0.5 rounded text-[11px] font-semibold bg-surface-container text-on-surface-variant">Regular 3rd Year</span>
</div>
<div class="font-body-sm text-body-sm text-on-surface-variant flex flex-wrap items-center gap-x-2">
<span class="font-code-sm text-code-sm text-primary font-medium">ID: 2023-01421</span>
<span>•</span>
<span>BS Information Technology (BSIT)</span>
<span>•</span>
<span class="text-outline">College of Information and Computing</span>
</div>
</div>
</div>
<div class="text-left sm:text-right">
<span class="font-label-sm text-label-sm uppercase text-outline block">Submitted Timestamp</span>
<span class="font-body-sm text-body-sm text-on-surface font-medium">Oct 16, 2026 • 09:42 AM</span>
</div>
</div>
<!-- Subject Action Matrix & Units Validation -->
<div class="space-y-space-sm">
<div class="font-label-sm text-label-sm uppercase tracking-wider text-outline font-semibold">Subject Alteration Matrix</div>
<div class="grid grid-cols-1 md:grid-cols-2 gap-space-sm">
<!-- Drop Panel -->
<div class="rounded-xl bg-error-container/25 p-space-md space-y-space-xs relative overflow-hidden">
<div class="flex items-center justify-between">
<span class="inline-flex items-center gap-1 text-error font-label-sm text-label-sm font-bold uppercase tracking-wider">
<span class="material-symbols-outlined text-[16px]">remove_circle</span>
                      Dropping Course Section
                    </span>
<span class="font-code-sm text-code-sm font-semibold text-error px-1.5 py-0.5 rounded bg-error-container">3.0 Units</span>
</div>
<div class="font-headline-sm text-headline-sm text-on-surface font-bold">IT 214 • Data Structures &amp; Algorithms</div>
<div class="font-body-sm text-body-sm text-on-surface-variant">
                    Section: <span class="font-semibold text-on-surface">BSIT 2-A</span> • Schedule: MWF 08:00 - 09:00 AM
                  </div>
<div class="font-body-sm text-body-sm text-on-surface-variant">
                    Instructor: Asst. Prof. Manuel Gomez • Room: ICT-302
                  </div>
<div class="pt-space-xs">
<span class="text-error font-label-sm text-label-sm italic">Reason: Schedule conflict with capstone lab mentorship session.</span>
</div>
</div>
<!-- Add Panel -->
<div class="rounded-xl bg-surface-container-high p-space-md space-y-space-xs relative overflow-hidden">
<div class="flex items-center justify-between">
<span class="inline-flex items-center gap-1 text-primary font-label-sm text-label-sm font-bold uppercase tracking-wider">
<span class="material-symbols-outlined text-[16px]">add_circle</span>
                      Adding Course Section
                    </span>
<span class="font-code-sm text-code-sm font-semibold text-primary px-1.5 py-0.5 rounded bg-primary-fixed">3.0 Units</span>
</div>
<div class="font-headline-sm text-headline-sm text-on-surface font-bold">IT 223 • Advanced Web Systems</div>
<div class="font-body-sm text-body-sm text-on-surface-variant">
                    Section: <span class="font-semibold text-on-surface">BSIT 2-C</span> • Schedule: TTh 10:30 - 12:00 PM
                  </div>
<div class="font-body-sm text-body-sm text-on-surface-variant">
                    Instructor: Assoc. Prof. Elena Santos • Room: CS-Lab 4
                  </div>
<div class="pt-space-xs flex items-center gap-1 text-secondary font-label-sm text-label-sm font-medium">
<span class="material-symbols-outlined text-[14px]">verified</span>
                    Prereq IT 122 satisfied (Grade: 1.50)
                  </div>
</div>
</div>
</div>
<!-- Units Accounting Strip -->
<div class="rounded-xl bg-surface-container p-space-md flex flex-wrap items-center justify-between gap-space-md">
<div class="flex items-center gap-space-lg">
<div>
<span class="font-label-sm text-label-sm text-outline block">Pre-Change Load</span>
<span class="font-headline-sm text-headline-sm text-on-surface font-bold">18.0 <span class="font-body-sm text-body-sm font-normal text-on-surface-variant">Units</span></span>
</div>
<div class="text-on-surface-variant font-headline-md text-headline-md">→</div>
<div>
<span class="font-label-sm text-label-sm text-outline block">Post-Change Load</span>
<span class="font-headline-sm text-headline-sm text-on-surface font-bold">18.0 <span class="font-body-sm text-body-sm font-normal text-on-surface-variant">Units</span></span>
</div>
<div class="h-8 w-[1px] bg-outline-variant/30 hidden sm:block"></div>
<div>
<span class="font-label-sm text-label-sm text-outline block">Variance Status</span>
<span class="inline-flex items-center gap-1 font-label-md text-label-md font-bold text-on-surface">
<span class="material-symbols-outlined text-[16px] text-secondary">check_circle</span>
                    Zero Net Load Delta (Balanced)
                  </span>
</div>
</div>
<div class="flex items-center gap-space-xs">
<span class="font-label-sm text-label-sm uppercase tracking-wide text-on-surface-variant">Tuition Adjustment:</span>
<span class="font-code-sm text-code-sm font-bold text-on-surface px-space-xs py-0.5 rounded bg-surface-container-high">PHP 0.00 (No differential)</span>
</div>
</div>
<!-- Supporting Endorsements & Prerequisite Waiver -->
<div class="rounded-xl bg-surface-container-low p-space-md space-y-space-sm">
<div class="flex items-center justify-between">
<span class="font-label-sm text-label-sm uppercase tracking-wider text-outline font-semibold">Academic Clearance &amp; Endorsement Chain</span>
<span class="font-label-sm text-label-sm text-secondary font-semibold">2 of 2 Approvals Logged</span>
</div>
<div class="grid grid-cols-1 md:grid-cols-2 gap-space-sm">
<div class="p-space-sm rounded-lg bg-surface-container-lowest flex items-center justify-between">
<div class="flex items-center gap-space-sm">
<span class="material-symbols-outlined text-secondary text-[22px]">check_circle</span>
<div>
<div class="font-label-md text-label-md text-on-surface font-semibold">Dept. Chair Endorsement</div>
<div class="font-body-sm text-body-sm text-on-surface-variant">Dr. Aaron T. Dizon • Oct 15, 2026</div>
</div>
</div>
<span class="px-space-xs py-0.5 rounded text-[11px] font-bold bg-surface-container-high text-on-surface">Endorsed</span>
</div>
<div class="p-space-sm rounded-lg bg-surface-container-lowest flex items-center justify-between">
<div class="flex items-center gap-space-sm">
<span class="material-symbols-outlined text-secondary text-[22px]">check_circle</span>
<div>
<div class="font-label-md text-label-md text-on-surface font-semibold">College Dean Authorization</div>
<div class="font-body-sm text-body-sm text-on-surface-variant">Dean Marissa V. Del Rosario • Oct 16, 2026</div>
</div>
</div>
<button class="px-space-xs py-1 rounded text-primary hover:bg-primary/10 font-label-sm text-label-sm font-semibold flex items-center gap-1 transition-colors" id="btn-view-dean-letter">
<span class="material-symbols-outlined text-[14px]">attachment</span>
<span>View Letter</span>
</button>
</div>
</div>
</div>
<!-- Action Controls Group -->
<div class="pt-space-sm flex flex-col sm:flex-row items-center justify-between gap-space-md">
<div class="flex items-center gap-space-xs text-on-surface-variant font-body-sm text-body-sm">
<span class="material-symbols-outlined text-[18px]">verified_user</span>
<span>Actions are audited under Registrar User: <strong>REG-ADMIN-04</strong></span>
</div>
<div class="flex items-center gap-space-sm w-full sm:w-auto justify-end">
<button class="px-space-md py-2 rounded-lg bg-surface-container-high text-error hover:bg-error-container hover:text-on-error-container font-label-md text-label-md flex items-center gap-1 transition-all" id="btn-decline-action">
<span class="material-symbols-outlined text-[18px]">close</span>
<span>Decline</span>
</button>
<button class="px-space-md py-2 rounded-lg bg-primary text-on-primary hover:bg-primary-container font-label-md text-label-md flex items-center gap-1 shadow-md hover:shadow-lg transition-all" id="btn-approve-action">
<span class="material-symbols-outlined text-[18px]">check</span>
<span>Approve &amp; Commit to SIS</span>
</button>
<button class="px-space-md py-2 rounded-lg bg-primary-container text-on-primary hover:bg-primary font-label-md text-label-md flex items-center gap-1 shadow transition-all" id="btn-complete-action">
<span class="material-symbols-outlined text-[18px]">task_alt</span>
<span>Complete</span>
</button>
</div>
</div>
</div>
</div>
<!-- System Audit Log & Remarks -->
<div class="rounded-xl bg-surface-container-lowest p-space-lg shadow-sm space-y-space-md">
<div class="flex items-center justify-between">
<h3 class="font-headline-sm text-headline-sm text-on-surface font-bold">Evaluation Remarks &amp; Internal Notes</h3>
<span class="font-label-sm text-label-sm text-outline">Confidential Registrar Record</span>
</div>
<div class="space-y-space-xs">
<textarea class="w-full p-space-sm rounded-lg bg-surface-container text-on-surface font-body-md text-body-md placeholder-on-surface-variant/60 focus:outline-none focus:ring-2 focus:ring-primary min-h-[90px] resize-none" placeholder="Add evaluation memo or specify waiver remarks for student file..."></textarea>
<div class="flex justify-between items-center pt-1">
<span class="font-body-sm text-body-sm text-on-surface-variant">Prerequisite validation auto-checked against Curricular Prospectus 2023 rev.</span>
<button class="px-space-sm py-1 rounded bg-surface-container-high text-on-surface hover:bg-surface-container-highest font-label-sm text-label-sm transition-colors">
                Save Memo
              </button>
</div>
</div>
</div>
</div>
<!-- Right Summary Rail: Conflict Matrix, Dean Attachment & Class Capacity -->
<div class="xl:col-span-4 space-y-space-md">
<!-- Schedule Conflict Resolution Engine -->
<div class="rounded-xl bg-surface-container-lowest p-space-md shadow-sm space-y-space-md">
<div class="flex items-center justify-between">
<div class="flex items-center gap-space-xs">
<div class="w-8 h-8 rounded-lg bg-surface-container-high flex items-center justify-center text-primary">
<span class="material-symbols-outlined text-[20px]">calendar_view_week</span>
</div>
<h3 class="font-headline-sm text-headline-sm text-on-surface font-bold">Schedule Conflict Check</h3>
</div>
<span class="px-space-xs py-0.5 rounded text-[11px] font-bold bg-secondary-fixed text-on-secondary-fixed">0 Overlaps</span>
</div>
<div class="p-space-sm rounded-lg bg-surface-container-low space-y-space-xs">
<div class="font-label-sm text-label-sm uppercase tracking-wider text-outline">Timetable Collision Detection</div>
<div class="flex items-start gap-space-sm">
<span class="material-symbols-outlined text-secondary text-[20px] mt-0.5">check_circle</span>
<p class="font-body-sm text-body-sm text-on-surface">
                Slot <span class="font-semibold text-on-surface">TTh 10:30-12:00 (IT 223)</span> is cleared against all 5 currently active enrolled lecture and laboratory courses.
              </p>
</div>
</div>
<!-- Weekly Visual Slot Matrix -->
<div class="space-y-1.5 pt-1">
<div class="text-[11px] font-semibold text-outline uppercase tracking-wider">Weekly Time Block Distribution</div>
<div class="grid grid-cols-5 gap-1 text-center font-label-sm text-[10px] text-on-surface-variant font-bold pb-1">
<div>MON</div>
<div>TUE</div>
<div>WED</div>
<div>THU</div>
<div>FRI</div>
</div>
<div class="grid grid-cols-5 gap-1.5 h-28 bg-surface-container rounded-lg p-2">
<div class="flex flex-col gap-1">
<div class="h-6 rounded bg-primary-fixed/60 text-primary text-[10px] font-bold flex items-center justify-center">IT 211</div>
<div class="h-8 rounded bg-surface-container-high text-[9px] flex items-center justify-center text-on-surface-variant">GE 104</div>
</div>
<div class="flex flex-col gap-1">
<div class="h-10 rounded bg-secondary-fixed text-on-secondary-fixed text-[10px] font-bold flex flex-col items-center justify-center border-l-2 border-secondary">
<span>IT 223</span>
<span class="text-[8px] font-normal">NEW</span>
</div>
</div>
<div class="flex flex-col gap-1">
<div class="h-6 rounded bg-primary-fixed/60 text-primary text-[10px] font-bold flex items-center justify-center">IT 211</div>
<div class="h-8 rounded bg-surface-container-high text-[9px] flex items-center justify-center text-on-surface-variant">GE 104</div>
</div>
<div class="flex flex-col gap-1">
<div class="h-10 rounded bg-secondary-fixed text-on-secondary-fixed text-[10px] font-bold flex flex-col items-center justify-center border-l-2 border-secondary">
<span>IT 223</span>
<span class="text-[8px] font-normal">NEW</span>
</div>
</div>
<div class="flex flex-col gap-1">
<div class="h-6 rounded bg-primary-fixed/60 text-primary text-[10px] font-bold flex items-center justify-center">IT 211</div>
<div class="h-10 rounded bg-surface-container-high text-[9px] flex items-center justify-center text-on-surface-variant">PE 3</div>
</div>
</div>
</div>
</div>
<!-- Section Capacity Diagnostic Card -->
<div class="rounded-xl bg-surface-container-lowest p-space-md shadow-sm space-y-space-md">
<div class="flex items-center justify-between">
<h3 class="font-headline-sm text-headline-sm text-on-surface font-bold">Class Capacity Allocation</h3>
<span class="font-code-sm text-code-sm text-outline">Room CS-Lab 4</span>
</div>
<div class="space-y-space-xs">
<div class="flex justify-between items-center font-label-md text-label-md">
<span class="text-on-surface">IT 223 • Section BSIT 2-C</span>
<span class="font-bold text-on-surface">38 / 40 Enrolled</span>
</div>
<!-- Visual Capacity Bar -->
<div class="w-full h-3 rounded-full bg-surface-container overflow-hidden">
<div class="h-full bg-primary rounded-full" style="width: 95%;"></div>
</div>
<div class="flex justify-between items-center font-body-sm text-body-sm text-on-surface-variant">
<span>95% Utilization</span>
<span class="text-secondary font-semibold">2 Seats Remaining</span>
</div>
</div>
<div class="rounded-lg bg-surface-container p-space-sm flex items-center gap-space-sm text-on-surface font-body-sm text-body-sm">
<span class="material-symbols-outlined text-primary text-[20px]">info</span>
<span>Registrar authorization commits the 39th seat instantly via SIS socket bridge.</span>
</div>
</div>
<!-- Dean Endorsement Attachment Quick Preview -->
<div class="rounded-xl bg-surface-container-lowest p-space-md shadow-sm space-y-space-sm">
<div class="flex items-center justify-between">
<h3 class="font-headline-sm text-headline-sm text-on-surface font-bold">Attached Waiver Document</h3>
<span class="font-label-sm text-label-sm text-primary font-bold">PDF Signed</span>
</div>
<div class="rounded-xl bg-surface-container-low p-space-md flex items-center gap-space-md">
<div class="w-10 h-10 rounded-lg bg-primary-fixed flex items-center justify-center text-primary flex-shrink-0">
<span class="material-symbols-outlined text-[24px]">picture_as_pdf</span>
</div>
<div class="min-w-0 flex-1">
<div class="font-label-md text-label-md text-on-surface font-bold truncate">Endorsement_CIC_Waiver_Reyes_P.pdf</div>
<div class="font-body-sm text-body-sm text-on-surface-variant">542 KB • Digital Signature Verified</div>
</div>
<button class="w-8 h-8 rounded-lg bg-surface-container-high hover:bg-surface-container-highest flex items-center justify-center text-on-surface transition-colors" title="Download Document">
<span class="material-symbols-outlined text-[18px]">download</span>
</button>
</div>
</div>
</div>
</div>
<!-- Ledger Pagination & Footer Metadata -->
<div class="pt-space-md flex flex-col sm:flex-row items-center justify-between gap-space-md font-body-sm text-body-sm text-on-surface-variant">
<div>
        Showing <span class="font-semibold text-on-surface">1</span> of <span class="font-semibold text-on-surface">1</span> pending registration adjustment in active queue
      </div>
<div class="flex items-center gap-space-xs">
<button class="w-8 h-8 rounded-lg bg-surface-container text-on-surface-variant/40 flex items-center justify-center cursor-not-allowed" disabled="">
<span class="material-symbols-outlined text-[18px]">chevron_left</span>
</button>
<button class="w-8 h-8 rounded-lg bg-primary text-on-primary font-label-md text-label-md flex items-center justify-center font-bold shadow-sm">
          1
        </button>
<button class="w-8 h-8 rounded-lg bg-surface-container text-on-surface-variant/40 flex items-center justify-center cursor-not-allowed" disabled="">
<span class="material-symbols-outlined text-[18px]">chevron_right</span>
</button>
</div>
</div>
</div>
<!-- Interactive Feedback Toast (Hidden by default) -->
<div class="fixed bottom-6 right-6 z-50 transform translate-y-24 opacity-0 transition-all duration-300 pointer-events-none rounded-xl bg-inverse-surface text-inverse-on-surface p-space-md shadow-2xl flex items-center gap-space-md max-w-md" id="toast-notification">
<div class="w-10 h-10 rounded-lg bg-secondary text-on-secondary flex items-center justify-center flex-shrink-0" id="toast-icon-bg">
<span class="material-symbols-outlined text-[20px]" id="toast-icon">done</span>
</div>
<div class="flex-1">
<div class="font-headline-sm text-headline-sm font-bold" id="toast-title">Action Completed</div>
<div class="font-body-sm text-body-sm text-inverse-on-surface/80" id="toast-message">The transaction has been processed.</div>
</div>
</div>
</div>
<script>
  (function() {
    const toast = document.getElementById('toast-notification');
    const toastTitle = document.getElementById('toast-title');
    const toastMessage = document.getElementById('toast-message');
    const toastIcon = document.getElementById('toast-icon');

    function showNotification(title, message, icon) {
      if (!toast) return;
      toastTitle.textContent = title;
      toastMessage.textContent = message;
      toastIcon.textContent = icon || 'done';
      
      toast.classList.remove('translate-y-24', 'opacity-0', 'pointer-events-none');
      toast.classList.add('translate-y-0', 'opacity-100');

      setTimeout(() => {
        toast.classList.remove('translate-y-0', 'opacity-100');
        toast.classList.add('translate-y-24', 'opacity-0', 'pointer-events-none');
      }, 4000);
    }

    const btnApprove = document.getElementById('btn-approve-action');
    if (btnApprove) {
      btnApprove.addEventListener('click', () => {
        showNotification(
          'Approved & Committed',
          'Transaction ACA-26071 committed to Student Information System (SIS). Student schedule updated to IT 223.',
          'task_alt'
        );
      });
    }

    const btnDecline = document.getElementById('btn-decline-action');
    if (btnDecline) {
      btnDecline.addEventListener('click', () => {
        showNotification(
          'Transaction Declined',
          'Request ACA-26071 rejected. Notification dispatched to Paolo R. Reyes and College Dean.',
          'cancel'
        );
      });
    }

    const btnComplete = document.getElementById('btn-complete-action');
    if (btnComplete) {
      btnComplete.addEventListener('click', () => {
        showNotification(
          'Marked Complete',
          'Ledger record archived into official S.Y. 2026-2027 registrar audit vault.',
          'check_circle'
        );
      });
    }

    const btnReset = document.getElementById('btn-reset-demo');
    if (btnReset) {
      btnReset.addEventListener('click', () => {
        showNotification(
          'Ledger Cache Refreshed',
          'Academic Transactions Ledger has been reset to active baseline queue.',
          'sync'
        );
      });
    }

    const btnViewLetter = document.getElementById('btn-view-dean-letter');
    if (btnViewLetter) {
      btnViewLetter.addEventListener('click', () => {
        showNotification(
          'Document Preview',
          'Opening verified digital endorsement by Dean Marissa V. Del Rosario (CIC)...',
          'description'
        );
      });
    }
  })();
</script></main>"""

    # Replace everything from <main class="..."> to </main> in admin.html
    match = re.search(r'(<main[\s\S]*?</main>)', admin_html)
    if not match:
        print("ERROR: could not find <main> in admin_html")
        return
        
    out_html = admin_html.replace(match.group(1), user_add_drop_main)
    
    # We also need to swap the active classes for the sidebar
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
    
    # Add/Drop & Enrollment item inactive -> active
    adddrop_old = '''<a class="flex items-center gap-space-sm px-space-md py-space-sm rounded-lg text-primary-fixed-dim hover:bg-black/20 hover:text-on-primary transition-colors" href="#">
          <span class="material-symbols-outlined text-[20px]">swap_calls</span>
          <span class="font-body-md text-body-md">Add/Drop &amp; Enrollment</span>
        </a>'''
        
    adddrop_new = '''<a aria-current="page" class="flex items-center gap-space-sm px-space-md py-space-sm transition-colors bg-surface-container-lowest text-primary font-headline-sm rounded-lg shadow-sm font-semibold" href="add-drop.html">
          <span class="material-symbols-outlined text-[20px] text-primary">swap_calls</span>
          <span class="font-body-md text-body-md font-bold">Add/Drop &amp; Enrollment</span>
        </a>'''
        
    out_html = out_html.replace(adddrop_old, adddrop_new)
    
    # Title update
    out_html = out_html.replace('<title>Admin Dashboard — USeP e-Registrar</title>', '<title>Add/Drop & Enrollment — Admin Portal — USeP e-Registrar</title>')
    
    with open('e:/Registrar/dist/add-drop.html', 'w', encoding='utf-8') as f:
        f.write(out_html)
        
    print("Successfully built add-drop.html!")

if __name__ == '__main__':
    build_add_drop()

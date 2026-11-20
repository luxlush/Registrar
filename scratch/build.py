import re

def build_queue():
    with open('e:/Registrar/dist/admin.html', 'r', encoding='utf-8') as f:
        admin_html = f.read()
        
    user_queue_main = """<main class="w-full pt-16 bg-surface min-h-screen"><div class="flex flex-col w-full">
<div class="p-gutter lg:p-space-xl flex flex-col gap-space-lg">
<!-- Top Action & Title Area -->
<div class="flex flex-col md:flex-row md:items-end justify-between gap-space-md">
<div class="flex flex-col gap-space-xs">
<div class="flex items-center gap-space-xs">
<span class="w-2 h-2 rounded-full bg-primary animate-pulse"></span>
<span class="font-label-sm text-label-sm uppercase tracking-wider text-primary font-bold">Registrar Operations Management</span>
</div>
<h1 class="font-headline-xl text-headline-xl text-primary font-extrabold tracking-tight">Document Request Queue</h1>
<p class="font-body-md text-body-md text-on-surface-variant max-w-2xl">
          Manage and process student and alumni credential submissions, verifications, and physical releasing protocols with live SLA tracking.
        </p>
</div>
<!-- Quick System Controls -->
<div class="flex items-center gap-space-sm flex-wrap">
<button class="flex items-center gap-space-xs px-space-sm py-2 rounded-lg bg-surface-container hover:bg-surface-container-high text-on-surface font-label-md text-label-md transition-all shadow-sm" id="refreshQueueBtn">
<span class="material-symbols-outlined text-[18px]">sync</span>
<span>Sync Real-Time Queue</span>
</button>
<button class="flex items-center gap-space-xs px-space-md py-2 rounded-lg bg-primary hover:bg-primary-container text-on-primary font-label-md text-label-md transition-all shadow-md hover:shadow-lg">
<span class="material-symbols-outlined text-[18px]">verified_user</span>
<span>Batch Authorize</span>
</button>
</div>
</div>
<!-- Summary Metrics Bar (Bento-style Pills) -->
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-space-md">
<!-- Metric 1 -->
<div class="p-space-md rounded-xl bg-surface-container-lowest shadow-sm flex items-center justify-between group hover:shadow-md transition-shadow">
<div class="flex flex-col">
<span class="font-label-sm text-label-sm text-on-surface-variant uppercase tracking-wider">Active Document Queue</span>
<span class="font-headline-lg text-headline-lg text-primary font-black mt-1">3 <span class="font-body-sm text-body-sm text-on-surface-variant font-normal">dockets</span></span>
<span class="font-code-sm text-code-sm text-secondary flex items-center gap-1 mt-1">
<span class="material-symbols-outlined text-[14px]">bolt</span> Prioritized intake
          </span>
</div>
<div class="w-12 h-12 rounded-xl bg-primary-fixed flex items-center justify-center text-primary group-hover:scale-105 transition-transform">
<span class="material-symbols-outlined text-[24px]">folder_open</span>
</div>
</div>
<!-- Metric 2 -->
<div class="p-space-md rounded-xl bg-surface-container-lowest shadow-sm flex items-center justify-between group hover:shadow-md transition-shadow">
<div class="flex flex-col">
<span class="font-label-sm text-label-sm text-on-surface-variant uppercase tracking-wider">Ready for Pickup / Courier</span>
<span class="font-headline-lg text-headline-lg text-secondary font-black mt-1">1 <span class="font-body-sm text-body-sm text-on-surface-variant font-normal">batch slip</span></span>
<span class="font-code-sm text-code-sm text-on-surface-variant flex items-center gap-1 mt-1">
<span class="w-1.5 h-1.5 rounded-full bg-secondary-container"></span> Window Counter 2
          </span>
</div>
<div class="w-12 h-12 rounded-xl bg-secondary-fixed flex items-center justify-center text-on-secondary-fixed group-hover:scale-105 transition-transform">
<span class="material-symbols-outlined text-[24px]">local_shipping</span>
</div>
</div>
<!-- Metric 3 -->
<div class="p-space-md rounded-xl bg-surface-container-lowest shadow-sm flex items-center justify-between group hover:shadow-md transition-shadow">
<div class="flex flex-col">
<span class="font-label-sm text-label-sm text-on-surface-variant uppercase tracking-wider">Under Evaluation</span>
<span class="font-headline-lg text-headline-lg text-on-surface font-black mt-1">1 <span class="font-body-sm text-body-sm text-on-surface-variant font-normal">evaluating</span></span>
<span class="font-code-sm text-code-sm text-on-surface-variant flex items-center gap-1 mt-1">
<span class="material-symbols-outlined text-[14px]">timer</span> SLA: Day 2 of 3
          </span>
</div>
<div class="w-12 h-12 rounded-xl bg-surface-container-high flex items-center justify-center text-tertiary group-hover:scale-105 transition-transform">
<span class="material-symbols-outlined text-[24px]">pending_actions</span>
</div>
</div>
<!-- Metric 4 -->
<div class="p-space-md rounded-xl bg-surface-container-lowest shadow-sm flex items-center justify-between group hover:shadow-md transition-shadow">
<div class="flex flex-col">
<span class="font-label-sm text-label-sm text-on-surface-variant uppercase tracking-wider">Pending Validation</span>
<span class="font-headline-lg text-headline-lg text-error font-black mt-1">1 <span class="font-body-sm text-body-sm text-on-surface-variant font-normal">action req.</span></span>
<span class="font-code-sm text-code-sm text-error flex items-center gap-1 mt-1">
<span class="material-symbols-outlined text-[14px]">warning</span> PSA Registry Check
          </span>
</div>
<div class="w-12 h-12 rounded-xl bg-error-container flex items-center justify-center text-on-error-container group-hover:scale-105 transition-transform">
<span class="material-symbols-outlined text-[24px]">verified</span>
</div>
</div>
</div>
<!-- Main Content Work Area -->
<div class="bg-surface-container-lowest rounded-xl shadow-md flex flex-col overflow-hidden">
<!-- Sub-header & Real-time Indicator -->
<div class="p-space-md flex flex-col md:flex-row md:items-center justify-between gap-space-sm bg-surface-container-low/50">
<div class="flex items-center gap-space-sm">
<div class="w-9 h-9 rounded-lg bg-primary-container text-on-primary flex items-center justify-center">
<span class="material-symbols-outlined text-[20px]">assignment_turned_in</span>
</div>
<div>
<h2 class="font-headline-sm text-headline-sm text-on-surface font-bold">Document Requests &amp; Records Corrections</h2>
<p class="font-body-sm text-body-sm text-on-surface-variant">Incoming live registrar transactions. Actions update student SIS and physical counter queues instantly.</p>
</div>
</div>
<div class="flex items-center gap-space-xs font-code-sm text-code-sm text-on-surface-variant self-start md:self-auto">
<span class="w-2 h-2 rounded-full bg-secondary-container"></span>
<span>Registrar API V2.4 Connected</span>
</div>
</div>
<!-- Search & Filtering Controls Area -->
<div class="p-space-md flex flex-col gap-space-sm bg-surface-container-lowest">
<div class="flex flex-col lg:flex-row items-stretch lg:items-center gap-space-sm">
<!-- Unified Search Input -->
<div class="relative flex-1">
<span class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-on-surface-variant">
<span class="material-symbols-outlined text-[18px]">search</span>
</span>
<input class="w-full pl-9 pr-4 py-2.5 bg-surface-container-low text-on-surface placeholder:text-outline font-body-md text-body-md rounded-lg focus:outline-none focus:bg-surface-container-lowest transition-colors" id="queueSearchInput" placeholder="Search by student name, ID number (e.g. 2018-00123), course, or request ref..." type="text"/>
</div>
<!-- Document Type Selector -->
<div class="w-full sm:w-auto min-w-[210px]">
<select class="w-full px-3 py-2.5 bg-surface-container-low text-on-surface font-label-md text-label-md rounded-lg focus:outline-none transition-colors cursor-pointer" id="docTypeSelect">
<option value="all">All Document Types</option>
<option value="tor">Transcript of Records (TOR)</option>
<option value="grad-cert">Certificate of Graduation</option>
<option value="correction">Records Correction (PSA)</option>
<option value="diploma">Diploma Re-issue / CAV</option>
<option value="dismissal">Honorable Dismissal</option>
</select>
</div>
<!-- Fulfillment Method Selector -->
<div class="w-full sm:w-auto min-w-[190px]">
<select class="w-full px-3 py-2.5 bg-surface-container-low text-on-surface font-label-md text-label-md rounded-lg focus:outline-none transition-colors cursor-pointer" id="fulfillmentSelect">
<option value="all">All Delivery Modes</option>
<option value="counter">Window Counter 2 (On-Site)</option>
<option value="courier">LBC Express Courier</option>
<option value="digital">e-PKI Certified PDF</option>
</select>
</div>
</div>
<!-- Filter Segmented Tabs & Batch Action Triggers -->
<div class="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-space-sm pt-space-xs">
<!-- Status Tabs -->
<div class="flex items-center gap-space-xs overflow-x-auto max-w-full pb-1 sm:pb-0" id="filterTabs">
<button class="px-space-sm py-1.5 rounded-lg bg-primary text-on-primary font-label-sm text-label-sm uppercase font-semibold transition-all" data-filter="all">
              All Requests (3)
            </button>
<button class="px-space-sm py-1.5 rounded-lg bg-surface-container-high hover:bg-surface-container-highest text-on-surface font-label-sm text-label-sm uppercase font-semibold transition-all flex items-center gap-1" data-filter="processing">
<span class="w-1.5 h-1.5 rounded-full bg-primary-container"></span>
              Processing (1)
            </button>
<button class="px-space-sm py-1.5 rounded-lg bg-surface-container-high hover:bg-surface-container-highest text-on-surface font-label-sm text-label-sm uppercase font-semibold transition-all flex items-center gap-1" data-filter="ready">
<span class="w-1.5 h-1.5 rounded-full bg-secondary"></span>
              Ready For Releasing (1)
            </button>
<button class="px-space-sm py-1.5 rounded-lg bg-surface-container-high hover:bg-surface-container-highest text-on-surface font-label-sm text-label-sm uppercase font-semibold transition-all flex items-center gap-1" data-filter="pending">
<span class="w-1.5 h-1.5 rounded-full bg-error"></span>
              Needs Review (1)
            </button>
</div>
<!-- Quick Actions & Mass Operations -->
<div class="flex items-center gap-space-xs w-full sm:w-auto justify-end">
<button class="flex items-center gap-1 px-space-sm py-1.5 rounded-lg bg-surface-container hover:bg-surface-container-high text-on-surface font-label-sm text-label-sm font-semibold transition-colors" id="batchManifestBtn">
<span class="material-symbols-outlined text-[16px]">print</span>
<span>Releasing Manifest</span>
</button>
<button class="flex items-center gap-1 px-space-sm py-1.5 rounded-lg bg-surface-container hover:bg-surface-container-high text-on-surface font-label-sm text-label-sm font-semibold transition-colors">
<span class="material-symbols-outlined text-[16px]">download</span>
<span>Export CSV</span>
</button>
</div>
</div>
</div>
<!-- Data Table -->
<div class="overflow-x-auto w-full">
<table class="w-full text-left" id="requestsTable">
<thead>
<tr class="bg-surface-container font-label-sm text-label-sm uppercase tracking-wider text-on-surface-variant">
<th class="py-space-sm px-space-md w-12 text-center" scope="col">
<input class="rounded accent-primary cursor-pointer w-4 h-4" id="selectAllCheckbox" type="checkbox"/>
</th>
<th class="py-space-sm px-space-sm" scope="col">Request Details</th>
<th class="py-space-sm px-space-sm" scope="col">Student Credential</th>
<th class="py-space-sm px-space-sm" scope="col">Academic Degree</th>
<th class="py-space-sm px-space-sm" scope="col">Status &amp; SLA</th>
<th class="py-space-sm px-space-md text-right" scope="col">Administrative Actions</th>
</tr>
</thead>
<tbody class="font-body-md text-body-md divide-none" id="tableBody">
<!-- ROW 1: REG-260914 (TOR) -->
<tr class="group hover:bg-surface-container-low transition-colors bg-surface-container-lowest" data-status="processing" data-type="tor">
<td class="py-space-md px-space-md text-center align-top">
<input class="row-checkbox rounded accent-primary cursor-pointer w-4 h-4 mt-1" type="checkbox"/>
</td>
<td class="py-space-md px-space-sm align-top">
<div class="flex flex-col">
<span class="font-headline-sm text-headline-sm text-on-surface font-bold">Transcript of Records (TOR)</span>
<div class="flex items-center gap-space-xs mt-0.5">
<span class="font-code-sm text-code-sm text-primary font-bold">REG-260914</span>
<span class="text-outline-variant">•</span>
<span class="font-label-sm text-label-sm text-on-surface-variant uppercase">Official Board / PRC Evaluation</span>
</div>
<span class="font-body-sm text-body-sm text-on-surface-variant mt-1 flex items-center gap-1">
<span class="material-symbols-outlined text-[15px] text-primary">local_post_office</span>
                    Dispatched via LBC Delivery
                  </span>
</div>
</td>
<td class="py-space-md px-space-sm align-top">
<div class="flex flex-col">
<span class="font-label-lg text-label-lg text-on-surface font-semibold">Juan D. Dela Cruz</span>
<span class="font-code-sm text-code-sm text-on-surface-variant">2018-00123</span>
<span class="font-body-sm text-body-sm text-outline mt-0.5">Alumnus (Batch 2022)</span>
</div>
</td>
<td class="py-space-md px-space-sm align-top">
<div class="flex flex-col">
<span class="font-label-md text-label-md text-on-surface font-medium">BS Computer Science</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">College of Information and Computing</span>
</div>
</td>
<td class="py-space-md px-space-sm align-top">
<div class="flex flex-col gap-1.5">
<span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full bg-primary-container text-on-primary font-label-sm text-label-sm font-semibold w-max shadow-sm">
<span class="w-1.5 h-1.5 rounded-full bg-on-primary animate-ping"></span>
                    Processing
                  </span>
<div class="flex items-center gap-1 font-body-sm text-body-sm text-on-surface-variant">
<span class="material-symbols-outlined text-[14px]">schedule</span>
<span>SLA: Day 2 of 3</span>
</div>
</div>
</td>
<td class="py-space-md px-space-md align-top text-right">
<div class="flex items-center justify-end gap-space-xs flex-wrap">
<button class="action-approve px-space-sm py-1.5 rounded-lg bg-surface-container hover:bg-surface-container-high text-on-surface font-label-md text-label-md flex items-center gap-1 transition-all">
<span class="material-symbols-outlined text-[16px] text-secondary">check</span>
<span>Approve</span>
</button>
<button class="action-decline px-space-sm py-1.5 rounded-lg bg-surface-container hover:bg-surface-container-high text-on-surface font-label-md text-label-md flex items-center gap-1 transition-all">
<span class="material-symbols-outlined text-[16px] text-error">close</span>
<span>Decline</span>
</button>
<button class="action-complete px-space-md py-1.5 rounded-lg bg-primary hover:bg-primary-container text-on-primary font-label-md text-label-md font-semibold flex items-center gap-1 transition-all shadow-sm">
<span class="material-symbols-outlined text-[16px]">task_alt</span>
<span>Complete</span>
</button>
</div>
</td>
</tr>
<!-- ROW 2: REG-260903 (Certificate of Graduation) -->
<tr class="group hover:bg-surface-container-low transition-colors bg-surface-container-low/30" data-status="ready" data-type="grad-cert">
<td class="py-space-md px-space-md text-center align-top">
<input class="row-checkbox rounded accent-primary cursor-pointer w-4 h-4 mt-1" type="checkbox"/>
</td>
<td class="py-space-md px-space-sm align-top">
<div class="flex flex-col">
<span class="font-headline-sm text-headline-sm text-on-surface font-bold">Certificate of Graduation</span>
<div class="flex items-center gap-space-xs mt-0.5">
<span class="font-code-sm text-code-sm text-primary font-bold">REG-260903</span>
<span class="text-outline-variant">•</span>
<span class="font-label-sm text-label-sm text-on-surface-variant uppercase">Official Authentication Docket</span>
</div>
<span class="font-body-sm text-body-sm text-on-surface-variant mt-1 flex items-center gap-1">
<span class="material-symbols-outlined text-[15px] text-secondary">storefront</span>
                    Counter Window 2 • Cashier Cleared
                  </span>
</div>
</td>
<td class="py-space-md px-space-sm align-top">
<div class="flex flex-col">
<span class="font-label-lg text-label-lg text-on-surface font-semibold">Juan D. Dela Cruz</span>
<span class="font-code-sm text-code-sm text-on-surface-variant">2018-00123</span>
<span class="font-body-sm text-body-sm text-outline mt-0.5">Alumnus (Batch 2022)</span>
</div>
</td>
<td class="py-space-md px-space-sm align-top">
<div class="flex flex-col">
<span class="font-label-md text-label-md text-on-surface font-medium">BS Computer Science</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">College of Information and Computing</span>
</div>
</td>
<td class="py-space-md px-space-sm align-top">
<div class="flex flex-col gap-1.5">
<span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full bg-secondary-fixed text-on-secondary-fixed font-label-sm text-label-sm font-bold w-max shadow-sm">
<span class="w-2 h-2 rounded-full bg-secondary"></span>
                    Ready for Pickup / Delivery
                  </span>
<div class="flex items-center gap-1 font-body-sm text-body-sm text-on-surface font-semibold">
<span class="material-symbols-outlined text-[14px] text-secondary">event_available</span>
<span>Ready Today (Counter 2)</span>
</div>
</div>
</td>
<td class="py-space-md px-space-md align-top text-right">
<div class="flex items-center justify-end gap-space-xs flex-wrap">
<button class="action-docket px-space-sm py-1.5 rounded-lg bg-surface-container hover:bg-surface-container-high text-on-surface font-label-md text-label-md flex items-center gap-1 transition-all">
<span class="material-symbols-outlined text-[16px]">visibility</span>
<span>View Docket</span>
</button>
<button class="action-complete px-space-md py-1.5 rounded-lg bg-primary hover:bg-primary-container text-on-primary font-label-md text-label-md font-semibold flex items-center gap-1 transition-all shadow-sm">
<span class="material-symbols-outlined text-[16px]">verified</span>
<span>Release / Complete</span>
</button>
</div>
</td>
</tr>
<!-- ROW 3: COR-260827 (Birthdate Correction) -->
<tr class="group hover:bg-surface-container-low transition-colors bg-surface-container-lowest" data-status="pending" data-type="correction">
<td class="py-space-md px-space-md text-center align-top">
<input class="row-checkbox rounded accent-primary cursor-pointer w-4 h-4 mt-1" type="checkbox"/>
</td>
<td class="py-space-md px-space-sm align-top">
<div class="flex flex-col">
<span class="font-headline-sm text-headline-sm text-on-surface font-bold">Birthdate Correction</span>
<div class="flex items-center gap-space-xs mt-0.5">
<span class="font-code-sm text-code-sm text-primary font-bold">COR-260827</span>
<span class="text-outline-variant">•</span>
<span class="font-label-sm text-label-sm text-on-surface-variant uppercase">Records Correction</span>
</div>
<span class="font-body-sm text-body-sm text-on-surface-variant mt-1 flex items-center gap-1">
<span class="material-symbols-outlined text-[15px] text-error">attachment</span>
                    PSA Authenticated Copy Attached (.pdf)
                  </span>
</div>
</td>
<td class="py-space-md px-space-sm align-top">
<div class="flex flex-col">
<span class="font-label-lg text-label-lg text-on-surface font-semibold">Maria L. Santos</span>
<span class="font-code-sm text-code-sm text-on-surface-variant">2021-00841</span>
<span class="font-body-sm text-body-sm text-outline mt-0.5">3rd Year Regular</span>
</div>
</td>
<td class="py-space-md px-space-sm align-top">
<div class="flex flex-col">
<span class="font-label-md text-label-md text-on-surface font-medium">BS Biology</span>
<span class="font-body-sm text-body-sm text-on-surface-variant">College of Arts and Sciences</span>
</div>
</td>
<td class="py-space-md px-space-sm align-top">
<div class="flex flex-col gap-1.5">
<span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full bg-error-container text-on-error-container font-label-sm text-label-sm font-semibold w-max shadow-sm">
<span class="w-1.5 h-1.5 rounded-full bg-error"></span>
                    Pending Review
                  </span>
<div class="flex items-center gap-1 font-body-sm text-body-sm text-error font-medium">
<span class="material-symbols-outlined text-[14px]">id_card</span>
<span>Needs PSA Validation</span>
</div>
</div>
</td>
<td class="py-space-md px-space-md align-top text-right">
<div class="flex items-center justify-end gap-space-xs flex-wrap">
<button class="action-verify px-space-sm py-1.5 rounded-lg bg-surface-container hover:bg-surface-container-high text-on-surface font-label-md text-label-md flex items-center gap-1 transition-all">
<span class="material-symbols-outlined text-[16px] text-tertiary">document_scanner</span>
<span>Verify Docs</span>
</button>
<button class="action-approve px-space-sm py-1.5 rounded-lg bg-surface-container hover:bg-surface-container-high text-on-surface font-label-md text-label-md flex items-center gap-1 transition-all">
<span class="material-symbols-outlined text-[16px] text-secondary">check</span>
<span>Approve</span>
</button>
<button class="action-decline px-space-sm py-1.5 rounded-lg bg-surface-container hover:bg-surface-container-high text-on-surface font-label-md text-label-md flex items-center gap-1 transition-all">
<span class="material-symbols-outlined text-[16px] text-error">close</span>
<span>Decline</span>
</button>
<button class="action-complete px-space-md py-1.5 rounded-lg bg-primary hover:bg-primary-container text-on-primary font-label-md text-label-md font-semibold flex items-center gap-1 transition-all shadow-sm">
<span class="material-symbols-outlined text-[16px]">task_alt</span>
<span>Complete</span>
</button>
</div>
</td>
</tr>
</tbody>
</table>
</div>
<!-- Pagination & Queue Footer Status -->
<div class="p-space-md bg-surface-container-low flex flex-col sm:flex-row items-center justify-between gap-space-md">
<div class="flex items-center gap-space-sm font-body-sm text-body-sm text-on-surface-variant">
<span>Showing <strong>3</strong> of <strong>3</strong> active operational requests</span>
<span class="text-outline-variant">•</span>
<span class="flex items-center gap-1 text-primary font-semibold">
<span class="material-symbols-outlined text-[16px]">check_circle</span>
            All SLA windows compliant
          </span>
</div>
<div class="flex items-center gap-space-xs">
<button class="p-2 rounded-lg bg-surface-container-highest text-on-surface-variant opacity-60 cursor-not-allowed">
<span class="material-symbols-outlined text-[16px]">chevron_left</span>
</button>
<span class="px-space-sm py-1 rounded-lg bg-primary text-on-primary font-label-md text-label-md font-bold">1</span>
<button class="p-2 rounded-lg bg-surface-container-highest text-on-surface-variant opacity-60 cursor-not-allowed">
<span class="material-symbols-outlined text-[16px]">chevron_right</span>
</button>
</div>
</div>
</div>
<!-- Multi-Module Context & Verification Guidance Bento -->
<div class="grid grid-cols-1 lg:grid-cols-3 gap-space-md">
<!-- Card 1: Fast Verification Flow -->
<div class="p-space-md rounded-xl bg-surface-container-lowest shadow-sm flex flex-col justify-between">
<div class="flex flex-col gap-space-xs">
<div class="flex items-center justify-between">
<span class="font-label-sm text-label-sm uppercase tracking-wider text-on-surface-variant">Authentication Protocol</span>
<span class="px-2 py-0.5 rounded-full bg-secondary-fixed text-on-secondary-fixed font-code-sm text-code-sm font-semibold">CHED-Compliant</span>
</div>
<h3 class="font-headline-sm text-headline-sm text-primary font-bold">CAV &amp; Diplomas Authenticator</h3>
<p class="font-body-sm text-body-sm text-on-surface-variant">
            All requested Special Orders and Transcript of Records pass through digital PKI watermarking and registrar seal stamping before release.
          </p>
</div>
<div class="mt-space-md pt-space-xs flex items-center justify-between">
<span class="font-code-sm text-code-sm text-on-surface font-semibold flex items-center gap-1">
<span class="material-symbols-outlined text-[16px] text-primary">qr_code_scanner</span> QR Validated
          </span>
<button class="font-label-sm text-label-sm text-primary hover:text-primary-container font-bold flex items-center gap-1">
<span>Manage Stamping</span>
<span class="material-symbols-outlined text-[14px]">arrow_forward</span>
</button>
</div>
</div>
<!-- Card 2: Courier & Window Releasing Status -->
<div class="p-space-md rounded-xl bg-surface-container-lowest shadow-sm flex flex-col justify-between">
<div class="flex flex-col gap-space-xs">
<div class="flex items-center justify-between">
<span class="font-label-sm text-label-sm uppercase tracking-wider text-on-surface-variant">Dispatch Operations</span>
<span class="px-2 py-0.5 rounded-full bg-surface-container-high text-on-surface font-code-sm text-code-sm font-semibold">Counter 2 Active</span>
</div>
<h3 class="font-headline-sm text-headline-sm text-primary font-bold">Physical Releasing Schedule</h3>
<p class="font-body-sm text-body-sm text-on-surface-variant">
            Counter Window 2 processes in-person claim slips between 8:00 AM – 4:30 PM. Courier dispatches trigger LBC tracking SMS automatically.
          </p>
</div>
<div class="mt-space-md pt-space-xs flex items-center justify-between">
<span class="font-code-sm text-code-sm text-on-surface-variant">
            Next LBC Courier Pickup: <strong>3:00 PM</strong>
</span>
<button class="font-label-sm text-label-sm text-secondary hover:text-on-secondary-fixed-variant font-bold flex items-center gap-1">
<span>Print Waybills</span>
<span class="material-symbols-outlined text-[14px]">print</span>
</button>
</div>
</div>
<!-- Card 3: Notice & Compliance Seal -->
<div class="p-space-md rounded-xl bg-gradient-to-br from-primary to-primary-container text-on-primary shadow-md flex flex-col justify-between">
<div class="flex flex-col gap-space-xs">
<div class="flex items-center gap-space-xs text-primary-fixed-dim font-label-sm text-label-sm uppercase tracking-wider">
<span class="material-symbols-outlined text-[16px]">verified</span>
<span>USeP Records Assurance</span>
</div>
<h3 class="font-headline-sm text-headline-sm font-bold text-on-primary">ISO 9001:2015 Certified</h3>
<p class="font-body-sm text-body-sm text-primary-fixed-dim">
            University of Southeastern Philippines e-Registrar system is backed by Republic Act 10173 (Data Privacy Act of 2012) compliant audit logging.
          </p>
</div>
<div class="mt-space-md pt-space-xs flex items-center justify-between text-primary-fixed">
<span class="font-code-sm text-code-sm">Audit Ref: 2026-REG-OPS</span>
<span class="material-symbols-outlined text-[20px]">security</span>
</div>
</div>
</div>
</div>
<!-- Interactive Client-side Script -->
<script>
    (function initDocumentQueue() {
      const searchInput = document.getElementById('queueSearchInput');
      const docTypeSelect = document.getElementById('docTypeSelect');
      const tableBody = document.getElementById('tableBody');
      const filterTabs = document.getElementById('filterTabs');
      const selectAll = document.getElementById('selectAllCheckbox');
      const rowCheckboxes = document.querySelectorAll('.row-checkbox');
      const refreshBtn = document.getElementById('refreshQueueBtn');
      const batchManifestBtn = document.getElementById('batchManifestBtn');

      let currentStatusFilter = 'all';

      // Table Row Filtering Logic
      function filterRows() {
        const query = (searchInput.value || '').toLowerCase().trim();
        const selectedType = docTypeSelect.value;
        const rows = tableBody.querySelectorAll('tr');

        rows.forEach(row => {
          const rowText = row.innerText.toLowerCase();
          const rowStatus = row.getAttribute('data-status');
          const rowType = row.getAttribute('data-type');

          const matchesQuery = !query || rowText.includes(query);
          const matchesStatus = currentStatusFilter === 'all' || rowStatus === currentStatusFilter;
          const matchesType = selectedType === 'all' || rowType === selectedType;

          if (matchesQuery && matchesStatus && matchesType) {
            row.style.display = '';
          } else {
            row.style.display = 'none';
          }
        });
      }

      if (searchInput) searchInput.addEventListener('input', filterRows);
      if (docTypeSelect) docTypeSelect.addEventListener('change', filterRows);

      // Status Tabs Trigger
      if (filterTabs) {
        filterTabs.querySelectorAll('button').forEach(btn => {
          btn.addEventListener('click', () => {
            filterTabs.querySelectorAll('button').forEach(b => {
              b.classList.remove('bg-primary', 'text-on-primary');
              b.classList.add('bg-surface-container-high', 'text-on-surface');
            });
            btn.classList.remove('bg-surface-container-high', 'text-on-surface');
            btn.classList.add('bg-primary', 'text-on-primary');

            currentStatusFilter = btn.getAttribute('data-filter');
            filterRows();
          });
        });
      }

      // Checkbox Master Toggle
      if (selectAll) {
        selectAll.addEventListener('change', (e) => {
          rowCheckboxes.forEach(cb => {
            cb.checked = e.target.checked;
          });
        });
      }

      // Action Handlers
      tableBody.addEventListener('click', (e) => {
        const target = e.target.closest('button');
        if (!target) return;

        const row = target.closest('tr');
        const refElement = row.querySelector('.font-code-sm');
        const refCode = refElement ? refElement.innerText : 'Request';

        if (target.classList.contains('action-approve')) {
          alert('Approved transaction: ' + refCode + '. Student will receive an SMS notification.');
        } else if (target.classList.contains('action-decline')) {
          const reason = prompt('Please specify a rejection reason for ' + refCode + ':', 'Incomplete documentation');
          if (reason) alert('Declined with note: ' + reason);
        } else if (target.classList.contains('action-complete')) {
          target.innerText = 'Completed';
          target.classList.remove('bg-primary', 'hover:bg-primary-container');
          target.classList.add('bg-secondary', 'cursor-default');
          target.disabled = true;
          alert('Completed & recorded: ' + refCode);
        } else if (target.classList.contains('action-verify') || target.classList.contains('action-docket')) {
          alert('Opening verification viewer for ' + refCode + '...');
        }
      });

      // Quick Refresh Simulation
      if (refreshBtn) {
        refreshBtn.addEventListener('click', () => {
          const icon = refreshBtn.querySelector('.material-symbols-outlined');
          if (icon) icon.classList.add('animate-spin');
          setTimeout(() => {
            if (icon) icon.classList.remove('animate-spin');
            alert('Queue synchronized with Central Registrar Ledger.');
          }, 600);
        });
      }

      // Batch Manifest Print
      if (batchManifestBtn) {
        batchManifestBtn.addEventListener('click', () => {
          const checkedCount = Array.from(rowCheckboxes).filter(cb => cb.checked).length;
          alert('Generating Releasing Manifest for ' + (checkedCount || 3) + ' item(s)... Printing queued.');
        });
      }
    })();
  </script>
</div></main>"""

    # We want to replace everything from <main class="..."> to </main> in admin.html with user_queue_main
    match = re.search(r'(<main[\s\S]*?</main>)', admin_html)
    if not match:
        print("ERROR: could not find <main> in admin_html")
        return
        
    out_html = admin_html.replace(match.group(1), user_queue_main)
    
    # We also need to swap the active classes for the sidebar
    # Dashboard item active -> inactive
    # From:
    # <a aria-current="page" class="flex items-center gap-space-sm px-space-md py-space-sm transition-colors bg-surface-container-lowest text-primary font-headline-sm rounded-lg shadow-sm font-semibold" data-path="dashboard-home" href="admin.html">
    #   <span class="material-symbols-outlined text-[20px] text-primary">analytics</span>
    #   <span class="font-body-md text-body-md font-bold">Dashboard</span>
    # </a>
    # To:
    # <a class="flex items-center gap-space-sm px-space-md py-space-sm rounded-lg text-primary-fixed-dim hover:bg-black/20 hover:text-on-primary transition-colors" data-path="dashboard-home" href="admin.html">
    #   <span class="material-symbols-outlined text-[20px]">analytics</span>
    #   <span class="font-body-md text-body-md">Dashboard</span>
    # </a>
    
    # Document Queue item inactive -> active
    # From:
    # <a class="flex items-center justify-between px-space-md py-space-sm rounded-lg text-primary-fixed-dim hover:bg-black/20 hover:text-on-primary transition-colors" data-path="document-requests" href="document-requests.html">
    #   <div class="flex items-center gap-space-sm">
    #     <span class="material-symbols-outlined text-[20px]">description</span>
    #     <span class="font-body-md text-body-md">Document Queue</span>
    #   </div>
    #   <span class="px-space-xs py-0.5 rounded-full bg-secondary-container text-on-secondary-container font-label-sm text-label-sm shadow-sm">3</span>
    # </a>
    # To:
    # <a aria-current="page" class="flex items-center justify-between px-space-md py-space-sm transition-colors bg-surface-container-lowest text-primary font-headline-sm rounded-lg shadow-sm font-semibold" data-path="document-requests" href="document-queue.html">
    #   <div class="flex items-center gap-space-sm">
    #     <span class="material-symbols-outlined text-[20px] text-primary">description</span>
    #     <span class="font-body-md text-body-md font-bold">Document Queue</span>
    #   </div>
    #   <span class="px-space-xs py-0.5 rounded-full bg-secondary-container text-on-secondary-container font-label-sm text-label-sm shadow-sm">3</span>
    # </a>
    
    # Let's perform these replacements explicitly
    
    # Dashboard item replacement:
    dashboard_old = '''<a aria-current="page" class="flex items-center gap-space-sm px-space-md py-space-sm transition-colors bg-surface-container-lowest text-primary font-headline-sm rounded-lg shadow-sm font-semibold" data-path="dashboard-home" href="admin.html">
          <span class="material-symbols-outlined text-[20px] text-primary">analytics</span>
          <span class="font-body-md text-body-md font-bold">Dashboard</span>
        </a>'''
        
    dashboard_new = '''<a class="flex items-center gap-space-sm px-space-md py-space-sm rounded-lg text-primary-fixed-dim hover:bg-black/20 hover:text-on-primary transition-colors" data-path="dashboard-home" href="admin.html">
          <span class="material-symbols-outlined text-[20px]">analytics</span>
          <span class="font-body-md text-body-md">Dashboard</span>
        </a>'''
        
    out_html = out_html.replace(dashboard_old, dashboard_new)
    
    # Document queue replacement:
    docq_old = '''<a class="flex items-center justify-between px-space-md py-space-sm rounded-lg text-primary-fixed-dim hover:bg-black/20 hover:text-on-primary transition-colors" data-path="document-requests" href="document-requests.html">
          <div class="flex items-center gap-space-sm">
            <span class="material-symbols-outlined text-[20px]">description</span>
            <span class="font-body-md text-body-md">Document Queue</span>
          </div>
          <span class="px-space-xs py-0.5 rounded-full bg-secondary-container text-on-secondary-container font-label-sm text-label-sm shadow-sm">3</span>
        </a>'''
        
    docq_new = '''<a aria-current="page" class="flex items-center justify-between px-space-md py-space-sm transition-colors bg-surface-container-lowest text-primary font-headline-sm rounded-lg shadow-sm font-semibold" data-path="document-requests" href="document-queue.html">
          <div class="flex items-center gap-space-sm">
            <span class="material-symbols-outlined text-[20px] text-primary">description</span>
            <span class="font-body-md text-body-md font-bold">Document Queue</span>
          </div>
          <span class="px-space-xs py-0.5 rounded-full bg-secondary-container text-on-secondary-container font-label-sm text-label-sm shadow-sm">3</span>
        </a>'''
        
    out_html = out_html.replace(docq_old, docq_new)
    
    # Title update
    out_html = out_html.replace('<title>Admin Dashboard — USeP e-Registrar</title>', '<title>Document Queue — Admin Portal — USeP e-Registrar</title>')
    
    with open('e:/Registrar/dist/document-queue.html', 'w', encoding='utf-8') as f:
        f.write(out_html)
        
    print("Successfully built document-queue.html!")

if __name__ == '__main__':
    build_queue()

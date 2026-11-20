import { createFileRoute, useNavigate } from "@tanstack/react-router";
import { Bell, BookOpen, LogOut, ShieldCheck } from "lucide-react";
import { Link } from "@tanstack/react-router";
import { useState, useEffect } from "react";
import { resetDemoData, getDashboardStats, type DashboardStats, STORE_EVENT } from "@/lib/registrar-store";
import { Button } from "@/components/ui/button";

export const Route = createFileRoute("/admin-dashboard")({
  head: () => ({
    meta: [
      { title: "Admin Dashboard — USeP Virtual Registrar" },
      { name: "description", content: "Registrar operations dashboard with analytics, queue management, and institutional metrics." },
      { property: "og:title", content: "Admin Dashboard — USeP Virtual Registrar" },
      { property: "og:type", content: "website" },
    ],
  }),
  component: AdminDashboardPage,
});

/* ─── Brand (matches student Brand component exactly) ─── */
function Brand({ light = false }: { light?: boolean }) {
  return (
    <Link to="/" className={`flex items-center gap-3 ${light ? "text-primary-foreground" : "text-primary"}`}>
      <span className={`grid size-10 place-items-center rounded-full ${light ? "bg-gold text-primary" : "bg-primary text-gold"}`}>
        <BookOpen className="size-5" />
      </span>
      <span>
        <strong className="block font-display text-lg leading-none">USeP e-Registrar</strong>
        <small className={`mt-1 block text-[11px] ${light ? "text-primary-foreground/70" : "text-muted-foreground"}`}>Online Document Request &amp; Delivery</small>
      </span>
    </Link>
  );
}

/* ─── Top navbar — identical markup to student PortalHeader ─── */
function AdminPortalHeader({ onMenuClick }: { onMenuClick: () => void }) {
  const navigate = useNavigate();
  return (
    <header className="sticky top-0 z-50 border-b border-border bg-background/95 backdrop-blur">
      <div className="top-strip">
        <span>University of Southeastern Philippines — Main Campus, Davao City</span>
        <span className="hidden sm:inline">registrar@usep.edu.ph</span>
      </div>
      <div className="mx-auto flex h-16 max-w-[1560px] items-center justify-between gap-4 px-4 sm:px-6">
        {/* Mobile menu button - ALWAYS VISIBLE FOR TESTING */}
        <button
          onClick={onMenuClick}
          className="flex lg:hidden p-2 rounded-md hover:bg-secondary text-primary border-2 border-primary"
          aria-label="Toggle menu"
          style={{minWidth: '44px', minHeight: '44px'}}
        >
          <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
          </svg>
        </button>
        <div className="flex-1 flex justify-center lg:justify-start">
          <Brand />
        </div>
        <div className="flex items-center gap-2">
          <span className="hidden rounded-sm bg-secondary px-3 py-1 text-xs font-semibold text-secondary-foreground sm:inline-flex">
            <ShieldCheck className="mr-1 size-3.5" /> Admin view
          </span>
          <Button variant="ghost" size="icon" aria-label="Notifications" title="Notifications" className="hidden sm:flex">
            <Bell />
          </Button>
          <Button variant="outline" size="sm" onClick={() => navigate({ to: "/login" })} className="hidden sm:flex">
            <LogOut className="mr-2" /> Sign out
          </Button>
          <Button variant="outline" size="icon" onClick={() => navigate({ to: "/login" })} className="sm:hidden">
            <LogOut />
          </Button>
        </div>
      </div>
    </header>
  );
}

/* ─── Sidebar navigation ─── */
const NAV_SECTIONS = [
  {
    label: "Registrar Operations",
    items: [
      { key: "dashboard", icon: "analytics", label: "Dashboard" },
      { key: "document-queue", icon: "description", label: "Document Queue", badge: "3" },
    ],
  },
  {
    label: "Academic Transactions",
    items: [
      { key: "add-drop", icon: "swap_calls", label: "Add/Drop & Enrollment" },
      { key: "shifting-transfer", icon: "move_up", label: "Shifting & Transfer" },
      { key: "graduation-verification", icon: "school", label: "Graduation Verification" },
      { key: "loa-readmission", icon: "pause_circle", label: "LOA & Readmission" },
    ],
  },
];

function Sidebar({ active, onNavigate, isOpen, onClose }: { active: string; onNavigate: (key: string) => void; isOpen: boolean; onClose: () => void }) {
  return (
    <>
      {/* Mobile overlay */}
      {isOpen && (
        <div 
          className="fixed inset-0 bg-black/50 z-40 lg:hidden" 
          onClick={onClose}
        />
      )}
      
      {/* Sidebar */}
      <aside className={`fixed left-0 top-0 h-full w-72 bg-primary text-primary-foreground z-50 flex flex-col justify-between shadow-lg transition-transform duration-300 lg:translate-x-0 ${isOpen ? 'translate-x-0' : '-translate-x-full'}`}>
      <div className="flex flex-col flex-1 overflow-y-auto">
        {/* Logo — kept exactly as provided */}
        <div className="h-16 px-4 flex items-center gap-3 bg-primary border-b border-white/10">
          <img
            alt="USeP e-Registrar logo"
            className="h-8 w-auto object-contain"
            src="https://lh3.googleusercontent.com/aida/AEtjO1Ulu6bga2Ounzm0T6ZZ0PuOcnlN1K29snQIiQvfQHV_hgeG2kTJzIQyVyQFn6cyxRJkK7pU5hsmtRiGjrSaJv-ocRbeNIQq51xcP-Z5Hj6Fk5guXLItIxxX0_u9QYYblEnJACAhcJmxkr4msBVT-5cNJ42ftT2Xov070156XTE9qQyMcBgvXTo5JeMGf9IAZIktbyFrmVImnfDRRsLuPmxc06f-XVUuiUbGrhIcLev3mIOyvPDTxV4ZpQ"
          />
          <div className="flex flex-col">
            <span className="text-sm font-bold text-primary-foreground leading-tight uppercase tracking-tight">USeP e-Registrar</span>
            <span className="text-[10px] text-primary-foreground/60 uppercase tracking-wider">Admin Portal</span>
          </div>
        </div>

        <nav className="flex flex-col px-2 py-4 gap-0.5">
          {NAV_SECTIONS.map((section) => (
            <div key={section.label}>
              <div className="px-2 pt-3 pb-1">
                <span className="text-[10px] font-bold uppercase tracking-wider text-primary-foreground/50">{section.label}</span>
              </div>
              {section.items.map((item) => {
                const isActive = active === item.key;
                return (
                  <button
                    key={item.key}
                    onClick={() => {
                      onNavigate(item.key);
                      onClose();
                    }}
                    className={`w-full flex items-center justify-between px-3 py-2.5 rounded-lg transition-colors font-semibold text-sm ${
                      isActive
                        ? "bg-white/20 text-primary-foreground shadow-sm"
                        : "text-primary-foreground/70 hover:bg-white/10 hover:text-primary-foreground"
                    }`}
                  >
                    <div className="flex items-center gap-3">
                      <span className="material-symbols-outlined text-[20px]">{item.icon}</span>
                      <span>{item.label}</span>
                    </div>
                    {item.badge && (
                      <span className="px-1.5 py-0.5 rounded-full bg-gold text-primary-deep text-[10px] font-bold">{item.badge}</span>
                    )}
                  </button>
                );
              })}
            </div>
          ))}
        </nav>
      </div>

      <div className="p-3 bg-primary border-t border-white/10">
        <div className="p-3 rounded-lg bg-white/10 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className="w-9 h-9 rounded-full bg-gold text-primary font-bold text-sm flex items-center justify-center">RA</div>
            <div className="flex flex-col">
              <span className="text-xs font-semibold text-primary-foreground">Registrar Admin</span>
              <span className="text-[10px] text-primary-foreground/60">Head Evaluator</span>
            </div>
          </div>
          <div className="flex items-center gap-1">
            <button className="w-8 h-8 rounded-lg flex items-center justify-center text-primary-foreground/60 hover:text-primary-foreground hover:bg-white/10 transition-colors" title="Notifications">
              <span className="material-symbols-outlined text-[18px]">notifications</span>
            </button>
            <button className="w-8 h-8 rounded-lg flex items-center justify-center text-primary-foreground/60 hover:text-primary-foreground hover:bg-white/10 transition-colors" title="Sign out">
              <span className="material-symbols-outlined text-[18px]">logout</span>
            </button>
          </div>
        </div>
      </div>
    </aside>
    </>
  );
}

/* ─── KPI Cards ─── */
function KpiCard({ label, value, sub, icon, highlight, pulse }: {
  label: string; value: string | number; sub: string; icon?: string; highlight?: string; pulse?: boolean;
}) {
  return (
    <div className="bg-background p-5 rounded-xl border border-border shadow-sm hover:shadow-panel transition-shadow flex flex-col justify-between gap-3 group">
      <div className="flex items-center justify-between">
        <span className="text-[10px] font-bold uppercase tracking-wider text-muted-foreground">{label}</span>
        {pulse ? (
          <span className="flex h-2.5 w-2.5 relative">
            <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-destructive opacity-75"></span>
            <span className="relative inline-flex rounded-full h-2.5 w-2.5 bg-destructive"></span>
          </span>
        ) : (
          <span className="material-symbols-outlined text-muted-foreground group-hover:text-primary transition-colors text-[22px]">{icon}</span>
        )}
      </div>
      <div className="flex items-baseline gap-2">
        <span className={`font-display text-3xl font-bold ${highlight ?? "text-primary"}`}>{value}</span>
        {label === "PENDING REVIEW" && <span className="text-xs px-2 py-0.5 rounded-full bg-destructive/10 text-destructive font-semibold">Immediate</span>}
        {label === "COMPLETED THIS WEEK" && <span className="text-xs font-bold text-muted-foreground">99.4% SLA</span>}
        {label === "TOTAL QUEUE" && <span className="text-xs font-bold text-muted-foreground flex items-center gap-0.5"><span className="material-symbols-outlined text-[12px]">arrow_upward</span>+12%</span>}
      </div>
      <div className="bg-muted/50 rounded-md px-3 py-2">
        <span className="text-xs text-muted-foreground">{sub}</span>
      </div>
    </div>
  );
}

/* ─── Bar Chart ─── */
const VELOCITY_DATA = [
  { day: "Mon", val: "3.1d", pct: 65 },
  { day: "Tue", val: "2.4d", pct: 50 },
  { day: "Wed", val: "1.9d", pct: 38 },
  { day: "Thu", val: "2.2d", pct: 45 },
  { day: "Fri", val: "1.4d", pct: 30, peak: true },
];

function VelocityChart() {
  return (
    <div className="bg-background p-6 rounded-xl border border-border shadow-sm flex flex-col">
      <div className="flex items-center justify-between mb-5">
        <div>
          <p className="text-[10px] font-bold uppercase tracking-wider text-muted-foreground">PROCESSING VELOCITY</p>
          <h2 className="font-display text-base font-bold text-primary mt-0.5">Average Days to Completion</h2>
        </div>
        <span className="text-xs font-mono font-semibold text-primary bg-secondary px-2 py-1 rounded">Target: 2.5d</span>
      </div>
      <div className="h-44 flex items-end justify-between gap-3 pb-2 px-2">
        {VELOCITY_DATA.map((d) => (
          <div key={d.day} className="flex-1 flex flex-col items-center h-full justify-end group">
            <span className={`text-xs font-mono pb-1 ${d.peak ? "text-primary font-bold" : "text-muted-foreground"} group-hover:text-primary transition-colors`}>{d.val}</span>
            <div
              className={`w-full max-w-[42px] ${d.peak ? "bg-primary" : "bg-border"} group-hover:bg-primary rounded-t transition-all`}
              style={{ height: `${d.pct}%` }}
            />
            <span className={`text-xs pt-2 font-medium ${d.peak ? "text-primary font-bold" : "text-muted-foreground"}`}>
              {d.peak ? "Fri (Peak)" : d.day}
            </span>
          </div>
        ))}
      </div>
      <div className="flex items-center justify-between mt-3 bg-muted/40 px-3 py-2 rounded-md">
        <span className="text-xs text-muted-foreground">Weekly throughput increased by 18.2%</span>
        <span className="text-xs font-bold uppercase text-muted-foreground">Optimal Velocity</span>
      </div>
    </div>
  );
}

/* ─── Donut Chart ─── */
function WorkloadDonut() {
  return (
    <div className="bg-background p-6 rounded-xl border border-border shadow-sm flex flex-col">
      <p className="text-[10px] font-bold uppercase tracking-wider text-muted-foreground">WORKLOAD DISTRIBUTION</p>
      <h2 className="font-display text-base font-bold text-primary mt-0.5 mb-3">By Category</h2>
      <div className="flex items-center justify-center my-2 relative">
        <svg className="w-32 h-32 transform -rotate-90" viewBox="0 0 36 36">
          <circle className="text-muted" cx="18" cy="18" fill="none" r="15.915" stroke="currentColor" strokeWidth="4.5" />
          <circle className="text-primary" cx="18" cy="18" fill="none" r="15.915" stroke="currentColor" strokeDasharray="45 55" strokeDashoffset="0" strokeWidth="4.5" />
          <circle className="text-gold" cx="18" cy="18" fill="none" r="15.915" stroke="currentColor" strokeDasharray="25 75" strokeDashoffset="-45" strokeWidth="4.5" />
          <circle className="text-muted-foreground" cx="18" cy="18" fill="none" r="15.915" stroke="currentColor" strokeDasharray="15 85" strokeDashoffset="-70" strokeWidth="4.5" />
          <circle className="text-border" cx="18" cy="18" fill="none" r="15.915" stroke="currentColor" strokeDasharray="15 85" strokeDashoffset="-85" strokeWidth="4.5" />
        </svg>
        <div className="absolute inset-0 flex flex-col items-center justify-center pointer-events-none">
          <span className="font-display text-2xl font-bold text-primary leading-none">184</span>
          <span className="text-xs text-muted-foreground">Active</span>
        </div>
      </div>
      <div className="flex flex-col gap-2 mt-3">
        {[
          { label: "Doc Requests", pct: "45%", color: "bg-primary" },
          { label: "Add/Drop", pct: "25%", color: "bg-gold" },
          { label: "Shifting & Transfer", pct: "15%", color: "bg-muted-foreground" },
          { label: "Graduation/LOA", pct: "15%", color: "bg-border" },
        ].map((s) => (
          <div key={s.label} className="flex items-center justify-between text-xs">
            <div className="flex items-center gap-2">
              <span className={`w-2.5 h-2.5 rounded-full ${s.color}`} />
              <span className="text-foreground">{s.label}</span>
            </div>
            <span className="font-mono font-bold text-foreground">{s.pct}</span>
          </div>
        ))}
      </div>
    </div>
  );
}

/* ─── SLA Index ─── */
function SlaIndex() {
  return (
    <div className="bg-background p-6 rounded-xl border border-border shadow-sm flex flex-col">
      <p className="text-[10px] font-bold uppercase tracking-wider text-muted-foreground">COLLEGE SLA INDEX</p>
      <h2 className="font-display text-base font-bold text-primary mt-0.5 mb-4">Compliance Rate</h2>
      <div className="flex flex-col gap-4">
        {[
          { name: "CIC (Computing)", pct: 98, color: "bg-primary" },
          { name: "CAS (Arts & Sciences)", pct: 95, color: "bg-primary/70" },
          { name: "CBA (Business Admin)", pct: 94, color: "bg-gold" },
          { name: "CoE (Engineering)", pct: 92, color: "bg-muted-foreground" },
        ].map((c) => (
          <div key={c.name} className="flex flex-col gap-1">
            <div className="flex items-center justify-between text-xs">
              <span className="font-semibold text-foreground">{c.name}</span>
              <span className="font-mono font-bold text-primary">{c.pct}%</span>
            </div>
            <div className="w-full h-2 rounded-full bg-muted overflow-hidden">
              <div className={`h-full ${c.color} rounded-full`} style={{ width: `${c.pct}%` }} />
            </div>
          </div>
        ))}
      </div>
      <div className="mt-4 bg-muted/40 p-3 rounded-md">
        <p className="text-xs text-muted-foreground">All 4 campus units operate within the University 3-day SLA margin.</p>
      </div>
    </div>
  );
}

/* ─── Priority Queue Table ─── */
type QueueRow = {
  id: string; initials: string; name: string; number: string;
  doc: string; cat: string; date: string;
  status: string; statusClass: string;
  actions: string[];
};

const QUEUE_DATA: QueueRow[] = [
  {
    id: "REG-260914", initials: "JD", name: "Juan D. Dela Cruz", number: "2018-00123 • BSIT",
    doc: "Transcript of Records (TOR)", cat: "Academic Records", date: "Today, 08:30 AM",
    status: "Processing", statusClass: "status-processing",
    actions: ["view", "decline", "complete"],
  },
  {
    id: "REG-260903", initials: "JD", name: "Juan D. Dela Cruz", number: "2018-00123 • BSIT",
    doc: "Certificate of Graduation", cat: "Diplomas & Clearances", date: "Yesterday, 04:15 PM",
    status: "Ready for Pickup", statusClass: "status-ready",
    actions: ["view", "issue"],
  },
  {
    id: "COR-260827", initials: "MS", name: "Maria L. Santos", number: "2021-00841 • BEEd",
    doc: "Birthdate Correction (PSA)", cat: "Identity & Legal Records", date: "Sep 27, 10:20 AM",
    status: "Pending Sign-off", statusClass: "status-pending",
    actions: ["docket", "sign"],
  },
];

function QueueTable({ search }: { search: string }) {
  const filtered = QUEUE_DATA.filter((r) =>
    `${r.name} ${r.id} ${r.doc} ${r.number}`.toLowerCase().includes(search.toLowerCase())
  );
  return (
    <div className="overflow-x-auto w-full">
      <table className="data-table">
        <thead>
          <tr>
            <th>Request ID</th>
            <th>Student / ID</th>
            <th>Document / Category</th>
            <th>Submission Date</th>
            <th>Status</th>
            <th className="text-right">Action Protocol</th>
          </tr>
        </thead>
        <tbody>
          {filtered.map((r) => (
            <tr key={r.id}>
              <td><span className="font-mono text-xs font-bold text-primary">{r.id}</span></td>
              <td>
                <div className="flex items-center gap-2.5">
                  <div className="w-8 h-8 rounded-full bg-secondary text-primary font-bold text-xs flex items-center justify-center">{r.initials}</div>
                  <div>
                    <strong>{r.name}</strong>
                    <small>{r.number}</small>
                  </div>
                </div>
              </td>
              <td>
                <strong>{r.doc}</strong>
                <small>{r.cat}</small>
              </td>
              <td className="text-xs text-muted-foreground">{r.date}</td>
              <td><span className={`status-badge ${r.statusClass}`}>{r.status}</span></td>
              <td className="text-right">
                <div className="inline-flex items-center gap-1.5 justify-end">
                  {r.actions.includes("view") && (
                    <button className="px-2.5 py-1.5 rounded-md bg-muted hover:bg-secondary text-foreground text-xs font-semibold flex items-center gap-1 transition-all">
                      <span className="material-symbols-outlined text-[14px]">visibility</span> View
                    </button>
                  )}
                  {r.actions.includes("docket") && (
                    <button className="px-2.5 py-1.5 rounded-md bg-muted hover:bg-secondary text-foreground text-xs font-semibold flex items-center gap-1 transition-all">
                      <span className="material-symbols-outlined text-[14px]">file_open</span> Docket
                    </button>
                  )}
                  {r.actions.includes("decline") && (
                    <button className="px-2.5 py-1.5 rounded-md bg-muted hover:bg-destructive/10 text-foreground hover:text-destructive text-xs font-semibold flex items-center gap-1 transition-all">
                      <span className="material-symbols-outlined text-[14px]">close</span> Decline
                    </button>
                  )}
                  {r.actions.includes("complete") && (
                    <button className="px-3 py-1.5 rounded-md bg-primary hover:bg-primary-deep text-primary-foreground text-xs font-semibold flex items-center gap-1 transition-all">
                      <span className="material-symbols-outlined text-[14px]">check_circle</span> Complete
                    </button>
                  )}
                  {r.actions.includes("issue") && (
                    <button className="px-3 py-1.5 rounded-md bg-primary hover:bg-primary-deep text-primary-foreground text-xs font-semibold flex items-center gap-1 transition-all">
                      <span className="material-symbols-outlined text-[14px]">verified</span> Issue Release
                    </button>
                  )}
                  {r.actions.includes("sign") && (
                    <button className="px-3 py-1.5 rounded-md bg-primary hover:bg-primary-deep text-primary-foreground text-xs font-semibold flex items-center gap-1 transition-all">
                      <span className="material-symbols-outlined text-[14px]">draw</span> Sign PSA Endorsement
                    </button>
                  )}
                </div>
              </td>
            </tr>
          ))}
          {filtered.length === 0 && (
            <tr>
              <td colSpan={6} className="text-center py-8 text-muted-foreground text-sm">No records match your search.</td>
            </tr>
          )}
        </tbody>
      </table>
    </div>
  );
}

/* ─── Main Page ─── */
function AdminDashboardPage() {
  const [activeNav, setActiveNav] = useState("dashboard");
  const [search, setSearch] = useState("");
  const [resetPulse, setResetPulse] = useState(false);
  const [sidebarOpen, setSidebarOpen] = useState(false);
  const [stats, setStats] = useState<DashboardStats>({
    total_queue: 0,
    pending_review: 0,
    in_process: 0,
    completed_this_week: 0,
    document_checks: 0,
    sis_entries: 0,
  });

  // Load dashboard stats
  const loadStats = async () => {
    try {
      const data = await getDashboardStats();
      setStats(data);
    } catch (error) {
      console.error('Failed to load dashboard stats:', error);
    }
  };

  useEffect(() => {
    loadStats();
    window.addEventListener(STORE_EVENT, loadStats);
    return () => window.removeEventListener(STORE_EVENT, loadStats);
  }, []);

  const handleReset = () => {
    resetDemoData();
    setResetPulse(true);
    setTimeout(() => setResetPulse(false), 150);
    loadStats();
  };

  return (
    <div className="min-h-screen bg-surface-soft">
      <Sidebar 
        active={activeNav} 
        onNavigate={setActiveNav} 
        isOpen={sidebarOpen}
        onClose={() => setSidebarOpen(false)}
      />

      <div className="lg:pl-72 flex flex-col min-h-screen">
        {/* Navbar — same as student PortalHeader */}
        <AdminPortalHeader onMenuClick={() => setSidebarOpen(true)} />

        <main className="flex-1 bg-surface-soft">
          <div className="px-6 py-6 flex flex-col gap-6 max-w-[1560px] mx-auto w-full">

            {/* Page heading */}
            <div className="flex flex-col lg:flex-row lg:items-end justify-between gap-4">
              <div className="flex flex-col gap-1">
                <div className="flex items-center gap-2 flex-wrap">
                  <span className="text-[10px] font-bold uppercase tracking-wider text-primary bg-secondary px-2 py-0.5 rounded">REGISTRAR OPERATIONS</span>
                  <span className="inline-flex items-center gap-1.5 text-xs text-muted-foreground font-medium">
                    <span className="w-1.5 h-1.5 rounded-full bg-gold animate-pulse" /> Live System Sync
                  </span>
                </div>
                <h1 className="font-display text-2xl sm:text-3xl lg:text-4xl font-bold text-primary tracking-tight">Dashboard</h1>
                <p className="text-sm text-muted-foreground">Review operational metrics, processing velocity, and registrar workload trends across campuses.</p>
              </div>
              <div className="flex flex-wrap items-center gap-2">
                <button className="inline-flex items-center gap-2 px-3 sm:px-4 py-2 rounded-md bg-background hover:bg-muted text-foreground transition-all text-xs font-semibold border border-border shadow-sm">
                  <span className="material-symbols-outlined text-[16px]">download</span> <span className="hidden sm:inline">Export CSV Report</span>
                </button>
                <button className="inline-flex items-center gap-2 px-3 sm:px-4 py-2 rounded-md bg-background hover:bg-muted text-foreground transition-all text-xs font-semibold border border-border shadow-sm">
                  <span className="material-symbols-outlined text-[16px]">sync</span> <span className="hidden sm:inline">Sync SIS Ledger</span>
                </button>
                <button
                  onClick={handleReset}
                  className={`inline-flex items-center gap-2 px-3 sm:px-4 py-2 rounded-md bg-primary hover:bg-primary-deep text-primary-foreground text-xs font-semibold shadow-sm transition-all ${resetPulse ? "scale-95" : ""}`}
                >
                  <span className="material-symbols-outlined text-[16px]">restart_alt</span> <span className="hidden sm:inline">Reset Demo Data</span>
                </button>
              </div>
            </div>

            {/* KPI Cards */}
            <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-4">
              <KpiCard label="TOTAL QUEUE" value={stats.total_queue} icon="inbox" sub={`${stats.document_checks} Document Checks · ${stats.sis_entries} SIS Entries`} />
              <KpiCard label="PENDING REVIEW" value={stats.pending_review} icon="" pulse highlight="text-destructive" sub="Awaiting registrar sign-off & PSA check" />
              <KpiCard label="IN PROCESS" value={stats.in_process} icon="pending_actions" sub="Transfers, credits, and dean endorsements" />
              <KpiCard label="COMPLETED THIS WEEK" value={stats.completed_this_week} icon="verified" sub="Diplomas, TORs, and certifications issued" />
            </div>

            {/* Charts */}
            <div className="grid grid-cols-1 lg:grid-cols-12 gap-4">
              <div className="lg:col-span-6"><VelocityChart /></div>
              <div className="lg:col-span-3"><WorkloadDonut /></div>
              <div className="lg:col-span-3"><SlaIndex /></div>
            </div>

            {/* Priority Queue */}
            <div className="bg-background rounded-xl border border-border shadow-sm overflow-hidden">
              <div className="p-5 flex flex-col md:flex-row md:items-center justify-between gap-3 border-b border-border bg-muted/20">
                <div>
                  <div className="flex items-center gap-2">
                    <h2 className="font-display text-xl font-bold text-primary">Immediate Attention Queue</h2>
                    <span className="px-2 py-0.5 rounded-full bg-primary text-primary-foreground text-[10px] font-bold">3 Actionable</span>
                  </div>
                  <p className="text-xs text-muted-foreground mt-1">High-priority student records requiring direct registrar decision and credential validation.</p>
                </div>
                <div className="relative w-full md:w-72">
                  <span className="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground text-[16px]">search</span>
                  <input
                    id="queue-search"
                    className="form-input pl-9"
                    value={search}
                    onChange={(e) => setSearch(e.target.value)}
                    placeholder="Filter requests, names, IDs..."
                  />
                </div>
              </div>
              <QueueTable search={search} />
              <div className="px-5 py-3 border-t border-border bg-muted/10 flex flex-col sm:flex-row items-center justify-between gap-2">
                <span className="text-xs text-muted-foreground">Showing 3 of 42 actionable registrar items</span>
                <div className="flex items-center gap-1">
                  <button className="p-1 rounded bg-muted text-foreground opacity-40 cursor-not-allowed" disabled>
                    <span className="material-symbols-outlined text-[16px]">chevron_left</span>
                  </button>
                  <span className="px-2 font-mono text-xs font-bold text-primary">Page 1 of 14</span>
                  <button className="p-1 rounded bg-muted hover:bg-secondary text-foreground transition-colors">
                    <span className="material-symbols-outlined text-[16px]">chevron_right</span>
                  </button>
                </div>
              </div>
            </div>

            {/* Compliance footer */}
            <div className="py-4 px-6 rounded-xl bg-muted/40 border border-border flex flex-col md:flex-row items-center justify-between gap-3 text-center md:text-left">
              <div className="flex items-center gap-3">
                <span className="material-symbols-outlined text-primary text-[24px]">verified_user</span>
                <div>
                  <p className="text-xs font-bold text-foreground">USeP Digital PKI Institutional Authority</p>
                  <p className="text-xs text-muted-foreground">Philippine e-Governance Framework (PeGR) &amp; RA 10173 DPA Encrypted Vault</p>
                </div>
              </div>
              <div className="flex items-center gap-4 text-[10px] text-muted-foreground font-bold">
                <span>ISO 9001:2015 CERTIFIED</span>
                <span>•</span>
                <span>CHED REGION XI ACCREDITED</span>
              </div>
            </div>

          </div>
        </main>
      </div>
    </div>
  );
}

import { createFileRoute } from "@tanstack/react-router";
import { CheckCircle2, ClipboardCheck, RotateCcw, Search, SlidersHorizontal, XCircle } from "lucide-react";
import { useEffect, useMemo, useState } from "react";
import { EmptyState, PageTitle, PortalHeader, StatusBadge } from "@/components/registrar-ui";
import { Button } from "@/components/ui/button";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { getRequests, getTransactions, resetDemoData, STORE_EVENT, updateRequestStatus, updateTransactionStatus, type AcademicTransaction, type RegistrarRequest, type RequestStatus, getDashboardStats, type DashboardStats } from "@/lib/registrar-store";

export const Route = createFileRoute("/admin")({
  head: () => ({ meta: [
    { title: "Registrar Admin Portal — USeP Virtual Registrar" }, { name: "description", content: "Manage document requests, record corrections, approvals, and academic transactions." },
    { property: "og:title", content: "Registrar Admin Portal — USeP Virtual Registrar" }, { property: "og:description", content: "Operational registrar queues and academic transaction management in one dashboard." },
    { property: "og:type", content: "website" }, { name: "twitter:card", content: "summary_large_image" },
  ]}), component: AdminPage,
});

function StatusActions({ status, onChange }: { status: RequestStatus; onChange: (status: RequestStatus) => void }) {
  return <div className="flex min-w-max gap-1"><Button size="sm" variant="outline" onClick={() => onChange("Processing")} disabled={status === "Processing"}><CheckCircle2 /> Approve</Button><Button size="sm" variant="outline" onClick={() => onChange("Declined")} disabled={status === "Declined"}><XCircle /> Decline</Button><Button size="sm" variant="default" onClick={() => onChange("Completed")} disabled={status === "Completed"}>Complete</Button></div>;
}

function Filters({ search, setSearch, type, setType, options, typeLabel = "All types" }: { search: string; setSearch: (v: string) => void; type: string; setType: (v: string) => void; options: string[]; typeLabel?: string }) {
  return <div className="mb-5 flex flex-col gap-3 rounded-md border border-border bg-background p-3 sm:flex-row"><label className="relative flex-1"><Search className="absolute left-3 top-2.5 size-4 text-muted-foreground" /><input className="form-input pl-9" value={search} onChange={(e) => setSearch(e.target.value)} placeholder="Search by student, ID, course, or request" /></label><label className="relative sm:w-64"><SlidersHorizontal className="absolute left-3 top-2.5 size-4 text-muted-foreground" /><select className="form-input pl-9" value={type} onChange={(e) => setType(e.target.value)}><option value="">{typeLabel}</option>{options.map((option) => <option key={option}>{option}</option>)}</select></label></div>;
}

function AdminPage() {
  const [requests, setRequests] = useState<RegistrarRequest[]>([]); 
  const [transactions, setTransactions] = useState<AcademicTransaction[]>([]);
  const [stats, setStats] = useState<DashboardStats>({
    total_queue: 0,
    pending_review: 0,
    in_process: 0,
    completed_this_week: 0,
    document_checks: 0,
    sis_entries: 0,
  });
  const [requestSearch, setRequestSearch] = useState(""); 
  const [requestType, setRequestType] = useState("");
  const [academicSearch, setAcademicSearch] = useState(""); 
  const [academicType, setAcademicType] = useState("");
  
  const refresh = async () => { 
    const [reqData, txData, statsData] = await Promise.all([
      getRequests(), 
      Promise.resolve(getTransactions()),
      getDashboardStats()
    ]);
    setRequests(reqData);
    setTransactions(txData); 
    setStats(statsData);
  };
  
  useEffect(() => { 
    refresh(); 
    window.addEventListener(STORE_EVENT, refresh); 
    return () => window.removeEventListener(STORE_EVENT, refresh); 
  }, []);
  
  const filteredRequests = useMemo(() => requests.filter((r) => { 
    const haystack = `${r.studentName} ${r.studentNumber} ${r.course} ${r.requestType}`.toLowerCase(); 
    return haystack.includes(requestSearch.toLowerCase()) && (!requestType || r.kind === requestType || r.requestType === requestType); 
  }), [requests, requestSearch, requestType]);
  
  const filteredTransactions = useMemo(() => transactions.filter((r) => { 
    const haystack = `${r.studentName} ${r.studentNumber} ${r.course} ${r.category} ${r.detail}`.toLowerCase(); 
    return haystack.includes(academicSearch.toLowerCase()) && (!academicType || r.category === academicType); 
  }), [transactions, academicSearch, academicType]);
  return <main className="min-h-screen bg-surface-soft"><PortalHeader role="Admin" /><PageTitle eyebrow="Registrar operations" title="Academic Management Dashboard" description="Review incoming requests, update approvals, and manage institutional academic transactions." action={<Button variant="outline" onClick={() => { resetDemoData(); refresh(); }}><RotateCcw /> Reset demo data</Button>} />
    <div className="mx-auto max-w-7xl px-4 py-8 sm:px-6"><div className="mb-7 grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
      <div className="stat-card"><span>Total queue</span><strong>{stats.total_queue}</strong><small>documents & corrections</small></div>
      <div className="stat-card"><span>Pending review</span><strong>{stats.pending_review}</strong><small>awaiting action</small></div>
      <div className="stat-card"><span>In process</span><strong>{stats.in_process}</strong><small>approved requests</small></div>
      <div className="stat-card"><span>Completed</span><strong>{stats.completed_this_week}</strong><small>closed requests</small></div>
    </div>
      <Tabs defaultValue="requests"><TabsList className="portal-tabs"><TabsTrigger value="requests"><ClipboardCheck /> Document Requests Queue</TabsTrigger><TabsTrigger value="academic"><SlidersHorizontal /> Academic Transactions</TabsTrigger></TabsList>
        <TabsContent value="requests" className="mt-7"><div className="mb-5"><h2 className="font-display text-2xl font-bold text-primary">Document Requests & Corrections</h2><p className="mt-1 text-sm text-muted-foreground">Student submissions appear here instantly. Actions update the student's tracker.</p></div><Filters search={requestSearch} setSearch={setRequestSearch} type={requestType} setType={setRequestType} options={["Document", "Records Correction", ...Array.from(new Set(requests.map((r) => r.requestType)))]} /><div className="table-shell">{filteredRequests.length ? <div className="overflow-x-auto"><table className="data-table"><thead><tr><th>Request</th><th>Student</th><th>Course</th><th>Status</th><th>Actions</th></tr></thead><tbody>{filteredRequests.map((item) => <tr key={item.id}><td><strong>{item.requestType}</strong><small>{item.id} · {item.kind}</small></td><td><strong>{item.studentName}</strong><small>{item.studentNumber}</small></td><td>{item.course}</td><td><StatusBadge status={item.status} /></td><td><StatusActions status={item.status} onChange={(status) => updateRequestStatus(item.id, status)} /></td></tr>)}</tbody></table></div> : <EmptyState>No requests match these filters.</EmptyState>}</div></TabsContent>
        <TabsContent value="academic" className="mt-7"><div className="mb-5"><h2 className="font-display text-2xl font-bold text-primary">Academic Transactions Ledger</h2><p className="mt-1 text-sm text-muted-foreground">Enrollment, transfer, validation, leave, readmission, and graduation workflows.</p></div><Filters search={academicSearch} setSearch={setAcademicSearch} type={academicType} setType={setAcademicType} typeLabel="All processes" options={Array.from(new Set(transactions.map((r) => r.category)))} /><div className="mb-4 flex flex-wrap gap-2 text-xs text-muted-foreground">{["Add/Drop & Enrollment","Shifting & Transfer Evaluation","Credit Validation & Deficiencies","LOA & Readmission","Graduation & Verification"].map((v) => <button key={v} onClick={() => setAcademicType(v)} className="rounded-sm border border-border bg-background px-3 py-2 hover:border-primary hover:text-primary">{v}</button>)}</div><div className="table-shell">{filteredTransactions.length ? <div className="overflow-x-auto"><table className="data-table"><thead><tr><th>Transaction</th><th>Student</th><th>Course</th><th>Status</th><th>Actions</th></tr></thead><tbody>{filteredTransactions.map((item) => <tr key={item.id}><td><strong>{item.category}</strong><small>{item.id} · {item.detail}</small></td><td><strong>{item.studentName}</strong><small>{item.studentNumber}</small></td><td>{item.course}</td><td><StatusBadge status={item.status} /></td><td><StatusActions status={item.status} onChange={(status) => updateTransactionStatus(item.id, status)} /></td></tr>)}</tbody></table></div> : <EmptyState>No academic transactions match these filters.</EmptyState>}</div></TabsContent>
      </Tabs></div></main>;
}

import { createFileRoute } from "@tanstack/react-router";
import { BookOpenCheck, Check, ChevronDown, ClipboardList, FilePenLine, Plus, WalletCards, X, Lock, QrCode } from "lucide-react";
import { useEffect, useMemo, useState } from "react";
import { EmptyState, PageTitle, PortalHeader, StatusBadge } from "@/components/registrar-ui";
import { Button } from "@/components/ui/button";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { addRequest, DOCUMENTS, getRequests, STORE_EVENT, type RegistrarRequest } from "@/lib/registrar-store";

export const Route = createFileRoute("/student")({
  head: () => ({ meta: [
    { title: "Student Dashboard — USeP Virtual Registrar" }, { name: "description", content: "Request registrar documents, submit student record corrections, and track their status." },
    { property: "og:title", content: "Student Dashboard — USeP Virtual Registrar" }, { property: "og:description", content: "A connected student workspace for documents, corrections, payments, and request tracking." },
    { property: "og:type", content: "website" }, { name: "twitter:card", content: "summary_large_image" },
  ]}), component: StudentPage,
});

const profile = { name: "Juan D. Dela Cruz", number: "2018-00123", course: "BS Computer Science" };

/* Payment Checkout Modal */
function PaymentCheckoutModal({ 
  isOpen, 
  onClose, 
  amount, 
  paymentMethod,
  onConfirm 
}: { 
  isOpen: boolean; 
  onClose: () => void; 
  amount: number; 
  paymentMethod: string;
  onConfirm: () => void;
}) {
  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm">
      <div className="relative w-full max-w-md rounded-lg bg-background shadow-2xl border border-border mx-4">
        {/* Header */}
        <div className="flex items-center justify-between border-b border-border bg-primary px-5 py-4 rounded-t-lg">
          <div className="flex items-center gap-2 text-primary-foreground">
            <Lock className="size-5" />
            <h2 className="font-display text-lg font-bold">Secure Checkout</h2>
          </div>
          <button
            onClick={onClose}
            className="text-primary-foreground/70 hover:text-primary-foreground transition-colors"
            aria-label="Close"
          >
            <X className="size-5" />
          </button>
        </div>

        {/* Content */}
        <div className="p-6 flex flex-col items-center">
          <div className="w-16 h-16 rounded-full bg-primary/10 flex items-center justify-center mb-4">
            <QrCode className="size-8 text-primary" />
          </div>
          
          <h3 className="font-display text-xl font-bold text-primary mb-2">
            Scan to Pay via {paymentMethod.toUpperCase()}
          </h3>
          
          <p className="text-sm text-muted-foreground mb-6">
            Please pay the exact amount of <span className="font-bold text-primary">₱{amount.toFixed(2)}</span>
          </p>

          {/* QR Code Placeholder */}
          <div className="w-48 h-48 rounded-lg bg-muted border-2 border-dashed border-border flex items-center justify-center mb-2">
            <div className="text-center">
              <QrCode className="size-16 text-muted-foreground/50 mx-auto mb-2" />
              <p className="text-xs text-muted-foreground">QR Code Placeholder</p>
            </div>
          </div>
          
          <p className="text-xs text-muted-foreground mb-6 text-center">
            <span className="inline-block px-2 py-1 rounded bg-amber-100 text-amber-800 font-semibold">
              Demo Mode: Payment gateway not connected
            </span>
          </p>

          {/* Confirm Button */}
          <Button
            onClick={onConfirm}
            className="w-full"
            size="lg"
            variant="default"
          >
            <Lock className="mr-2 size-4" />
            Confirm Payment
          </Button>
          
          <p className="text-xs text-muted-foreground mt-3 text-center">
            For demo purposes, click "Confirm Payment" to proceed without actual payment
          </p>
        </div>
      </div>
    </div>
  );
}

function StudentPage() {
  const [requests, setRequests] = useState<RegistrarRequest[]>([]);
  const [selected, setSelected] = useState<string[]>([]);
  const [purpose, setPurpose] = useState("Employment");
  const [delivery, setDelivery] = useState("Pickup at Registrar's Office");
  const [payment, setPayment] = useState("GCash");
  const [message, setMessage] = useState("");
  const [showCheckout, setShowCheckout] = useState(false);
  
  useEffect(() => { 
    const refresh = async () => {
      const allRequests = await getRequests();
      setRequests(allRequests.filter((r) => r.studentNumber === profile.number));
    };
    refresh(); 
    window.addEventListener(STORE_EVENT, refresh); 
    return () => window.removeEventListener(STORE_EVENT, refresh); 
  }, []);
  
  const total = useMemo(() => selected.reduce((sum, name) => sum + (DOCUMENTS.find((d) => d.name === name)?.price ?? 0), 0), [selected]);
  
  const handlePaymentClick = (event: React.FormEvent) => { 
    event.preventDefault(); 
    if (selected.length === 0) return;
    setShowCheckout(true);
  };
  
  const handleConfirmPayment = () => {
    // Submit the requests after payment confirmation
    selected.forEach((requestType) => addRequest({ 
      studentName: profile.name, 
      studentNumber: profile.number, 
      course: profile.course, 
      kind: "Document", 
      requestType, 
      purpose, 
      delivery, 
      payment 
    })); 
    
    setMessage(`Payment confirmed! ${selected.length} request${selected.length === 1 ? "" : "s"} submitted successfully.`); 
    setSelected([]);
    setShowCheckout(false);
  };
  
  const submitCorrection = (event: React.FormEvent<HTMLFormElement>) => { 
    event.preventDefault(); 
    const data = new FormData(event.currentTarget); 
    addRequest({ 
      studentName: profile.name, 
      studentNumber: profile.number, 
      course: profile.course, 
      kind: "Records Correction", 
      requestType: String(data.get("correctionType")), 
      purpose: String(data.get("details")), 
      delivery: "Not applicable", 
      payment: "Not applicable" 
    }); 
    event.currentTarget.reset(); 
    setMessage("Your records correction request was submitted."); 
  };
  return <main className="min-h-screen bg-surface-soft">
    <PortalHeader role="Student" />
    <PageTitle 
      eyebrow={`Welcome, ${profile.name}`} 
      title="Student Registrar Dashboard" 
      description="Request official documents, correct your student record, and follow every update." 
      action={<div className="profile-chip"><span>Student no.</span><strong>{profile.number}</strong><small>{profile.course}</small></div>} 
    />
    
    {/* Payment Checkout Modal */}
    <PaymentCheckoutModal 
      isOpen={showCheckout}
      onClose={() => setShowCheckout(false)}
      amount={total}
      paymentMethod={payment}
      onConfirm={handleConfirmPayment}
    />
    
    <div className="mx-auto max-w-7xl px-4 py-8 sm:px-6">
      {message && <div className="mb-6 flex items-center gap-2 rounded-md border border-success/30 bg-success-soft px-4 py-3 text-sm font-medium text-success"><Check className="size-4" />{message}<button className="ml-auto" onClick={() => setMessage("")} aria-label="Dismiss">×</button></div>}
      <Tabs defaultValue="marketplace">
        <TabsList className="portal-tabs">
          <TabsTrigger value="marketplace"><BookOpenCheck /> Documents</TabsTrigger>
          <TabsTrigger value="corrections"><FilePenLine /> Records Correction</TabsTrigger>
          <TabsTrigger value="tracker"><ClipboardList /> Request Tracker</TabsTrigger>
        </TabsList>
        <TabsContent value="marketplace" className="mt-7">
          <div className="mb-6">
            <h2 className="font-display text-2xl font-bold text-primary">Document Marketplace</h2>
            <p className="mt-1 text-sm text-muted-foreground">Select one or more official documents, then complete the request details.</p>
          </div>
          <form onSubmit={handlePaymentClick} className="grid gap-7 lg:grid-cols-[1fr_340px]">
            <div className="grid gap-3 sm:grid-cols-2">
              {DOCUMENTS.map((doc) => { 
                const active = selected.includes(doc.name); 
                return <label key={doc.name} className={`document-option ${active ? "document-option-active" : ""}`}>
                  <div className="flex items-start gap-3">
                    <input type="checkbox" className="mt-1 accent-primary" checked={active} onChange={() => setSelected(active ? selected.filter((v) => v !== doc.name) : [...selected, doc.name])} />
                    <div className="min-w-0 flex-1">
                      <p className="text-xs font-semibold uppercase text-muted-foreground">{doc.category}</p>
                      <h3 className="mt-1 font-semibold">{doc.name}</h3>
                      <details className="mt-2 text-xs text-muted-foreground">
                        <summary className="flex cursor-pointer items-center gap-1 font-medium text-primary">Description <ChevronDown className="size-3" /></summary>
                        <p className="mt-2 leading-5">{doc.description}</p>
                      </details>
                    </div>
                    <strong className="text-sm text-primary">₱{doc.price}</strong>
                  </div>
                </label>; 
              })}
            </div>
            <aside className="h-fit rounded-md border border-border bg-background p-5 shadow-panel lg:sticky lg:top-28">
              <h3 className="font-display text-xl font-bold text-primary">Request details</h3>
              <div className="mt-5 space-y-4">
                <div>
                  <label className="form-label">Purpose</label>
                  <select className="form-input" value={purpose} onChange={(e) => setPurpose(e.target.value)}>
                    <option>Employment</option>
                    <option>School transfer</option>
                    <option>Graduate school</option>
                    <option>Board examination</option>
                    <option>Scholarship</option>
                    <option>Personal copy</option>
                  </select>
                </div>
                <div>
                  <label className="form-label">Fulfillment</label>
                  <select className="form-input" value={delivery} onChange={(e) => setDelivery(e.target.value)}>
                    <option>Pickup at Registrar's Office</option>
                    <option>Courier delivery</option>
                    <option>Digital certified copy</option>
                  </select>
                </div>
                <div>
                  <label className="form-label">Payment method</label>
                  <div className="grid grid-cols-3 gap-2">
                    {["GCash","Maya","Card"].map((method) => <Button type="button" size="sm" variant={payment === method ? "default" : "outline"} onClick={() => setPayment(method)} key={method}>{method}</Button>)}
                  </div>
                </div>
                <div className="border-t border-border pt-4">
                  <div className="flex justify-between text-sm">
                    <span>{selected.length} selected</span>
                    <strong className="text-lg text-primary">₱{total}</strong>
                  </div>
                  <Button type="submit" variant="gold" size="lg" className="mt-4 w-full" disabled={!selected.length}>
                    <WalletCards /> Pay & Submit Request
                  </Button>
                </div>
              </div>
            </aside>
          </form>
        </TabsContent>
        <TabsContent value="corrections" className="mt-7"><div className="grid gap-7 lg:grid-cols-[1fr_320px]"><form onSubmit={submitCorrection} className="rounded-md border border-border bg-background p-6 shadow-panel"><h2 className="font-display text-2xl font-bold text-primary">Student Records Correction</h2><p className="mt-2 text-sm text-muted-foreground">Submit a formal review request. Registrar staff may contact you for supporting records.</p><div className="mt-7 grid gap-5 sm:grid-cols-2"><div><label className="form-label" htmlFor="correctionType">Correction type</label><select id="correctionType" name="correctionType" className="form-input"><option>Name correction</option><option>Birthdate correction</option><option>Curriculum / academic record concern</option></select></div><div><label className="form-label" htmlFor="contact">Contact number</label><input id="contact" className="form-input" placeholder="09XX XXX XXXX" required /></div><div className="sm:col-span-2"><label className="form-label" htmlFor="details">Requested correction and reason</label><textarea id="details" name="details" className="form-input min-h-32" placeholder="Describe the current record, the correct information, and supporting context." required /></div><div className="sm:col-span-2"><label className="form-label" htmlFor="evidence">Supporting document</label><input id="evidence" type="file" className="form-input file:mr-3 file:rounded-sm file:border-0 file:bg-secondary file:px-3 file:py-1 file:text-xs file:font-semibold" /></div></div><Button className="mt-6" variant="gold" type="submit"><Plus /> Submit Correction Request</Button></form><aside className="rounded-md bg-primary p-6 text-primary-foreground"><FilePenLine className="size-7 text-gold" /><h3 className="mt-5 font-display text-xl font-bold">Before submitting</h3><ul className="mt-4 space-y-3 text-sm text-primary-foreground/75"><li>• Use your official student details.</li><li>• Explain exactly what must be corrected.</li><li>• Prepare a valid government or school record.</li><li>• Monitor the tracker for registrar feedback.</li></ul></aside></div></TabsContent>
        <TabsContent value="tracker" className="mt-7"><div className="mb-6"><h2 className="font-display text-2xl font-bold text-primary">Request Tracker</h2><p className="mt-1 text-sm text-muted-foreground">Status changes made by the registrar appear here automatically.</p></div><div className="table-shell">{requests.length ? <div className="overflow-x-auto"><table className="data-table"><thead><tr><th>Request ID</th><th>Type</th><th>Request</th><th>Date</th><th>Status</th></tr></thead><tbody>{requests.map((item) => <tr key={item.id}><td className="font-mono text-xs font-semibold">{item.id}</td><td>{item.kind}</td><td><strong>{item.requestType}</strong><small>{item.purpose}</small></td><td>{item.createdAt}</td><td><StatusBadge status={item.status} /></td></tr>)}</tbody></table></div> : <EmptyState>No requests yet. Choose a document to begin.</EmptyState>}</div></TabsContent>
      </Tabs></div></main>;
}

import { createFileRoute, Link, useNavigate } from "@tanstack/react-router";
import { GraduationCap, LockKeyhole, ShieldCheck } from "lucide-react";
import { useState } from "react";
import { Brand } from "@/components/registrar-ui";
import { Button } from "@/components/ui/button";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";

export const Route = createFileRoute("/login")({
  head: () => ({ meta: [
    { title: "Portal Sign In — USeP Virtual Registrar" },
    { name: "description", content: "Choose the student or administrator demonstration portal for USeP registrar services." },
    { property: "og:title", content: "Portal Sign In — USeP Virtual Registrar" },
    { property: "og:description", content: "Access the student document request and registrar administration prototype." },
    { property: "og:type", content: "website" }, { name: "twitter:card", content: "summary_large_image" },
  ]}), component: LoginPage,
});

function LoginPanel({ role }: { role: "student" | "admin" }) {
  const navigate = useNavigate();
  const isStudent = role === "student";
  const [id, setId] = useState(isStudent ? "2018-00123" : "registrar.admin");
  const [password, setPassword] = useState("demo2026");
  const submit = (event: React.FormEvent) => { event.preventDefault(); window.localStorage.setItem("usep-demo-role", role); navigate({ to: isStudent ? "/student" : "/admin-dashboard" }); };
  return <form className="mt-4" style={{display: 'flex', flexDirection: 'column', gap: '1rem'}} onSubmit={submit}>
    <div>
      <label className="form-label" style={{fontSize: '0.75rem', marginBottom: '0.5rem', display: 'block'}} htmlFor={`${role}-id`}>
        {isStudent ? "Student number" : "Administrator ID"}
      </label>
      <input id={`${role}-id`} className="form-input" style={{width: '100%'}} value={id} onChange={(e) => setId(e.target.value)} />
    </div>
    <div>
      <div className="flex justify-between" style={{marginBottom: '0.5rem'}}>
        <label className="form-label" style={{fontSize: '0.75rem', marginBottom: 0}} htmlFor={`${role}-password`}>Password</label>
        <span style={{fontSize: '0.625rem'}} className="text-muted-foreground">Demo credentials prefilled</span>
      </div>
      <input id={`${role}-password`} type="password" className="form-input" style={{width: '100%'}} value={password} onChange={(e) => setPassword(e.target.value)} />
    </div>
    <Button type="submit" variant="gold" size="lg" className="w-full" style={{fontSize: '0.875rem'}}>
      Simulate {isStudent ? "Student" : "Admin"} Login
    </Button>
    <p style={{textAlign: 'center', fontSize: '0.625rem'}} className="text-muted-foreground">
      <LockKeyhole className="mr-1 inline size-3" />Prototype access only. No real university account is used.
    </p>
  </form>;
}

function LoginPage() {
  return <main className="min-h-svh bg-surface-soft" style={{overflowX: 'hidden'}}>
    <div className="top-strip"><span>University of Southeastern Philippines — Main Campus</span><span className="hidden sm:inline">Virtual Registrar prototype</span></div>
    <div className="mx-auto px-4 py-4 sm:px-6 sm:py-6" style={{maxWidth: '80rem', minHeight: 'calc(100vh - 28px)'}}>
      <div className="mb-4 flex items-center justify-between"><Brand /><Link to="/" className="text-xs sm:text-sm font-semibold text-primary">Back to home</Link></div>
      <div style={{display: 'flex', minHeight: 'calc(100vh - 140px)', alignItems: 'center', justifyContent: 'center'}}>
        <div className="w-full" style={{maxWidth: '100%'}}>
          <div className="hidden lg:block" style={{marginBottom: '2rem'}}>
            <p className="eyebrow">One registrar. Two workspaces.</p>
            <h1 className="mt-4 font-display text-4xl lg:text-5xl font-bold leading-tight text-primary" style={{maxWidth: '40rem'}}>University services, routed to the right people.</h1>
          </div>
          <section className="w-full mx-auto rounded-md border border-border bg-background shadow-panel" style={{maxWidth: '32rem', padding: '1rem'}}>
            <h2 className="font-display font-bold text-primary" style={{fontSize: '1.5rem'}}>Enter the portal</h2>
            <p className="mt-2 text-muted-foreground" style={{fontSize: '0.875rem'}}>Choose a role to explore the complete workflow.</p>
            <Tabs defaultValue="student" className="mt-4">
              <TabsList className="grid w-full grid-cols-2" style={{height: 'auto', gap: '0.25rem', padding: '0.25rem'}}>
                <TabsTrigger value="student" style={{padding: '0.5rem', fontSize: '0.875rem'}}>Student Login</TabsTrigger>
                <TabsTrigger value="admin" style={{padding: '0.5rem', fontSize: '0.875rem'}}>Admin Portal</TabsTrigger>
              </TabsList>
              <TabsContent value="student"><LoginPanel role="student" /></TabsContent>
              <TabsContent value="admin"><LoginPanel role="admin" /></TabsContent>
            </Tabs>
          </section>
        </div>
      </div>
    </div>
  </main>;
}

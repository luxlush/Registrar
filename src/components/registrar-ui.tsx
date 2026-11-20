import { Link, useNavigate } from "@tanstack/react-router";
import { Bell, BookOpen, ChevronRight, LogOut, ShieldCheck } from "lucide-react";
import * as React from "react";
import type { ReactNode } from "react";
import { Button } from "@/components/ui/button";
import type { RequestStatus } from "@/lib/registrar-store";
import usepLogo from "@/assets/usep-logo-transparent.png";

export function Brand({ light = false }: { light?: boolean }) {
  return <Link to="/" className={`flex items-center gap-3 ${light ? "text-primary-foreground" : "text-primary"}`}>
    {light ? (
      <img 
        src={usepLogo} 
        alt="USeP Logo" 
        className="h-10 w-10"
        style={{ filter: 'brightness(0) invert(1)' }}
      />
    ) : (
      <span className="grid size-10 place-items-center rounded-full bg-primary text-gold">
        <BookOpen className="size-5" />
      </span>
    )}
    <span><strong className="block font-display text-lg leading-none">USeP e-Registrar</strong><small className={`mt-1 block text-[11px] ${light ? "text-primary-foreground/70" : "text-muted-foreground"}`}>Online Document Request & Delivery</small></span>
  </Link>;
}

export function PortalHeader({ role }: { role: "Student" | "Admin" }) {
  const navigate = useNavigate();
  const [menuOpen, setMenuOpen] = React.useState(false);
  
  return <header className="sticky top-0 z-40 border-b border-border bg-background/95 backdrop-blur">
    <div className="top-strip"><span>University of Southeastern Philippines — Main Campus, Davao City</span><span className="hidden sm:inline">registrar@usep.edu.ph</span></div>
    <div className="mx-auto flex h-16 max-w-7xl items-center justify-between px-4 sm:px-6">
      <Brand />
      <div className="flex items-center gap-2">
        <span className="hidden rounded-sm bg-secondary px-3 py-1 text-xs font-semibold text-secondary-foreground sm:inline-flex"><ShieldCheck className="mr-1 size-3.5" />{role} view</span>
        <Button variant="ghost" size="icon" aria-label="Notifications" title="Notifications" className="hidden sm:inline-flex"><Bell /></Button>
        <Button variant="outline" size="sm" onClick={() => navigate({ to: "/login" })} className="hidden sm:inline-flex"><LogOut /> Sign out</Button>
        {/* Mobile menu button */}
        <Button 
          variant="ghost" 
          size="icon" 
          className="sm:hidden" 
          onClick={() => setMenuOpen(!menuOpen)}
          aria-label="Menu"
        >
          <svg className="size-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            {menuOpen ? (
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
            ) : (
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
            )}
          </svg>
        </Button>
      </div>
    </div>
    {/* Mobile menu dropdown */}
    {menuOpen && (
      <div className="border-t border-border bg-background sm:hidden">
        <div className="mx-auto max-w-7xl px-4 py-3 space-y-2">
          <div className="flex items-center gap-2 px-3 py-2 rounded-sm bg-secondary text-secondary-foreground text-sm font-semibold">
            <ShieldCheck className="size-4" />
            {role} view
          </div>
          <Button 
            variant="ghost" 
            size="sm" 
            className="w-full justify-start" 
            onClick={() => {
              setMenuOpen(false);
            }}
          >
            <Bell className="size-4" /> Notifications
          </Button>
          <Button 
            variant="outline" 
            size="sm" 
            className="w-full justify-start"
            onClick={() => {
              setMenuOpen(false);
              navigate({ to: "/login" });
            }}
          >
            <LogOut className="size-4" /> Sign out
          </Button>
        </div>
      </div>
    )}
  </header>;
}

export function PageTitle({ eyebrow, title, description, action }: { eyebrow: string; title: string; description: string; action?: ReactNode }) {
  return <div className="border-b border-border bg-surface-soft">
    <div className="mx-auto flex max-w-7xl flex-col gap-5 px-4 py-8 sm:px-6 md:flex-row md:items-end md:justify-between">
      <div><p className="eyebrow">{eyebrow}</p><h1 className="mt-2 font-display text-3xl font-bold text-primary sm:text-4xl">{title}</h1><p className="mt-2 max-w-2xl text-sm text-muted-foreground">{description}</p></div>{action}
    </div>
  </div>;
}

export function StatusBadge({ status }: { status: RequestStatus }) {
  const cls = status === "Pending" ? "status-pending" : status === "Processing" ? "status-processing" : status === "Ready for Pickup/Delivery" ? "status-ready" : status === "Completed" ? "status-completed" : "status-declined";
  return <span className={`status-badge ${cls}`}>{status}</span>;
}

export function EmptyState({ children }: { children: ReactNode }) { return <div className="rounded-md border border-dashed border-border px-6 py-12 text-center text-sm text-muted-foreground">{children}</div>; }

export function SectionHeading({ title, description, link }: { title: string; description: string; link?: { label: string; to: "/login" | "/student" | "/admin" } }) {
  return <div className="mb-6 flex items-end justify-between gap-4"><div><h2 className="font-display text-2xl font-bold text-primary">{title}</h2><p className="mt-1 text-sm text-muted-foreground">{description}</p></div>{link && <Link to={link.to} className="hidden items-center text-sm font-semibold text-primary sm:flex">{link.label}<ChevronRight className="size-4" /></Link>}</div>;
}

import { createFileRoute, Link } from "@tanstack/react-router";
import {
  ArrowRight,
  BadgeCheck,
  BookOpenCheck,
  CheckCircle2,
  Clock3,
  CreditCard,
  FileCheck2,
  MapPin,
  PackageCheck,
  ShieldCheck,
  Info,
} from "lucide-react";
import heroImage from "@/assets/registrar-hero.jpg";
import { Brand, SectionHeading } from "@/components/registrar-ui";
import { Button } from "@/components/ui/button";
import { DOCUMENTS } from "@/lib/registrar-store";
import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from "@/components/ui/accordion";

export const Route = createFileRoute("/")({
  head: () => ({
    meta: [
      {
        title:
          "USeP Virtual Registrar Portal — Documents, Records & Academic Transactions",
      },
      {
        name: "description",
        content:
          "Request registrar documents, submit student record corrections, pay online, and track academic transactions at USeP Main.",
      },
      { property: "og:title", content: "USeP Virtual Registrar Portal" },
      {
        property: "og:description",
        content:
          "Registrar documents, student data corrections, and academic transactions in one connected portal.",
      },
      { property: "og:type", content: "website" },
      { name: "twitter:card", content: "summary_large_image" },
    ],
  }),
  component: HomePage,
});

const steps = [
  [FileCheck2, "Request Online", "Choose a document or submit a records correction."],
  [CreditCard, "Pay Digitally", "Select a simulated online payment method."],
  [Clock3, "Registrar Processes", "Follow each approval and processing update."],
  [PackageCheck, "Receive or Complete", "Collect documents or close an academic transaction."],
] as const;

function HomePage() {
  return (
    <main className="bg-background">
      <div className="top-strip">
        <span>University of Southeastern Philippines — Main Campus, Davao City</span>
        <span className="hidden sm:inline">(082) 227-8192 · registrar@usep.edu.ph</span>
      </div>

      <header className="border-b border-border bg-background">
        <div className="mx-auto flex h-16 max-w-7xl items-center justify-between px-4 sm:px-6">
          <Brand />
          <nav className="hidden items-center gap-8 text-sm font-medium text-muted-foreground md:flex">
            <a href="#services">Services</a>
            <a href="#process">How It Works</a>
            <Link to="/student">Track Request</Link>
          </nav>
          <Button asChild size="sm">
            <Link to="/login">Sign In</Link>
          </Button>
        </div>
      </header>

      <section className="relative isolate min-h-[610px] overflow-hidden bg-primary text-primary-foreground sm:min-h-[620px]">
        <img
          src={heroImage}
          alt="Student receiving registrar documents at a university service counter"
          width={1600}
          height={900}
          className="absolute inset-0 h-full w-full object-cover object-center"
        />
        <div className="hero-overlay absolute inset-0" />
        <div className="relative mx-auto flex min-h-[610px] max-w-7xl items-center px-4 py-16 sm:min-h-[620px] sm:px-6">
          <div className="max-w-2xl">
            <span className="hero-badge">
              <BadgeCheck className="size-3.5" />
              USeP Virtual Registrar Portal
            </span>
            <h1 className="mt-6 font-display text-5xl font-bold leading-[1.06] sm:text-6xl lg:text-7xl">
              Every registrar request.{" "}
              <span className="text-gold">One connected portal.</span>
            </h1>
            <p className="mt-6 max-w-xl text-base leading-7 text-primary-foreground/85">
              Alumni and students of USeP Main can now request official registrar
              documents, correct academic records, pay online, and track
              university transactions seamlessly from anywhere.
            </p>
            <div className="mt-8 flex flex-wrap gap-3">
              <Button asChild variant="gold" size="lg">
                <Link to="/login">
                  Enter Portal <ArrowRight />
                </Link>
              </Button>
              <Button asChild variant="heroOutline" size="lg">
                <Link to="/student">Track My Request</Link>
              </Button>
            </div>
            <div className="mt-10 flex flex-wrap gap-8">
              <div>
                <strong className="metric">7</strong>
                <span>Document services</span>
              </div>
              <div>
                <strong className="metric">3</strong>
                <span>Correction types</span>
              </div>
              <div>
                <strong className="metric">5</strong>
                <span>Academic workflows</span>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section id="services" className="py-16">
        <div className="mx-auto max-w-7xl px-4 sm:px-6">
          <SectionHeading
            title="Registrar Services"
            description="Official documents and student record services in one catalog."
            link={{ label: "View student portal", to: "/student" }}
          />
          <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
            {DOCUMENTS.slice(0, 4).map((doc) => (
              <article className="service-card" key={doc.name}>
                <span className="service-icon">
                  <BookOpenCheck />
                </span>
                <p className="mt-5 text-xs font-semibold uppercase text-muted-foreground">
                  {doc.category}
                </p>
                <h3 className="mt-1 font-semibold text-foreground">{doc.name}</h3>
                <p className="mt-2 text-xs leading-5 text-muted-foreground">
                  {doc.description}
                </p>
                <div className="mt-5 flex items-center justify-between">
                  <strong className="text-primary">₱{doc.price}</strong>
                  <Link
                    to="/login"
                    className="rounded-sm bg-gold px-3 py-1.5 text-xs font-bold text-gold-foreground"
                  >
                    Request
                  </Link>
                </div>
              </article>
            ))}
          </div>
        </div>
      </section>

      <section id="process" className="border-y border-border bg-surface-soft py-16">
        <div className="mx-auto max-w-7xl px-4 sm:px-6">
          <div className="text-center">
            <h2 className="font-display text-3xl font-bold text-primary">How It Works</h2>
            <p className="mt-2 text-sm text-muted-foreground">
              From request to release in four clear steps.
            </p>
          </div>
          <div className="mt-9 grid gap-3 md:grid-cols-4">
            {steps.map(([Icon, title, copy], index) => (
              <article className="step-card" key={title}>
                <span className="step-number">0{index + 1}</span>
                <span className="service-icon">
                  <Icon />
                </span>
                <h3 className="mt-5 font-semibold">{title}</h3>
                <p className="mt-2 text-sm leading-6 text-muted-foreground">{copy}</p>
              </article>
            ))}
          </div>
        </div>
      </section>

      <section className="py-20 bg-background">
        <div className="mx-auto max-w-7xl px-4 sm:px-6">
          <div className="grid gap-12 lg:grid-cols-2 lg:gap-16">
            <div>
              <span className="inline-block rounded-full bg-rose-50 px-3 py-1 text-[11px] font-bold uppercase tracking-wider text-rose-900 mb-5">
                Campus Operations
              </span>
              <h2 className="font-display text-4xl font-bold text-primary mb-5">
                Office of the University
                <br />
                Registrar
              </h2>
              <p className="text-muted-foreground mb-8 text-sm leading-relaxed max-w-sm">
                Main counter releasing and on-campus document evaluations are open regular weekdays.
              </p>
              <div className="rounded-[20px] border border-border bg-card p-7 shadow-sm mb-6">
                <div className="grid grid-cols-[1fr_auto] gap-y-5 text-sm">
                  <span className="text-muted-foreground">Days:</span>
                  <span className="font-medium text-right text-primary">Monday – Friday</span>
                  <span className="text-muted-foreground">Hours:</span>
                  <span className="font-medium text-right text-primary">8:00 AM – 5:00 PM</span>
                  <span className="text-muted-foreground">No Noon Break Policy:</span>
                  <span className="text-right">
                    <span className="inline-block rounded-md bg-emerald-50 px-2.5 py-1 text-[11px] font-semibold text-emerald-700">
                      Continuous Service
                    </span>
                  </span>
                  <span className="text-muted-foreground">Location:</span>
                  <span className="font-medium text-right text-primary">
                    Ground Floor, Administration Bldg., Obrero Campus
                  </span>
                </div>
              </div>
              <div className="rounded-xl border border-amber-200/60 bg-amber-50/50 p-4 text-sm text-amber-900 flex gap-3 shadow-sm">
                <Info className="size-5 shrink-0 text-amber-600" />
                <p className="leading-relaxed">
                  Please present your <strong>Request Reference Slip</strong> along with 1 valid
                  Government/Student ID upon claiming physical certificates.
                </p>
              </div>
            </div>
            <div>
              <span className="block text-[11px] font-bold uppercase tracking-wider text-amber-800 mb-5">
                Quick Answers
              </span>
              <h2 className="font-display text-4xl font-bold text-primary mb-8">
                Frequently Asked Questions
              </h2>
              <Accordion type="single" collapsible className="w-full flex flex-col gap-4">
                <AccordionItem
                  value="item-1"
                  className="border rounded-xl bg-card px-5 data-[state=open]:shadow-sm transition-all border-b"
                >
                  <AccordionTrigger className="hover:no-underline font-medium text-left py-5 text-[15px]">
                    How can an authorized representative claim my document?
                  </AccordionTrigger>
                  <AccordionContent className="text-muted-foreground leading-relaxed text-sm pb-5">
                    Authorized representatives must bring: (1) Signed Authorization Letter from the
                    student/alumnus, (2) Photocopy of the student's valid ID with 3 specimen
                    signatures, and (3) The representative's original valid government ID.
                  </AccordionContent>
                </AccordionItem>
                <AccordionItem
                  value="item-2"
                  className="border rounded-xl bg-card px-5 data-[state=open]:shadow-sm transition-all border-b"
                >
                  <AccordionTrigger className="hover:no-underline font-medium text-left py-5 text-[15px]">
                    Can I request official Transcript of Records if I have a pending clearance?
                  </AccordionTrigger>
                  <AccordionContent className="text-muted-foreground leading-relaxed text-sm pb-5">
                    No, all university clearances must be settled before you can request official
                    documents like the Transcript of Records.
                  </AccordionContent>
                </AccordionItem>
                <AccordionItem
                  value="item-3"
                  className="border rounded-xl bg-card px-5 data-[state=open]:shadow-sm transition-all border-b"
                >
                  <AccordionTrigger className="hover:no-underline font-medium text-left py-5 text-[15px]">
                    How do I track my nationwide courier delivery parcel?
                  </AccordionTrigger>
                  <AccordionContent className="text-muted-foreground leading-relaxed text-sm pb-5">
                    Once your document is dispatched, you will receive a tracking number via email
                    and on your portal dashboard to monitor its delivery status.
                  </AccordionContent>
                </AccordionItem>
                <AccordionItem
                  value="item-4"
                  className="border rounded-xl bg-card px-5 data-[state=open]:shadow-sm transition-all border-b"
                >
                  <AccordionTrigger className="hover:no-underline font-medium text-left py-5 text-[15px]">
                    What are the acceptable online payment methods?
                  </AccordionTrigger>
                  <AccordionContent className="text-muted-foreground leading-relaxed text-sm pb-5">
                    We currently accept payments through standard online banking channels,
                    credit/debit cards, and major e-wallets like GCash and Maya.
                  </AccordionContent>
                </AccordionItem>
              </Accordion>
            </div>
          </div>
        </div>
      </section>

      <section className="bg-primary py-10 text-primary-foreground">
        <div className="mx-auto grid max-w-7xl gap-7 px-4 sm:px-6 md:grid-cols-3">
          {[
            [ShieldCheck, "Official & Authentic", "Registrar-verified records and certified copies."],
            [CheckCircle2, "Live Status Updates", "Visual progress across every request stage."],
            [MapPin, "Campus or Courier", "Flexible pickup and simulated delivery options."],
          ].map(([Icon, title, copy]) => (
            <div className="flex gap-4" key={title as string}>
              <Icon className="mt-1 size-5 shrink-0 text-gold" />
              <div>
                <strong>{title as string}</strong>
                <p className="mt-1 text-sm text-primary-foreground/70">{copy as string}</p>
              </div>
            </div>
          ))}
        </div>
      </section>

      <footer className="bg-primary-deep py-8 text-primary-foreground">
        <div className="mx-auto flex max-w-7xl flex-col gap-5 px-4 sm:flex-row sm:items-center sm:justify-between sm:px-6">
          <Brand light />
          <p className="text-xs text-primary-foreground/60">
            © 2026 University of Southeastern Philippines. UI concept prototype — not an official
            USeP system.
          </p>
        </div>
      </footer>
    </main>
  );
}
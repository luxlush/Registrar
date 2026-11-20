# System Architecture - Database Integration

## Data Flow Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                        Student Portal                            │
│  ┌────────────────────────────────────────────────────────┐    │
│  │  1. Select Documents                                    │    │
│  │  2. Click "Pay & Submit Request"                        │    │
│  │  3. Checkout Modal Opens ──────────────────────┐       │    │
│  │  4. Click "Confirm Payment" (no scan needed)   │       │    │
│  │  5. Requests Submitted                         │       │    │
│  └────────────────────────────────────────────────┼───────┘    │
└─────────────────────────────────────────────────┼─┼────────────┘
                                                   │ │
                                                   │ │
                         ┌─────────────────────────┘ │
                         │                           │
                         ▼                           ▼
              ┌──────────────────────┐    ┌──────────────────────┐
              │  registrar-store.ts  │    │  Payment Modal UI     │
              │                      │    │  - QR Placeholder     │
              │  • addRequest()      │    │  - Amount Display     │
              │  • getRequests()     │    │  - Confirm Button     │
              │  • getDashboardStats │    │  - Demo Mode Notice   │
              └──────────┬───────────┘    └──────────────────────┘
                         │
                         │
          ┌──────────────┴──────────────┐
          │                             │
          ▼                             ▼
┌──────────────────┐         ┌──────────────────────┐
│   Demo Mode      │         │   Database Mode      │
│  (localStorage)  │         │     (MySQL)          │
│                  │         │                      │
│  • Seed Data     │         │  • src/lib/db.ts     │
│  • No Setup      │         │  • src/api/          │
│  • Instant       │         │    requests.ts       │
│                  │         │  • Real Data         │
└────────┬─────────┘         └──────────┬───────────┘
         │                              │
         │      Selected by:            │
         │      USE_DATABASE flag       │
         └──────────────┬───────────────┘
                        │
                        ▼
         ┌──────────────────────────────┐
         │    Admin Dashboard & Queue    │
         │                               │
         │  • Total Queue                │
         │  • Pending Review             │
         │  • In Process                 │
         │  • Completed This Week        │
         │  • Document Checks            │
         │  • SIS Entries                │
         │  • Active Document Queue      │
         │  • Ready for Pickup           │
         │  • Under Evaluation           │
         │  • Pending Validation         │
         └───────────────────────────────┘
```

## Component Architecture

```
src/
├── routes/
│   ├── student.tsx ──────────► Student Portal
│   │   ├── Document Selection
│   │   ├── Payment Checkout Modal ★ NEW
│   │   ├── Records Correction
│   │   └── Request Tracker
│   │
│   ├── admin-dashboard.tsx ──► Dashboard with Real Stats ★ UPDATED
│   │   ├── KPI Cards (live data)
│   │   ├── Velocity Chart
│   │   ├── Workload Donut
│   │   └── SLA Index
│   │
│   └── admin.tsx ────────────► Document Queue ★ UPDATED
│       ├── Request Statistics (live)
│       ├── Document Queue
│       └── Academic Transactions
│
├── lib/
│   ├── registrar-store.ts ───► Data Layer ★ UPDATED
│   │   ├── localStorage mode
│   │   ├── Database mode
│   │   ├── getDashboardStats()
│   │   └── getDocumentQueueStats()
│   │
│   └── db.ts ────────────────► Database Connection ★ NEW
│       ├── Connection Pool
│       ├── query() helper
│       └── queryOne() helper
│
└── api/
    └── requests.ts ──────────► API Endpoints ★ NEW
        ├── getDocumentRequests()
        ├── getDashboardStats()
        ├── getDocumentQueueStats()
        ├── updateRequestStatus()
        └── getFilteredRequests()
```

## Database Schema

```
┌──────────────────┐
│     users        │
├──────────────────┤
│ id               │───┐
│ university_id    │   │
│ first_name       │   │
│ last_name        │   │
│ email            │   │
│ role             │   │
│ college          │   │
│ program          │   │
└──────────────────┘   │
                       │
         ┌─────────────┘
         │
         │     ┌──────────────────┐
         └────►│    requests      │
               ├──────────────────┤
               │ id               │───┐
               │ tracking_code    │   │
               │ student_id       │   │
               │ fulfillment      │   │
               │ payment_method   │   │
               │ total_fee        │   │
               │ status           │   │
               │ created_at       │   │
               │ updated_at       │   │
               └──────────────────┘   │
                                      │
                    ┌─────────────────┘
                    │
                    │     ┌──────────────────┐
                    └────►│  request_items   │
                          ├──────────────────┤
                          │ id               │
                          │ request_id       │
                          │ document_id      │───┐
                          │ copies           │   │
                          └──────────────────┘   │
                                                 │
                               ┌─────────────────┘
                               │
                               │     ┌──────────────────┐
                               └────►│ document_types   │
                                     ├──────────────────┤
                                     │ id               │
                                     │ category         │
                                     │ name             │
                                     │ base_fee         │
                                     │ is_active        │
                                     └──────────────────┘
```

## Request Status Flow

```
┌─────────────────┐
│ Student Submits │
│   Request       │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Pending Review  │ ◄── Initial Status
└────────┬────────┘
         │
         │ Admin Reviews
         │
         ▼
┌─────────────────┐
│   Processing    │ ◄── In Progress
└────────┬────────┘
         │
         │ Document Ready
         │
         ▼
┌─────────────────┐
│ Ready for       │ ◄── Awaiting Pickup
│    Pickup       │
└────────┬────────┘
         │
         │ Student Receives
         │
         ▼
┌─────────────────┐
│   Completed     │ ◄── Final Status
└─────────────────┘

Alternative Path:
┌─────────────────┐
│   Declined      │ ◄── Rejected Request
└─────────────────┘
```

## Payment Flow (Demo Mode)

```
Student Portal
      │
      │ Selects Documents
      │
      ▼
┌──────────────────────┐
│  Cart Summary        │
│  • Documents: 2      │
│  • Total: ₱250.00    │
│  • Method: GCash     │
└──────────┬───────────┘
           │
           │ Click "Pay & Submit"
           │
           ▼
┌──────────────────────┐
│  Checkout Modal      │
│  ┌────────────────┐  │
│  │ Secure Checkout│  │
│  ├────────────────┤  │
│  │  QR Code Area  │  │
│  │  [Placeholder] │  │
│  ├────────────────┤  │
│  │ ₱250.00        │  │
│  ├────────────────┤  │
│  │ Demo Mode      │  │
│  │ Notice         │  │
│  ├────────────────┤  │
│  │ [Confirm       │  │
│  │  Payment]      │  │ ◄── Works without scan
│  └────────────────┘  │
└──────────┬───────────┘
           │
           │ Click Confirm
           │
           ▼
┌──────────────────────┐
│  Requests Created    │
│  Status: Pending     │
│  Success Message     │
└──────────────────────┘
```

## Dashboard Statistics Calculation

```
MySQL Database
      │
      │ Query
      │
      ▼
┌──────────────────────────────────────────┐
│  getDashboardStats()                     │
│  ┌────────────────────────────────────┐  │
│  │ SELECT COUNT(*) as total_queue     │  │
│  │ FROM requests                      │  │
│  │ WHERE status != 'Declined'         │  │
│  └────────────────────────────────────┘  │
│  ┌────────────────────────────────────┐  │
│  │ SELECT COUNT(*)                    │  │
│  │ WHERE status = 'Pending Review'    │  │
│  └────────────────────────────────────┘  │
│  ┌────────────────────────────────────┐  │
│  │ SELECT COUNT(*)                    │  │
│  │ WHERE status = 'Processing'        │  │
│  └────────────────────────────────────┘  │
│  ┌────────────────────────────────────┐  │
│  │ SELECT COUNT(*)                    │  │
│  │ WHERE status = 'Completed'         │  │
│  │   AND updated_at >= 7 days ago     │  │
│  └────────────────────────────────────┘  │
└──────────────┬───────────────────────────┘
               │
               │ Returns JSON
               │
               ▼
┌──────────────────────────────────────────┐
│  Admin Dashboard                         │
│  ┌────────────────────────────────────┐  │
│  │ Total Queue: 42                    │  │
│  │ Pending Review: 1                  │  │
│  │ In Process: 14                     │  │
│  │ Completed This Week: 128           │  │
│  └────────────────────────────────────┘  │
└──────────────────────────────────────────┘
```

## Mode Toggle Mechanism

```
Application Start
      │
      ▼
┌─────────────────────────────┐
│ Check USE_DATABASE flag     │
│                             │
│ localStorage.getItem(       │
│   'usep-use-database'       │
│ ) === 'true'                │
└─────────────┬───────────────┘
              │
      ┌───────┴────────┐
      │                │
   YES│                │NO
      │                │
      ▼                ▼
┌──────────┐    ┌──────────┐
│ Database │    │   Demo   │
│   Mode   │    │   Mode   │
└────┬─────┘    └────┬─────┘
     │               │
     │               │
     ▼               ▼
  API Calls     localStorage
     │               │
     └───────┬───────┘
             │
             ▼
    ┌────────────────┐
    │ UI Components  │
    │ Receive Data   │
    └────────────────┘
```

## Key Benefits

### 1. Dual Mode Operation
- **Demo Mode**: Quick testing, no setup
- **Database Mode**: Production-ready, real data

### 2. Seamless Integration
- No breaking changes to existing UI
- Backward compatible with localStorage
- Automatic fallback on errors

### 3. Type Safety
- TypeScript interfaces for all data
- Compile-time error checking
- IntelliSense support

### 4. Real-time Updates
- Dashboard reflects actual data
- Status changes update immediately
- Statistics calculated on-demand

### 5. Future-Ready
- Payment gateway integration ready
- Scalable database structure
- API-first architecture

## Technology Stack

```
Frontend                Backend               Database
┌──────────┐          ┌──────────┐          ┌──────────┐
│  React   │  ◄────►  │ TanStack │  ◄────►  │  MySQL   │
│  19.2.0  │          │  Start   │          │   8.0+   │
└──────────┘          └──────────┘          └──────────┘
     │                     │                      │
     ▼                     ▼                      ▼
┌──────────┐          ┌──────────┐          ┌──────────┐
│Tailwind  │          │  Nitro   │          │  mysql2  │
│   CSS    │          │  Server  │          │  ^3.11   │
└──────────┘          └──────────┘          └──────────┘
```

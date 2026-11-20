export type RequestStatus = "Pending Review" | "Processing" | "Ready for Pickup" | "Declined" | "Completed";
export type RequestKind = "Document" | "Records Correction";

export type RegistrarRequest = {
  id: string;
  studentName: string;
  studentNumber: string;
  course: string;
  kind: RequestKind;
  requestType: string;
  purpose: string;
  delivery: string;
  payment: string;
  status: RequestStatus;
  createdAt: string;
};

export type AcademicTransaction = {
  id: string;
  studentName: string;
  studentNumber: string;
  course: string;
  category: string;
  detail: string;
  status: RequestStatus;
  createdAt: string;
};

// Dashboard statistics type
export type DashboardStats = {
  total_queue: number;
  pending_review: number;
  in_process: number;
  completed_this_week: number;
  document_checks: number;
  sis_entries: number;
};

// Document queue statistics type
export type DocumentQueueStats = {
  active_queue: number;
  prioritized_intake: number;
  ready_for_pickup: number;
  batch_slip: number;
  window_counter: number;
  under_evaluation: number;
  evaluating: number;
  sla_day: number;
  sla_total: number;
  pending_validation: number;
  action_required: number;
  psa_registry_check: number;
};

export const DOCUMENTS = [
  { name: "Transcript of Records (TOR)", category: "Academic Records", price: 150, description: "Official academic record for employment, transfer, or graduate school." },
  { name: "Certificate of Enrollment (COE)", category: "Enrollment", price: 80, description: "Proof of current enrollment status for scholarships, benefits, or verification." },
  { name: "Certificate of Grades / Certified Grades", category: "Academic Records", price: 100, description: "Certified semester or subject grades overview." },
  { name: "Certificate of Graduation", category: "Graduation", price: 100, description: "Official proof that degree requirements have been completed." },
  { name: "Diploma", category: "Graduation", price: 350, description: "Post-graduation diploma release or duplicate tracking." },
  { name: "Honorable Dismissal / Transfer Credential", category: "Transfer", price: 150, description: "Required credential for transfer to another institution." },
  { name: "Authentication / Certification of Documents", category: "Certification", price: 80, description: "Certified true copies of registrar-issued documents." },
] as const;

const REQUESTS_KEY = "usep-registrar-requests-v1";
const TRANSACTIONS_KEY = "usep-academic-transactions-v1";
export const STORE_EVENT = "usep-registrar-updated";

const seedRequests: RegistrarRequest[] = [
  { id: "REG-260914", studentName: "Juan D. Dela Cruz", studentNumber: "2018-00123", course: "BS Computer Science", kind: "Document", requestType: "Transcript of Records (TOR)", purpose: "Employment", delivery: "Courier delivery", payment: "GCash", status: "Processing", createdAt: "2026-09-21" },
  { id: "REG-260903", studentName: "Juan D. Dela Cruz", studentNumber: "2018-00123", course: "BS Computer Science", kind: "Document", requestType: "Certificate of Graduation", purpose: "Board examination", delivery: "Pickup", payment: "Maya", status: "Ready for Pickup", createdAt: "2026-09-18" },
  { id: "COR-260827", studentName: "Maria L. Santos", studentNumber: "2021-00841", course: "BS Biology", kind: "Records Correction", requestType: "Birthdate correction", purpose: "Correct date on student record", delivery: "Not applicable", payment: "Not applicable", status: "Pending Review", createdAt: "2026-09-22" },
];

const seedTransactions: AcademicTransaction[] = [
  { id: "ACA-26071", studentName: "Paolo R. Reyes", studentNumber: "2023-01421", course: "BS Information Technology", category: "Add/Drop & Enrollment", detail: "Drop IT 214; add IT 223", status: "Pending Review", createdAt: "2026-09-22" },
  { id: "ACA-26068", studentName: "Ana C. Flores", studentNumber: "2022-00612", course: "BS Psychology", category: "Shifting & Transfer Evaluation", detail: "Shift from BA Communication", status: "Processing", createdAt: "2026-09-20" },
  { id: "ACA-26055", studentName: "Mark T. Lim", studentNumber: "2020-00389", course: "BS Civil Engineering", category: "Graduation & Verification", detail: "Final graduation evaluation", status: "Ready for Pickup", createdAt: "2026-09-16" },
  { id: "ACA-26043", studentName: "Lea B. Ramos", studentNumber: "2021-01048", course: "BS Entrepreneurship", category: "LOA & Readmission", detail: "Readmission after one semester LOA", status: "Completed", createdAt: "2026-09-11" },
];

function read<T>(key: string, fallback: T[]): T[] {
  if (typeof window === "undefined") return fallback;
  const saved = window.localStorage.getItem(key);
  if (!saved) {
    window.localStorage.setItem(key, JSON.stringify(fallback));
    return fallback;
  }
  try { return JSON.parse(saved) as T[]; } catch { return fallback; }
}

function write<T>(key: string, value: T[]) {
  window.localStorage.setItem(key, JSON.stringify(value));
  window.dispatchEvent(new Event(STORE_EVENT));
}

// Flag to determine if we should use the database or localStorage
// Set to false for demo mode (localStorage), true for production (database)
// Check only on client-side to avoid SSR issues
function isDatabaseEnabled(): boolean {
  if (typeof window === 'undefined') return false;
  return window.localStorage.getItem('usep-use-database') === 'true';
}

// Database API helpers
async function fetchFromApi<T>(endpoint: string, options?: RequestInit): Promise<T> {
  const response = await fetch(endpoint, {
    ...options,
    headers: {
      'Content-Type': 'application/json',
      ...options?.headers,
    },
  });
  
  if (!response.ok) {
    throw new Error(`API error: ${response.statusText}`);
  }
  
  return response.json();
}

// Get requests - from database if enabled, otherwise localStorage
export const getRequests = async (): Promise<RegistrarRequest[]> => {
  // Always use localStorage for now (database integration ready but not active by default)
  const USE_DATABASE = isDatabaseEnabled();
  
  if (USE_DATABASE) {
    try {
      const data = await fetchFromApi<any[]>('/api/requests');
      // Transform database format to app format
      return data.map(req => ({
        id: req.tracking_code,
        studentName: req.student_name,
        studentNumber: req.student_number,
        course: req.course || req.program,
        kind: "Document" as RequestKind,
        requestType: req.items?.[0]?.document_name || "Unknown",
        purpose: "Not specified",
        delivery: req.fulfillment_method === 'pickup' ? 'Pickup' : 'Courier delivery',
        payment: req.payment_method,
        status: req.status,
        createdAt: new Date(req.created_at).toISOString().slice(0, 10),
      }));
    } catch (error) {
      console.error('Failed to fetch from database, falling back to localStorage:', error);
      return read<RegistrarRequest>(REQUESTS_KEY, seedRequests);
    }
  }
  return read<RegistrarRequest>(REQUESTS_KEY, seedRequests);
};

// Get dashboard stats - from database if enabled
export const getDashboardStats = async (): Promise<DashboardStats> => {
  const USE_DATABASE = isDatabaseEnabled();
  
  if (USE_DATABASE) {
    try {
      return await fetchFromApi<DashboardStats>('/api/stats/dashboard');
    } catch (error) {
      console.error('Failed to fetch dashboard stats from database:', error);
      // Fallback to calculated stats from localStorage
      const requests = read<RegistrarRequest>(REQUESTS_KEY, seedRequests);
      return {
        total_queue: requests.length,
        pending_review: requests.filter(r => r.status === 'Pending Review').length,
        in_process: requests.filter(r => r.status === 'Processing').length,
        completed_this_week: requests.filter(r => r.status === 'Completed').length,
        document_checks: Math.floor(requests.length * 0.7),
        sis_entries: Math.floor(requests.length * 0.3),
      };
    }
  }
  
  // Calculate from localStorage
  const requests = read<RegistrarRequest>(REQUESTS_KEY, seedRequests);
  return {
    total_queue: requests.length,
    pending_review: requests.filter(r => r.status === 'Pending Review').length,
    in_process: requests.filter(r => r.status === 'Processing').length,
    completed_this_week: requests.filter(r => r.status === 'Completed').length,
    document_checks: Math.floor(requests.length * 0.7),
    sis_entries: Math.floor(requests.length * 0.3),
  };
};

// Get document queue stats - from database if enabled
export const getDocumentQueueStats = async (): Promise<DocumentQueueStats> => {
  const USE_DATABASE = isDatabaseEnabled();
  
  if (USE_DATABASE) {
    try {
      return await fetchFromApi<DocumentQueueStats>('/api/stats/queue');
    } catch (error) {
      console.error('Failed to fetch queue stats from database:', error);
      // Fallback to calculated stats
      const requests = read<RegistrarRequest>(REQUESTS_KEY, seedRequests);
      return {
        active_queue: requests.filter(r => ['Pending Review', 'Processing'].includes(r.status)).length,
        prioritized_intake: requests.filter(r => r.status === 'Pending Review').length,
        ready_for_pickup: requests.filter(r => r.status === 'Ready for Pickup').length,
        batch_slip: 1,
        window_counter: 2,
        under_evaluation: requests.filter(r => r.status === 'Processing').length,
        evaluating: requests.filter(r => r.status === 'Processing').length,
        sla_day: 2,
        sla_total: 3,
        pending_validation: requests.filter(r => r.status === 'Pending Review').length,
        action_required: requests.filter(r => r.status === 'Pending Review').length,
        psa_registry_check: 0,
      };
    }
  }
  
  // Calculate from localStorage
  const requests = read<RegistrarRequest>(REQUESTS_KEY, seedRequests);
  return {
    active_queue: requests.filter(r => ['Pending Review', 'Processing'].includes(r.status)).length,
    prioritized_intake: requests.filter(r => r.status === 'Pending Review').length,
    ready_for_pickup: requests.filter(r => r.status === 'Ready for Pickup').length,
    batch_slip: 1,
    window_counter: 2,
    under_evaluation: requests.filter(r => r.status === 'Processing').length,
    evaluating: requests.filter(r => r.status === 'Processing').length,
    sla_day: 2,
    sla_total: 3,
    pending_validation: requests.filter(r => r.status === 'Pending Review').length,
    action_required: requests.filter(r => r.status === 'Pending Review').length,
    psa_registry_check: 0,
  };
};

export const saveRequests = (items: RegistrarRequest[]) => write(REQUESTS_KEY, items);

export const addRequest = (item: Omit<RegistrarRequest, "id" | "createdAt" | "status">) => {
  const prefix = item.kind === "Document" ? "REG" : "COR";
  const request: RegistrarRequest = { ...item, id: `${prefix}-${String(Date.now()).slice(-6)}`, createdAt: new Date().toISOString().slice(0, 10), status: "Pending Review" };
  saveRequests([request, ...read<RegistrarRequest>(REQUESTS_KEY, seedRequests)]);
  return request;
};

export const updateRequestStatus = async (id: string, status: RequestStatus) => {
  const USE_DATABASE = isDatabaseEnabled();
  
  if (USE_DATABASE) {
    try {
      // Extract numeric ID from tracking code for database update
      const numericId = parseInt(id.split('-').pop() || '0');
      await fetchFromApi('/api/requests/update-status', {
        method: 'POST',
        body: JSON.stringify({ id: numericId, status }),
      });
      window.dispatchEvent(new Event(STORE_EVENT));
    } catch (error) {
      console.error('Failed to update status in database:', error);
    }
  } else {
    saveRequests(read<RegistrarRequest>(REQUESTS_KEY, seedRequests).map((item) => item.id === id ? { ...item, status } : item));
  }
};

export const getTransactions = () => read<AcademicTransaction>(TRANSACTIONS_KEY, seedTransactions);
export const saveTransactions = (items: AcademicTransaction[]) => write(TRANSACTIONS_KEY, items);
export const updateTransactionStatus = (id: string, status: RequestStatus) => saveTransactions(getTransactions().map((item) => item.id === id ? { ...item, status } : item));
export const resetDemoData = () => { write(REQUESTS_KEY, seedRequests); write(TRANSACTIONS_KEY, seedTransactions); };

// Toggle database mode
export const setDatabaseMode = (enabled: boolean) => {
  if (typeof window !== 'undefined') {
    window.localStorage.setItem('usep-use-database', enabled ? 'true' : 'false');
    window.dispatchEvent(new Event(STORE_EVENT));
  }
};

export const isDatabaseMode = () => isDatabaseEnabled();

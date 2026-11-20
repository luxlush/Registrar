const STORE_EVENT = "usep-registrar-updated";
const REQUESTS_KEY = "usep-registrar-requests-v1";
const TRANSACTIONS_KEY = "usep-academic-transactions-v1";

const seedRequests = [
  { id: "REG-260914", studentName: "Juan D. Dela Cruz", studentNumber: "2018-00123", course: "BS Computer Science", kind: "Document", requestType: "Transcript of Records (TOR)", purpose: "Employment", delivery: "Courier delivery", payment: "GCash", status: "Processing", createdAt: "2026-09-21" },
  { id: "REG-260903", studentName: "Juan D. Dela Cruz", studentNumber: "2018-00123", course: "BS Computer Science", kind: "Document", requestType: "Certificate of Graduation", purpose: "Board examination", delivery: "Pickup", payment: "Maya", status: "Ready for Pickup/Delivery", createdAt: "2026-09-18" },
  { id: "COR-260827", studentName: "Maria L. Santos", studentNumber: "2021-00841", course: "BS Biology", kind: "Records Correction", requestType: "Birthdate correction", purpose: "Correct date on student record", delivery: "Not applicable", payment: "Not applicable", status: "Pending", createdAt: "2026-09-22" }
];

const seedTransactions = [
  { id: "ACA-26071", studentName: "Paolo R. Reyes", studentNumber: "2023-01421", course: "BS Information Technology", category: "Add/Drop & Enrollment", detail: "Drop IT 214; add IT 223", status: "Pending", createdAt: "2026-09-22" },
  { id: "ACA-26068", studentName: "Ana C. Flores", studentNumber: "2022-00612", course: "BS Psychology", category: "Shifting & Transfer Evaluation", detail: "Shift from BA Communication", status: "Processing", createdAt: "2026-09-20" },
  { id: "ACA-26055", studentName: "Mark T. Lim", studentNumber: "2020-00389", course: "BS Civil Engineering", category: "Graduation & Verification", detail: "Final graduation evaluation", status: "Ready for Pickup/Delivery", createdAt: "2026-09-16" },
  { id: "ACA-26043", studentName: "Lea B. Ramos", studentNumber: "2021-01048", course: "BS Entrepreneurship", category: "LOA & Readmission", detail: "Readmission after one semester LOA", status: "Completed", createdAt: "2026-09-11" }
];

function readData(key, fallback) {
  const saved = window.localStorage.getItem(key);
  if (!saved) {
    window.localStorage.setItem(key, JSON.stringify(fallback));
    return fallback;
  }
  try {
    return JSON.parse(saved);
  } catch {
    return fallback;
  }
}

function writeData(key, value) {
  window.localStorage.setItem(key, JSON.stringify(value));
  window.dispatchEvent(new Event(STORE_EVENT));
}

function getRequests() {
  return readData(REQUESTS_KEY, seedRequests);
}

function saveRequests(items) {
  writeData(REQUESTS_KEY, items);
}

function getTransactions() {
  return readData(TRANSACTIONS_KEY, seedTransactions);
}

function saveTransactions(items) {
  writeData(TRANSACTIONS_KEY, items);
}

function addRequest(item) {
  const prefix = item.kind === "Document" ? "REG" : "COR";
  const request = {
    ...item,
    id: `${prefix}-${String(Date.now()).slice(-6)}`,
    createdAt: new Date().toISOString().slice(0, 10),
    status: "Pending"
  };
  saveRequests([request, ...getRequests()]);
  return request;
}

function updateRequestStatus(id, status) {
  saveRequests(getRequests().map(item => item.id === id ? { ...item, status } : item));
}

function updateTransactionStatus(id, status) {
  saveTransactions(getTransactions().map(item => item.id === id ? { ...item, status } : item));
}

function resetDemoData() {
  writeData(REQUESTS_KEY, seedRequests);
  writeData(TRANSACTIONS_KEY, seedTransactions);
}

const DOCUMENTS = [
  { name: "Transcript of Records (TOR)", category: "Academic Records", price: 150, description: "Official academic record for employment, transfer, or graduate school." },
  { name: "Certificate of Enrollment (COE)", category: "Enrollment", price: 80, description: "Proof of current enrollment status for scholarships, benefits, or verification." },
  { name: "Certificate of Grades / Certified Grades", category: "Academic Records", price: 100, description: "Certified semester or subject grades overview." },
  { name: "Certificate of Graduation", category: "Graduation", price: 100, description: "Official proof that degree requirements have been completed." },
  { name: "Diploma", category: "Graduation", price: 350, description: "Post-graduation diploma release or duplicate tracking." },
  { name: "Honorable Dismissal / Transfer Credential", category: "Transfer", price: 150, description: "Required credential for transfer to another institution." },
  { name: "Authentication / Certification of Documents", category: "Certification", price: 80, description: "Certified true copies of registrar-issued documents." },
];

function getStatusClass(status) {
  switch (status) {
    case "Pending": return "status-pending";
    case "Processing": return "status-processing";
    case "Ready for Pickup/Delivery": return "status-ready";
    case "Completed": return "status-completed";
    case "Declined": return "status-declined";
    default: return "";
  }
}

function getStatusBadge(status) {
  return `<span class="status-badge ${getStatusClass(status)}">${status}</span>`;
}

// Ensure the local storage is initialized when app loads
window.addEventListener("DOMContentLoaded", () => {
  getRequests();
  getTransactions();
});

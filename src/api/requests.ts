// API handlers for document requests
// Temporarily commented out until database is set up
// Uncomment and update imports when ready to enable database mode

/*
import { createServerFn } from '@tanstack/react-start';
import { query } from '../lib/db';

export type RequestStatus = 'Pending Review' | 'Processing' | 'Ready for Pickup' | 'Completed' | 'Declined';

export interface DocumentRequest {
  id: number;
  tracking_code: string;
  student_id: number;
  student_name: string;
  student_number: string;
  course: string;
  college: string;
  fulfillment_method: 'pickup' | 'delivery';
  payment_method: 'cash' | 'cashier' | 'online';
  total_fee: number;
  status: RequestStatus;
  created_at: string;
  updated_at: string;
  items: RequestItem[];
}

export interface RequestItem {
  id: number;
  document_name: string;
  document_category: string;
  copies: number;
}

export interface DashboardStats {
  total_queue: number;
  pending_review: number;
  in_process: number;
  completed_this_week: number;
  document_checks: number;
  sis_entries: number;
}

export interface DocumentQueueStats {
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
}

// Get all document requests with student and item details
export const getDocumentRequests = createServerFn('GET', async () => {
  try {
    const requests = await query<any>(`
      SELECT 
        r.id,
        r.tracking_code,
        r.student_id,
        CONCAT(u.first_name, ' ', u.last_name) as student_name,
        u.university_id as student_number,
        u.program as course,
        u.college,
        r.fulfillment_method,
        r.payment_method,
        r.total_fee,
        r.status,
        r.created_at,
        r.updated_at
      FROM requests r
      JOIN users u ON r.student_id = u.id
      ORDER BY r.created_at DESC
    `);

    // Get items for each request
    const requestsWithItems = await Promise.all(
      requests.map(async (request) => {
        const items = await query<any>(`
          SELECT 
            ri.id,
            dt.name as document_name,
            dt.category as document_category,
            ri.copies
          FROM request_items ri
          JOIN document_types dt ON ri.document_id = dt.id
          WHERE ri.request_id = ?
        `, [request.id]);

        return {
          ...request,
          items,
        };
      })
    );

    return requestsWithItems as DocumentRequest[];
  } catch (error) {
    console.error('Error fetching document requests:', error);
    throw new Error('Failed to fetch document requests');
  }
});

// Get dashboard statistics
export const getDashboardStats = createServerFn('GET', async () => {
  try {
    const [stats] = await query<any>(`
      SELECT 
        COUNT(*) as total_queue,
        SUM(CASE WHEN status = 'Pending Review' THEN 1 ELSE 0 END) as pending_review,
        SUM(CASE WHEN status = 'Processing' THEN 1 ELSE 0 END) as in_process,
        SUM(CASE WHEN status = 'Completed' AND updated_at >= DATE_SUB(NOW(), INTERVAL 7 DAY) THEN 1 ELSE 0 END) as completed_this_week
      FROM requests
      WHERE status != 'Declined'
    `);

    // Count document types (for dashboard display)
    const [docStats] = await query<any>(`
      SELECT 
        SUM(CASE WHEN dt.category IN ('Academic Records', 'Certifications', 'Graduation & Transfer') THEN 1 ELSE 0 END) as document_checks
      FROM request_items ri
      JOIN requests r ON ri.request_id = r.id
      JOIN document_types dt ON ri.document_id = dt.id
      WHERE r.status != 'Declined' AND r.status != 'Completed'
    `);

    return {
      total_queue: stats?.total_queue || 0,
      pending_review: stats?.pending_review || 0,
      in_process: stats?.in_process || 0,
      completed_this_week: stats?.completed_this_week || 0,
      document_checks: docStats?.document_checks || 0,
      sis_entries: (stats?.total_queue || 0) - (docStats?.document_checks || 0),
    } as DashboardStats;
  } catch (error) {
    console.error('Error fetching dashboard stats:', error);
    throw new Error('Failed to fetch dashboard statistics');
  }
});

// Get document queue statistics for the admin portal document queue page
export const getDocumentQueueStats = createServerFn('GET', async () => {
  try {
    const [stats] = await query<any>(`
      SELECT 
        COUNT(*) as active_queue,
        SUM(CASE WHEN status = 'Pending Review' THEN 1 ELSE 0 END) as pending_validation,
        SUM(CASE WHEN status = 'Processing' THEN 1 ELSE 0 END) as under_evaluation,
        SUM(CASE WHEN status = 'Ready for Pickup' THEN 1 ELSE 0 END) as ready_for_pickup
      FROM requests
      WHERE status IN ('Pending Review', 'Processing', 'Ready for Pickup')
    `);

    // Calculate SLA metrics (assuming Day 2 of 3 means processing requests)
    const [slaStats] = await query<any>(`
      SELECT 
        COUNT(*) as evaluating_count,
        COUNT(CASE WHEN DATEDIFF(NOW(), created_at) >= 2 THEN 1 END) as day_2_count
      FROM requests
      WHERE status = 'Processing'
    `);

    // Count prioritized intake (recent pending requests)
    const [intakeStats] = await query<any>(`
      SELECT COUNT(*) as prioritized_intake
      FROM requests
      WHERE status = 'Pending Review' 
        AND created_at >= DATE_SUB(NOW(), INTERVAL 1 DAY)
    `);

    // Count pickup-related items
    const [pickupStats] = await query<any>(`
      SELECT 
        COUNT(CASE WHEN fulfillment_method = 'pickup' AND status = 'Ready for Pickup' THEN 1 END) as batch_slip
      FROM requests
    `);

    return {
      active_queue: stats?.active_queue || 0,
      prioritized_intake: intakeStats?.prioritized_intake || 0,
      ready_for_pickup: stats?.ready_for_pickup || 0,
      batch_slip: pickupStats?.batch_slip || 0,
      window_counter: 2, // Static counter number (can be made dynamic)
      under_evaluation: stats?.under_evaluation || 0,
      evaluating: slaStats?.evaluating_count || 0,
      sla_day: 2, // Current day in SLA
      sla_total: 3, // Total SLA days
      pending_validation: stats?.pending_validation || 0,
      action_required: stats?.pending_validation || 0,
      psa_registry_check: 0, // Can be calculated based on specific document types
    } as DocumentQueueStats;
  } catch (error) {
    console.error('Error fetching document queue stats:', error);
    throw new Error('Failed to fetch document queue statistics');
  }
});

// Update request status
export const updateRequestStatus = createServerFn('POST', async (data: { id: number; status: RequestStatus }) => {
  try {
    await query(
      'UPDATE requests SET status = ?, updated_at = NOW() WHERE id = ?',
      [data.status, data.id]
    );
    return { success: true };
  } catch (error) {
    console.error('Error updating request status:', error);
    throw new Error('Failed to update request status');
  }
});

// Get filtered requests for the document queue table
export const getFilteredRequests = createServerFn('GET', async (filters?: {
  search?: string;
  documentType?: string;
  deliveryMode?: string;
  status?: string;
}) => {
  try {
    let sql = `
      SELECT 
        r.id,
        r.tracking_code,
        CONCAT(u.first_name, ' ', u.last_name) as student_name,
        u.university_id as student_number,
        u.program as course,
        u.college,
        GROUP_CONCAT(dt.name SEPARATOR ', ') as documents,
        r.status,
        r.created_at,
        r.fulfillment_method
      FROM requests r
      JOIN users u ON r.student_id = u.id
      JOIN request_items ri ON r.request_id = ri.id
      JOIN document_types dt ON ri.document_id = dt.id
      WHERE 1=1
    `;
    
    const params: any[] = [];

    if (filters?.search) {
      sql += ` AND (
        u.first_name LIKE ? OR 
        u.last_name LIKE ? OR 
        u.university_id LIKE ? OR 
        r.tracking_code LIKE ?
      )`;
      const searchTerm = `%${filters.search}%`;
      params.push(searchTerm, searchTerm, searchTerm, searchTerm);
    }

    if (filters?.status && filters.status !== 'ALL REQUESTS') {
      if (filters.status === 'PROCESSING') {
        sql += ` AND r.status = 'Processing'`;
      } else if (filters.status === 'READY FOR RELEASING') {
        sql += ` AND r.status = 'Ready for Pickup'`;
      } else if (filters.status === 'NEEDS REVIEW') {
        sql += ` AND r.status = 'Pending Review'`;
      }
    }

    if (filters?.deliveryMode && filters.deliveryMode !== 'All Delivery Modes') {
      sql += ` AND r.fulfillment_method = ?`;
      params.push(filters.deliveryMode.toLowerCase());
    }

    sql += ` GROUP BY r.id ORDER BY r.created_at DESC`;

    const requests = await query<any>(sql, params);
    return requests;
  } catch (error) {
    console.error('Error fetching filtered requests:', error);
    throw new Error('Failed to fetch filtered requests');
  }
});

*/

// Placeholder - uncomment the code above when database is ready
export type RequestStatus = 'Pending Review' | 'Processing' | 'Ready for Pickup' | 'Completed' | 'Declined';

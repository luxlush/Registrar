// Database connection configuration
// Temporarily commented out until mysql2 is installed and database is configured
// Uncomment when ready to use database mode

/*
import mysql from 'mysql2/promise';

// Database connection pool
let pool: mysql.Pool | null = null;

export function getDbConnection() {
  if (!pool) {
    pool = mysql.createPool({
      host: process.env.DB_HOST || 'localhost',
      port: Number(process.env.DB_PORT) || 3306,
      user: process.env.DB_USER || 'root',
      password: process.env.DB_PASSWORD || '',
      database: process.env.DB_NAME || 'usep_registrar',
      waitForConnections: true,
      connectionLimit: 10,
      queueLimit: 0,
      timezone: '+08:00',
    });
  }
  return pool;
}

export async function query<T = any>(sql: string, params?: any[]): Promise<T[]> {
  const connection = getDbConnection();
  const [rows] = await connection.execute(sql, params);
  return rows as T[];
}

export async function queryOne<T = any>(sql: string, params?: any[]): Promise<T | null> {
  const rows = await query<T>(sql, params);
  return rows[0] || null;
}
*/

// Placeholder exports for now
export function getDbConnection() {
  throw new Error('Database not configured. Install mysql2 and configure .env file');
}

export async function query<T = any>(sql: string, params?: any[]): Promise<T[]> {
  throw new Error('Database not configured. Install mysql2 and configure .env file');
}

export async function queryOne<T = any>(sql: string, params?: any[]): Promise<T | null> {
  throw new Error('Database not configured. Install mysql2 and configure .env file');
}

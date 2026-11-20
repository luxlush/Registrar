# Database Setup Guide

This guide explains how to connect your USeP e-Registrar application to your MySQL database.

## Prerequisites

1. MySQL server running (local or remote)
2. Database created using `database_schema.sql`
3. Node.js and npm installed

## Setup Steps

### 1. Install Dependencies

Run the following command to install the mysql2 package:

```bash
npm install mysql2
```

Or if you're using bun:

```bash
bun install
```

### 2. Configure Environment Variables

1. Copy the `.env.example` file to `.env`:
   ```bash
   copy .env.example .env
   ```

2. Edit `.env` and update with your database credentials:
   ```env
   DB_HOST=localhost
   DB_PORT=3306
   DB_USER=root
   DB_PASSWORD=your_password_here
   DB_NAME=usep_registrar
   
   APP_MODE=demo  # Change to 'database' when ready to use real database
   ```

### 3. Import Database Schema

If you haven't already created the database, run:

```bash
mysql -u root -p < database_schema.sql
```

Or use phpMyAdmin/MySQL Workbench to import the `database_schema.sql` file.

### 4. Enable Database Mode

There are two ways to enable database mode:

#### Option A: Environment Variable (Recommended)
Set `APP_MODE=database` in your `.env` file and restart the server.

#### Option B: Runtime Toggle
Open browser console on the application and run:
```javascript
localStorage.setItem('usep-use-database', 'true');
window.location.reload();
```

## Current Implementation

### Demo Mode (Default)
- Uses localStorage for data persistence
- Comes with seed data for testing
- No database connection required
- Good for development and demonstrations

### Database Mode
- Connects to MySQL database
- Shows real-time data from your database
- Requires proper database setup
- Dashboard stats are calculated from actual records

## API Endpoints Created

The following API structure has been set up:

1. **GET /api/requests** - Fetch all document requests with student details
2. **GET /api/stats/dashboard** - Get dashboard statistics
3. **GET /api/stats/queue** - Get document queue statistics
4. **POST /api/requests/update-status** - Update request status

## Dashboard Metrics

The following metrics are now pulled from the database:

### Admin Dashboard
- **Total Queue**: Count of all active requests
- **Pending Review**: Requests with 'Pending Review' status
- **In Process**: Requests with 'Processing' status
- **Completed This Week**: Requests completed in last 7 days
- **Document Checks**: Count by document categories
- **SIS Entries**: Calculated difference

### Document Queue Page
- **Active Document Queue**: Pending + Processing + Ready for Pickup
- **Prioritized Intake**: Recent pending requests (last 24 hours)
- **Ready for Pickup**: Requests ready for pickup
- **Batch Slip**: Pickup requests count
- **Under Evaluation**: Processing requests count
- **Pending Validation**: Pending review count
- **SLA Metrics**: Based on request age

## Database Schema Alignment

The API queries align with your existing database schema:

- **requests** table: Main request tracking
- **request_items** table: Individual document items per request
- **document_types** table: Available document types
- **users** table: Student and admin information

## Troubleshooting

### Connection Issues
- Verify MySQL server is running
- Check credentials in `.env` file
- Ensure database exists and schema is imported
- Check firewall settings if using remote database

### Data Not Showing
- Verify APP_MODE or localStorage setting
- Check browser console for errors
- Ensure database has data (check with MySQL client)
- Verify user has proper database permissions

### Fallback Behavior
If database connection fails, the application automatically falls back to localStorage with a console warning.

## Testing

1. **Verify Database Connection**:
   - Enable database mode
   - Check browser console for connection errors
   - Dashboard should show "0" if database is empty

2. **Add Test Data**:
   Use the seed data from `database_schema.sql` or add requests through the student portal

3. **Verify Real-Time Updates**:
   - Submit a request as student
   - Check if it appears in admin dashboard
   - Update status in admin panel
   - Verify it updates in student tracker

## Next Steps

1. Set up your database and import the schema
2. Configure environment variables
3. Install mysql2 dependency
4. Enable database mode
5. Test the connection and data flow

For production deployment, ensure:
- Strong database passwords
- Proper user permissions
- SSL connection to database
- Environment variables secured
- Regular database backups

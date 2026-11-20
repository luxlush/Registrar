# Quick Setup Instructions

## Step 1: Install Dependencies

Run one of these commands in your terminal:

```bash
npm install
```

Or if you prefer bun:

```bash
bun install
```

This will install the newly added `mysql2` package along with other dependencies.

## Step 2: Configure Database (Optional for now)

1. Copy the environment template:
   ```bash
   copy .env.example .env
   ```

2. Edit `.env` with your database credentials:
   ```env
   DB_HOST=localhost
   DB_PORT=3306
   DB_USER=root
   DB_PASSWORD=your_password
   DB_NAME=usep_registrar
   APP_MODE=demo
   ```

## Step 3: Run the Application

```bash
npm run dev
```

The application will run in **demo mode** by default (using localStorage).

## What's New

### ✅ Admin Dashboard Now Shows Real Data
- Total Queue count from database
- Pending Review count
- In Process count  
- Completed This Week count
- Document Checks and SIS Entries breakdown

### ✅ Document Queue Page Updated
- Active Document Queue count
- Prioritized Intake count
- Ready for Pickup count
- Under Evaluation count
- Pending Validation count
- All stats pull from database when enabled

### ✅ Payment Checkout Modal Added
- Professional checkout UI
- QR code placeholder
- Works without actual scanning (demo mode)
- "Confirm Payment" button proceeds without payment gateway
- Ready for future GCash/Maya/PayMongo integration

### ✅ Flexible Data Source
- **Demo Mode**: Uses localStorage (no database needed)
- **Database Mode**: Uses MySQL (when configured)
- Automatic fallback if database connection fails

## Testing the Changes

### Test Demo Mode (No Database Required)
1. Run `npm run dev`
2. Open student portal at http://localhost:3000/student
3. Select documents and submit request
4. Open admin dashboard at http://localhost:3000/admin-dashboard
5. Verify counts update correctly
6. Test payment checkout modal:
   - Select documents
   - Click "Pay & Submit Request"
   - Modal opens with QR placeholder
   - Click "Confirm Payment"
   - Request submitted successfully

### Test Database Mode (Optional)
1. Import `database_schema.sql` into MySQL
2. Configure `.env` file with database credentials
3. Change `APP_MODE=database` in `.env`
4. Restart server
5. Dashboard will show data from MySQL database

## Files to Review

- **CHANGES_SUMMARY.md** - Complete list of all changes
- **DATABASE_SETUP.md** - Detailed database setup guide
- **.env.example** - Environment variables template

## Status Values Updated

The following status values have been standardized to match your database:

| Old Value | New Value |
|-----------|-----------|
| "Pending" | "Pending Review" |
| "Ready for Pickup/Delivery" | "Ready for Pickup" |

## Quick Command Reference

```bash
# Install dependencies
npm install

# Run development server
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview

# Lint code
npm run lint

# Format code
npm run format
```

## Troubleshooting

### Dashboard shows 0 for all counts
- This is normal if using demo mode and no requests have been submitted
- Submit some requests via student portal to see counts

### Payment modal doesn't open
- Check browser console for errors
- Ensure you selected at least one document
- Clear browser cache and reload

### Database connection errors
- Verify MySQL is running
- Check credentials in `.env` file
- Ensure database exists
- See DATABASE_SETUP.md for detailed troubleshooting

## Next Steps

1. ✅ Install dependencies: `npm install`
2. ✅ Test demo mode: `npm run dev`
3. ✅ Test payment checkout flow
4. ⏳ Set up MySQL database (optional, for production)
5. ⏳ Enable database mode when ready

## Need Help?

- Check **DATABASE_SETUP.md** for database configuration
- Review **CHANGES_SUMMARY.md** for what changed
- Check browser console for errors
- Verify all files are present in the project

---

**Note**: The application works perfectly in demo mode without database setup. Database integration is optional and can be enabled when you're ready to go to production.

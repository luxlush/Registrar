# How to Run USeP e-Registrar

## Quick Start (Easiest Way)

1. **Double-click this file:**
   ```
   rebuild-and-start.bat
   ```

2. **Wait for build to complete** (takes 30-60 seconds)

3. **Open your browser** to:
   ```
   http://localhost:8000
   ```

That's it! ✅

---

## What's New - Fully Responsive! 📱

The website now works perfectly on:
- 📱 **Mobile phones** (320px - 767px)
- 📱 **Tablets** (768px - 1024px)  
- 💻 **Desktops** (1025px+)

### Mobile Features:
- ✅ Hamburger menu for navigation
- ✅ Scrollable tables
- ✅ Touch-friendly buttons
- ✅ Stacked layouts
- ✅ Optimized forms (no zoom on iOS)
- ✅ White logo in footer (visible now!)

---

## Pages to Test

| Page | URL | Test On Mobile |
|------|-----|----------------|
| **Home** | http://localhost:8000/ | ✅ Hero, cards, footer |
| **Login** | http://localhost:8000/login | ✅ Form inputs |
| **Student Portal** | http://localhost:8000/student | ✅ Document selection, payment modal |
| **Admin Dashboard** | http://localhost:8000/admin-dashboard | ✅ Sidebar menu, charts, tables |
| **Admin Queue** | http://localhost:8000/admin | ✅ Tables, filters |

---

## Test on Your Phone

1. **Find your computer's IP address:**
   - Windows: Open CMD and type `ipconfig`
   - Look for "IPv4 Address" (e.g., 192.168.1.100)

2. **On your phone's browser, go to:**
   ```
   http://YOUR_IP_ADDRESS:8000
   ```
   Example: `http://192.168.1.100:8000`

3. **Make sure your phone and computer are on the same WiFi**

---

## Manual Commands

If you prefer command line:

### Build only:
```bash
npm run build
```

### Start server only (after building):
```bash
php -S localhost:8000 -t .output\public
```

### Build + Start:
```bash
npm run build && php -S localhost:8000 -t .output\public
```

---

## Troubleshooting

### Build fails?
1. Run: `npm install`
2. Try again: `npm run build`

### Can't access on phone?
1. Check firewall settings
2. Ensure same WiFi network
3. Try turning off VPN

### Logo still not white?
1. Clear browser cache: `Ctrl + Shift + R`
2. Or use incognito mode

### Mobile menu not working?
1. Make sure you rebuilt the project
2. Hard refresh: `Ctrl + F5`

---

## Browser Support

- ✅ Chrome/Edge (recommended)
- ✅ Firefox
- ✅ Safari (iOS 12+)
- ✅ Chrome Mobile
- ✅ Samsung Internet

---

## Need Help?

Check these files:
- `RESPONSIVE_CHANGES.md` - What changed
- `DATABASE_SETUP.md` - Database configuration
- `CHANGES_SUMMARY.md` - All features

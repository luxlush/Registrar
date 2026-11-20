# How to Start the Server

## Option 1: Using PHP Built-in Server (What you were using)

After building, run:

```bash
php -S localhost:8000 -t .output/public
```

Then open: http://localhost:8000

## Option 2: Using Node/npm (Recommended for this project)

This is a TanStack Start project, so the recommended way is:

```bash
npm run dev
```

Or for production build:

```bash
npm run build
npm run preview
```

## Current Status

✅ Build completed successfully!
✅ Files are in `.output/public` folder
✅ All async issues fixed
✅ Database code commented out (demo mode active)

## Your Workflow

1. **Make changes** to the code
2. **Build** the project: `npm run build`
3. **Serve** with PHP: `php -S localhost:8000 -t .output/public`
4. **Test** at http://localhost:8000

## Important Notes

- The `.output/public` folder contains static assets
- The `.output/server` folder contains server-side code
- For TanStack Start, you should really use `npm run preview` instead of PHP server
- PHP server won't handle SSR (Server-Side Rendering) properly

## Recommended Command

Instead of PHP, try:

```bash
npm run preview
```

This will serve the built project properly with all features working.

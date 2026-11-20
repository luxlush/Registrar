# USeP Virtual Registrar multi-role prototype

## Goal
Expand the supplied maroon-and-gold landing page into a complete, clickable registrar prototype covering documents, record corrections, and academic transactions.

## Pages and navigation
- Recreate the current landing page at `/` with the same visual hierarchy, updated badge, broader registrar headline, supplied description, and an **Enter Portal** action.
- Add `/login` with clear Student Login and Admin Portal tabs, prefilled demo details, and one-click simulated sign-in.
- Add `/student` as the student workspace and `/admin` as the administrative workspace, with sign-out and quick role switching for testing.
- Keep every page usable on desktop and mobile and preserve the compact institutional maroon, gold, ivory, and white styling shown in the reference.

## Student workspace
- Provide a categorized catalog containing all seven requested document types, selectable items, expandable descriptions, and a request form.
- Add a Student Records Correction form for name, birthdate, curriculum, and academic-record concerns.
- Show active requests in a tracker with visible Pending, Processing, Ready, Declined, and Completed states.
- Simulate online payment selection and request submission without external services.

## Admin workspace
- Add a Document Requests Queue combining document and correction requests.
- Make Approve, Decline, and Mark as Completed update each row immediately.
- Add an Academic Transactions ledger for enrollment adjustments, program shifts/transfers, credit validation/deficiencies, LOA/readmission, and graduation/record verification.
- Include useful search and type/course filters in both administrative areas.

## Shared simulation
- Store seeded and newly submitted records in browser storage so student submissions appear in the admin queue and administrative status changes appear in the student tracker.
- Use stable mock IDs, timestamps, student details, and resettable sample data.
- Keep authentication explicitly simulated; no real accounts, payment processing, or server database will be added.

## Technical note
- This workspace is fixed to its existing TanStack/React application shell, so the prototype will use that required shell rather than a standalone hand-authored `dist` site. The finished output still builds to static browser assets, uses browser storage for all simulation, and requires no custom backend server.

## Validation
- Verify landing-to-login navigation, both demo sign-ins, student submission-to-admin synchronization, admin status updates, student tracker reflection, filtering, and responsive layouts.
- Add unique page titles and social descriptions for every page.

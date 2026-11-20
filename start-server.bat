@echo off
echo ========================================
echo USeP e-Registrar Server Launcher
echo ========================================
echo.
echo Choose how to start the server:
echo.
echo 1. npm run preview (Recommended - Full features)
echo 2. PHP server (Simple - Static only)
echo.
choice /C 12 /N /M "Enter your choice (1 or 2): "

if errorlevel 2 goto php
if errorlevel 1 goto npm

:npm
echo.
echo Starting with npm preview...
echo.
call npm run preview
goto end

:php
echo.
echo Starting PHP server...
echo Server will run at: http://localhost:3000
echo Press Ctrl+C to stop the server
echo.
php -S localhost:3000 -t dist dist/router.php
goto end

:end
pause

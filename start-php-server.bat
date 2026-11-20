@echo off
cd /d "%~dp0"
echo ========================================
echo USeP e-Registrar - Starting PHP Server
echo ========================================
echo.
echo Server starting at: http://localhost:3000
echo.
echo Press Ctrl+C to stop the server
echo ========================================
echo.
php -S localhost:3000 -t dist dist/router.php
pause

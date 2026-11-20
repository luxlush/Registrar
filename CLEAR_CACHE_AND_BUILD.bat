@echo off
cls
echo.
echo  ==========================================
echo    FULL REBUILD - Clear Cache + Build
echo  ==========================================
echo.
echo  Step 1: Clearing old build...
rd /s /q .output 2>nul
rd /s /q dist 2>nul
echo  Done!
echo.
echo  Step 2: Building project...
call npm run build
echo.
if %ERRORLEVEL% EQU 0 (
    echo  ==========================================
    echo    Build Complete! Starting Server...
    echo  ==========================================
    echo.
    echo  IMPORTANT: Hard refresh your browser!
    echo  Windows: Ctrl + Shift + R or Ctrl + F5
    echo.
    echo  Server: http://localhost:8000
    echo  ==========================================
    echo.
    php -S localhost:8000 -t .output\public
) else (
    echo  Build failed! Check errors above.
    pause
)

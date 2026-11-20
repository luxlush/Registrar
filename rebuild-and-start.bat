@echo off
cls
echo.
echo  ==========================================
echo    USeP e-Registrar - Build System
echo  ==========================================
echo.
echo  Building responsive website...
echo.
call npm run build

if %ERRORLEVEL% EQU 0 (
    echo.
    echo  ==========================================
    echo    Build Successful!
    echo  ==========================================
    echo.
    echo  Starting PHP Server...
    echo.
    echo  Server URL: http://localhost:8000
    echo  Press Ctrl+C to stop
    echo.
    echo  ==========================================
    echo.
    php -S localhost:8000 -t .output\public
) else (
    echo.
    echo  ==========================================
    echo    Build Failed!
    echo  ==========================================
    echo.
    echo  Please check the errors above
    pause
)


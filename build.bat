@echo off
setlocal
cd /d "%~dp0"

python -m PyInstaller --noconfirm --clean --onefile --windowed --name PapaEye --distpath "dist\release" --workpath "build\release" --add-data "originlens\pretrained_models.json;originlens" main.py
if errorlevel 1 (
    echo Build failed.
    exit /b 1
)

echo.
echo EXE created at: dist\release\PapaEye.exe
endlocal

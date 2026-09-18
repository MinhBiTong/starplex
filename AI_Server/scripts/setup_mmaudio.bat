@echo off
REM Set up an isolated venv for MMAudio (video-to-audio).
REM
REM MMAudio's dependency stack (torchmcubes compiled from source, its own
REM torch/torchaudio pins) is not compatible with the main AI_Server venv,
REM so it lives in its own venv and is invoked as a subprocess.
REM
REM Requirements: Python 3.10/3.11 on PATH, git, MSVC C++ build tools
REM (for torchmcubes), NVIDIA driver.
REM
REM After this finishes, point MMAUDIO_PYTHON in AI_Server/.env at:
REM   %CD%\mmaudio_venv\Scripts\python.exe

setlocal
cd /d %~dp0..
echo Creating venv at %CD%\mmaudio_venv ...
python -m venv mmaudio_venv || goto :error
call mmaudio_venv\Scripts\activate.bat

echo Installing MMAudio (this compiles torchmcubes; can take a while) ...
python -m pip install --upgrade pip || goto :error
REM cu130 is the newest CUDA wheel index and the only one carrying Python
REM 3.14 wheels (the cu121 index stops at older Pythons).
pip install torch torchaudio --index-url https://download.pytorch.org/whl/cu130 || goto :error
pip install git+https://github.com/hkchengrex/MMAudio.git || goto :error

echo.
echo Done. Add this line to AI_Server/.env:
echo   MMAUDIO_PYTHON=%CD%\mmaudio_venv\Scripts\python.exe
goto :eof

:error
echo.
echo Setup FAILED. See the output above. Common causes:
echo  - missing MSVC C++ build tools (needed by torchmcubes)
echo  - Python version outside 3.10-3.11
exit /b 1

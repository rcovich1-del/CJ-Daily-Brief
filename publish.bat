@echo off
REM ============================================================
REM  The Daily Brief - DAILY PUBLISH
REM  Commits the current index.html and pushes it to GitHub
REM  Pages. Run this after each brief is generated.
REM
REM  To make it fully unattended, add this file to Windows
REM  Task Scheduler at 7:05 PM, Sunday-Thursday.
REM ============================================================

cd /d C:\DailyBrief

for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set DT=%%I
set STAMP=%DT:~0,4%-%DT:~4,2%-%DT:~6,2%

if not exist .nojekyll type nul > .nojekyll

git add index.html .nojekyll
git diff --cached --quiet && (
  echo No changes to publish for %STAMP%.
  exit /b 0
)

git commit -m "The Daily Brief - %STAMP%"
git push origin main

if errorlevel 1 (
  echo PUSH FAILED for %STAMP%. See the git error above.
  exit /b 1
)

echo Published %STAMP% to https://rcovich1-del.github.io/CJ-Daily-Brief/
exit /b 0

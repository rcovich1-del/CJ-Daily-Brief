@echo off
REM ============================================================
REM  The Daily Brief - ONE-TIME SETUP
REM  Wires C:\DailyBrief up to the GitHub repo without
REM  destroying the index.html that was just generated.
REM  Run this once by double-clicking it.
REM ============================================================

cd /d C:\DailyBrief

echo Removing any partial .git directory...
rmdir /s /q .git 2>nul

echo Initialising repository...
git init -b main
git remote add origin https://github.com/rcovich1-del/CJ-Daily-Brief.git

echo Fetching remote history...
git fetch origin main
if errorlevel 1 goto fail

REM Point HEAD at the remote tip WITHOUT touching the working tree,
REM so the freshly generated index.html is preserved.
git reset --soft origin/main

echo Ensuring .nojekyll exists...
if not exist .nojekyll type nul > .nojekyll

echo Committing and pushing...
git add -A
git commit -m "The Daily Brief - initial publish"
git push origin main
if errorlevel 1 goto fail

echo.
echo ============================================================
echo  SUCCESS. Check the live site in about a minute:
echo  https://rcovich1-del.github.io/CJ-Daily-Brief/
echo.
echo  If the page 404s, enable GitHub Pages once:
echo  repo - Settings - Pages - Deploy from branch - main / root
echo ============================================================
pause
exit /b 0

:fail
echo.
echo ============================================================
echo  SOMETHING FAILED. Read the git error above.
echo  Most common cause: git has no saved GitHub credentials.
echo  Fix by running:  git config --global credential.helper manager
echo  then re-run this file and sign in when prompted.
echo ============================================================
pause
exit /b 1

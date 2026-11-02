@echo off
setlocal
cd /d "%~dp0"

echo ================================================
echo SteamAdditions - DeepSpace GitHub sync
echo ================================================

where git >nul 2>&1
if errorlevel 1 (
  echo ERROR: Git was not found in PATH.
  exit /b 1
)

git switch gt8-port
if errorlevel 1 exit /b 1

git add -A
if errorlevel 1 exit /b 1

rem These local JARs are required by build.gradle and are intentionally ignored by .gitignore.
if exist "libs\*.jar" git add -f libs\*.jar
if errorlevel 1 exit /b 1

git diff --cached --quiet
if errorlevel 1 (
  git commit -m "Sync SteamAdditions Sky of Grind DeepSpace changes"
  if errorlevel 1 exit /b 1
) else (
  echo No local changes to commit.
)

git push -u deepspace gt8-port
if errorlevel 1 (
  echo ERROR: Push failed. Local commits are preserved and can be pushed again.
  exit /b 1
)

echo.
echo Successfully synced to https://github.com/evilcatshb/steamadditions-8.0.0-deepspace-fork
exit /b 0

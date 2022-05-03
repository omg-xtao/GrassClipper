@echo off

set BRANCH=%1

echo Checking java version...

:: https://stackoverflow.com/questions/5675459/how-to-get-java-version-from-batch-script
for /f "tokens=3" %%g in ('java -version 2^>^&1 ^| findstr /i "version"') do (
    @echo Output: %%g
    set JAVAVER=%%g
)
set JAVAVER=%JAVAVER:"=%

for /f "delims=. tokens=1-3" %%v in ("%JAVAVER%") do (
    set MAJOR=%%v
    set MINOR=%%w
    set BUILD=%%x
)

if %BRANCH% EQU stable (
  :: Ensure java 8
  if %MAJOR% EQU 1 (
    if %MINOR% LSS 8 (
      echo Java version is less than 8, please download Java 8
      exit /b
    )
  )
)

if %BRANCH% EQU development (
  :: Ensure java 17
  if %MAJOR% LSS 17 (
    echo Java version is less than 17, please download Java 17
    exit /b
  )
)

echo Java version is compatible
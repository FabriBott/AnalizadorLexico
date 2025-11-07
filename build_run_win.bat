@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
REM === Build & Run for Windows (UTF-8 enforced) ===
REM Usage: double-click or run: build_run_win.bat

cd /d "%~dp0"
chcp 65001 >nul

REM ---- Locate required JARs ----
set "JFLEX="
for %%F in ("lib\jflex*.jar") do set "JFLEX=%%~fF"
set "CUP="
for %%F in ("lib\java-cup*.jar") do set "CUP=%%~fF"

if not defined JFLEX (
  echo [ERROR] No se encontro JFlex en lib\jflex*.jar
  exit /b 1
)
if not defined CUP (
  echo [ERROR] No se encontro Java CUP en lib\java-cup*.jar
  exit /b 1
)

echo [INFO] Usando JFlex: %JFLEX%
echo [INFO] Usando CUP  : %CUP%

REM ---- Generate Lexer ----
echo [STEP] Generando Lexer desde src\codigo\Lexer.flex ...
java -Dfile.encoding=UTF-8 -jar "%JFLEX%" src\codigo\Lexer.flex || exit /b 1

REM ---- Generate Parser ----
echo [STEP] Generando Parser desde src\codigo\parser.cup ...
java -Dfile.encoding=UTF-8 -jar "%CUP%" -parser Parser -symbols sym -expect 1 -destdir src\codigo src\codigo\parser.cup || exit /b 1


REM ---- Compile (UTF-8) ----
echo [STEP] Compilando *.java con UTF-8 ...
javac -encoding UTF-8 -cp ".;src;%CUP%" src\codigo\*.java || exit /b 1

REM ---- Run GUI (force UTF-8) ----
echo [STEP] Ejecutando GUI con UTF-8 ...
java -Dfile.encoding=UTF-8 -cp ".;src;%CUP%" codigo.FrmPrincipal
endlocal

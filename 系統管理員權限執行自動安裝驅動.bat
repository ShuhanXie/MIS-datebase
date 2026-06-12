@echo off
chcp 65001 >nul
title 自動還原驅動
color 0A
setlocal

set "DRIVERPATH=%~dp0"

echo ================================
echo        自動還原 Windows 驅動
echo ================================
echo.
echo 驅動來源資料夾：
echo %DRIVERPATH%
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [錯誤] 請用「系統管理員身分」執行這個 BAT！
    echo.
    pause
    exit /b
)

dir /s /b "%DRIVERPATH%*.inf" >nul 2>&1
if %errorlevel% neq 0 (
    echo [錯誤] 目前資料夾及子資料夾內找不到任何 INF 驅動檔
    echo 請確認 BAT 是否和驅動包放在同一層
    echo.
    pause
    exit /b
)

echo [1/2] 正在搜尋並安裝驅動...
pnputil /add-driver "%DRIVERPATH%*.inf" /subdirs /install

echo.
echo [2/2] 驅動還原程序執行完成
echo.
echo 建議檢查：
echo - 裝置管理員是否還有驚嘆號
echo - 網卡、音效、顯示是否正常
echo.

pause
endlocal
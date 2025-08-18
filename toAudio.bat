@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

:menu
cls
echo.
echo ========================================
echo    АУДИО КОНВЕРТЕР FFMPEG
echo ========================================
echo 1. Конвертировать в WMA
echo 2. Конвертировать в WAV (IMA ADPCM)
echo 3. Выход
echo ========================================
set /p choice="Выберите действие (1-3): "

if "%choice%"=="1" (
    set format=wma
    set source_dir=TempAudio\toWMA\Enter
    set dest_dir=TempAudio\toWMA\Exit
    call :bitrate_menu
    goto :convert
) else if "%choice%"=="2" (
    set format=wav
    set source_dir=TempAudio\toWAV\Enter
    set dest_dir=TempAudio\toWAV\Exit
    call :wav_settings
    goto :convert
) else if "%choice%"=="3" (
    exit /b
) else (
    echo Неверный выбор!
    timeout /t 2 >nul
    goto :menu
)

:convert
if not exist "%source_dir%" (
    mkdir "%source_dir%"
    echo Создана папка: %source_dir%
)

if not exist "%dest_dir%" (
    mkdir "%dest_dir%"
    echo Создана папка: %dest_dir%
)

set "ffmpeg_path=Tools\ffmpeg.exe"
if not exist "%ffmpeg_path%" (
    echo Ошибка: ffmpeg.exe не найден в Tools!
    pause
    exit /b 1
)

echo.
echo ========================================
echo Исходная папка: %source_dir%
echo Выходная папка: %dest_dir%
echo Формат: .%format%
if "%format%"=="wma" echo Битрейт: %bitrate% kbps
if "%format%"=="wav" (
    echo Частота: %sample_rate% Hz
    echo Каналы: %channels%
    echo Кодировка: IMA ADPCM
)
echo ========================================
echo Начинаю конвертацию...
echo.

for /R "%source_dir%" %%F in (*) do (
    set "input=%%F"
    set "output=%%~pnxF"
    set "output=!output:%source_dir%=%dest_dir%!"
    set "output=!output:~0,-4!.!format!"
    
    echo Конвертация: "%%F"
    
    if "!format!"=="wma" (
        "%ffmpeg_path%" -y -i "%%F" -c:a wmav2 -b:a !bitrate!k "!output!"
    ) else if "!format!"=="wav" (
        "%ffmpeg_path%" -y -i "%%F" -c:a adpcm_ima_wav -ar %sample_rate% -ac %channels% "!output!"
    )
    
    if !errorlevel! neq 0 (
        echo [ОШИБКА] Проблема с файлом: "%%F"
    )
)

echo.
echo ========================================
echo Конвертация завершена!
echo Проверьте результаты в папке: %dest_dir%
echo ========================================
pause
goto :menu

:bitrate_menu
cls
echo.
echo ========================================
echo    ВЫБОР БИТРЕЙТА ДЛЯ WMA
echo ========================================
echo 1. 64 kbps (низкое качество)
echo 2. 128 kbps (стандартное качество)
echo 3. 192 kbps (хорошее качество)
echo 4. 256 kbps (высокое качество)
echo 5. Другой битрейт
echo ========================================
set /p bitrate_choice="Выберите битрейт (1-5): "

if "%bitrate_choice%"=="1" set bitrate=64
if "%bitrate_choice%"=="2" set bitrate=128
if "%bitrate_choice%"=="3" set bitrate=192
if "%bitrate_choice%"=="4" set bitrate=256
if "%bitrate_choice%"=="5" (
    set /p custom_bitrate="Введите битрейт (кбит/сек): "
    set bitrate=!custom_bitrate!
)

if not defined bitrate (
    echo Неверный выбор, используется 128 kbps
    set bitrate=128
)
exit /b

:wav_settings
cls
echo.
echo ========================================
echo    НАСТРОЙКИ WAV (IMA ADPCM)
echo ========================================
echo 1. Частота дискретизации:
echo    1. 22050 Hz
echo    2. 44100 Hz
echo 2. Количество каналов:
echo    1. Mono (1 канал)
echo    2. Stereo (2 канала)
echo ========================================

:select_sample_rate
set /p sample_rate_choice="Выберите частоту (1-2): "
if "%sample_rate_choice%"=="1" set sample_rate=22050
if "%sample_rate_choice%"=="2" set sample_rate=44100
if not defined sample_rate (
    echo Неверный выбор!
    goto :select_sample_rate
)

:select_channels
set /p channels_choice="Выберите каналы (1-2): "
if "%channels_choice%"=="1" set channels=1
if "%channels_choice%"=="2" set channels=2
if not defined channels (
    echo Неверный выбор!
    goto :select_channels
)
exit /b
@echo off
SET STAGING=staging-winforms

IF EXIST %STAGING%\ (
RMDIR /S /Q .\%STAGING%
) ELSE IF EXIST %STAGING% (
DEL /s %STAGING%
)

MD %STAGING%

SET TOOLS=.\tools
SET STAGINGZIP=ReactChat-winforms.7z
SET OUTPUTNAME=ReactChat-winforms.exe
SET RELEASE=..\..\ReactChat.AppWinForms\bin\x86\Release
COPY %RELEASE%\ReactChat.AppWinForms.exe .\%STAGING%
COPY %RELEASE%\ReactChat.AppWinForms.exe.config .\%STAGING%
COPY %RELEASE%\CefSharp.BrowserSubprocess.exe .\%STAGING%
ROBOCOPY "%RELEASE%" ".\%STAGING%" *.dll *.pak *.dat /E

IF NOT EXIST apps (
MD apps
)

IF EXIST %STAGINGZIP% (
DEL %STAGINGZIP%
)

IF EXIST %OUTPUTNAME% (
DEL %OUTPUTNAME%
)

cd tools && 7za a ..\%STAGINGZIP% ..\%STAGING%\* && cd..
COPY /b .\tools\7zsd_All.sfx + config-winforms.txt + %STAGINGZIP% .\apps\%OUTPUTNAME%

IF EXIST %STAGINGZIP% (
DEL %STAGINGZIP%
)

echo ------------- && echo  deployed to: .\wwwroot_build\apps\%OUTPUTNAME% && echo -------------
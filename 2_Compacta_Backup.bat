for /d %%F in ("%1\*") do (
    "%ProgramFiles%\7-Zip\7z.exe" a -t7z -m0=lzma2 -mx=9 -p123456789 -mhe=on "%1\%%~nxF.7z" "%%F" "%1\*.log"
    rd /s /q "%%F"
    del "%1\*.log"
)

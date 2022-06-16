
COPY-ITEM "C:\vagrant\shell\software\eclipse.zip" -Destination "$HOME\"

7z x "C:\Users\student\eclipse.zip" -oc:" -y

$SourceFilePath = 'C:\eclipse\eclipse.exe'
$ShortcutPath = 'C:\Users\student\Desktop\Eclipse.lnk'
$WScriptObj = New-Object -ComObject('WScript.Shell')
$shortcut = $WscriptObj.CreateShortcut($ShortcutPath)
$shortcut.TargetPath = $SourceFilePath
$shortcut.Save()

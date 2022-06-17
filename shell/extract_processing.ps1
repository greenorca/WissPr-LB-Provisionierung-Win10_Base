$filename = "processing-3.5.4-windows64.zip"

COPY-ITEM ("C:\vagrant\shell\software\"+$filename) -Destination "$HOME\"

7z x ("C:\Users\student\"+$filename) -oc: -y

# Create a Desktop shortcut
$SourceFilePath = 'C:\processing-3.5.4\processing.exe'
$ShortcutPath = 'C:\Users\student\Desktop\Processing.lnk'
$WScriptObj = New-Object -ComObject('WScript.Shell')
$shortcut = $WscriptObj.CreateShortcut($ShortcutPath)
$shortcut.TargetPath = $SourceFilePath
$shortcut.Save()

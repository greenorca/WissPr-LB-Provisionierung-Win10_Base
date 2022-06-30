# Vorgehen WissPr-Win10-VM-Image Erstellung

## Provisionierung der Softwarepakete

1. chocolatey Software ergänzen/updaten im `software.txt` (Achtung: package-Namen müssen im Choco-Repo geprüft werden, z.B. mit `choco find app-name`)
2. `test_choco_packages.ps1` ausführen: damit wird prüft, ob alle gelisteten Packages vorhanden sind
3. alle Softwares deployen `vagrant up`

Eclipse, Processing sowie Zeal mit Standard-Docsets werden unabhängig von Chocolatey deployed, siehe  extract_*.ps1 Skripte.

**TODO:** Damit ist das Virtualbox-Image fertig konfiguriert und kann über noch zu definierende Prozesse auf das WissPr-Masterimage transferiert werden.


## Neuerstellung des Basis-Betriebssystems
Die folgenden Schritte sind nur bei Änderung des Basisbetriebssystems nötig:

1. `vagrant init` im Projektverzeichnis ausführen (nur bei neuem Projekt)
1. Basis-OS erstellen in Virtualbox erstellen (Name beachten: Win10_Base)
  - MS Office installieren
  - aktuelle Win - Updates installieren
  - Virtualbox-Guest Additions installieren (wichtig für shared directories!)
  - aktivere WinRM:
      ```cmd
        winrm quickconfig -q
        winrm set winrm/config/winrs @{MaxMemoryPerShellMB="300"}
        winrm set winrm/config @{MaxTimeoutms="1800000"}
        winrm set winrm/config/service @{AllowUnencrypted="true"}
        winrm set winrm/config/service/auth @{Basic="true"}
        sc config WinRM start=auto
      ```
  - some tweaks
      ```
      Set-Item WSMan:localhost\client\trustedhosts -value * -Force
      Set-ExecutionPolicy -Force -ExecutionPolicy Unrestricted
      TODO: WinRM in Firewall freigeben (habe ich manuell gemacht)
      ```
  - Chocolatey installieren (wichtig für weitere Provisionierung)
    ```
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    ```    
  - Ballast entfernen:
    ```
    Get-AppXPackage -AllUsers | Remove-AppXPackage
    Disable-ComputerRestore c:
    powercfg -h off    
    ```
1. Image für Vagrant exportieren (dauert eine Weile): `vagrant package --base Win10_Base --output Win10x64.box`
1. Image im vagrant "registieren" (dauert auch ein bisschen): `vagrant box add Win10x64.box --name Win10x64`
      - gegebenenfalls muss die existierende Box vorher entfernt werden:
          - vagrant box remove Win10x64
          - del Win10x64.box



<!--
## What happens on provisioning

1. all items from software.txt are installed usin chocolatey
2. eclipse is extracted from local portable edition, desktop shortcut is created
3. processin is extracted from local portable edition, desktop shortcut is created
4. zeal docsets are extracted and installed  

## Lokale Chocolatey-Repos

https://www.ipswitch.com/blog/setting-up-an-internal-chocolatey-package-repository
-->

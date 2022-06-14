# Vorgehen WissPr-Win10-VM-Image Erstellung

1. ~vagrant init~ im Projektverzeichnis ausführen (nur bei neuem Projekt)
1. Basis-OS erstellen in Virtualbox erstellen (Name: Win10_Base, nur bei neuer Betriebssystem-Version nötig)
  - MS Office installieren
  - aktuelle Win - Updates installieren
  - Virtualbox-Guest Additions installieren (wichtig für shared directories!)
  - Chocolatey installieren (wichtig für weitere Provisionierung)
  - aktivere WinRM:
    ~~~cmd
      winrm quickconfig -q
      winrm set winrm/config/winrs @{MaxMemoryPerShellMB="300"}
      winrm set winrm/config @{MaxTimeoutms="1800000"}
      winrm set winrm/config/service @{AllowUnencrypted="true"}
      winrm set winrm/config/service/auth @{Basic="true"}
      sc config WinRM start=auto
    ~~~
  - some tweaks
      ~~~
      Set-Item WSMan:localhost\client\trustedhosts -value * -Force
      Set-ExecutionPolicy -Force -ExecutionPolicy Unrestricted
      TODO: WinRM in Firewall freigeben (habe ich manuell gemacht)
      ~~~
  - Ballast entfernen:
    ~~~
    Get-AppXPackage -AllUsers | Remove-AppXPackage
    Disable-ComputerRestore c:
    powercfg -h off    
    ~~~
2. nur nötige wenn Basis-OS geändert wurde:
  * Image für Vagrant exportieren (dauert eine Weile): ~vagrant package --base Win10_Base --output Win10x64.box~
  * Image im vagrant "registieren" (dauert auch ein bisschen): ~vagrant box add Win10x64.box --name Win10x64~
3. chocolatey Software ergänzen/updaten im Vagrantfile
4. deploy ~vagrant up~

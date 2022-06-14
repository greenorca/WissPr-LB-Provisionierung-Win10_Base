# Vorgehen WissPr-Win10-VM-Image Erstellung

1. Basis-OS erstellen in Virtualbox erstellen (Name: Win10_Base, ist nur bei neuer Betriebssystem-Version nötig)
  - mit MS Office
  - aktuelle Win - Updates
  - und Chocolatey
2. nur nötige wenn 1 geändert wurde: Image für Vagrant exportieren (dauert eine Weile): vagrant package --base Win10_Base

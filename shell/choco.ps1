Set-ExecutionPolicy Bypass -Scope Process -Force
chocolatey feature enable -n=allowGlobalConfirmation

cd .

foreach($line in Get-Content "c:\vagrant\software.txt") {
    choco install $line -y --force
}

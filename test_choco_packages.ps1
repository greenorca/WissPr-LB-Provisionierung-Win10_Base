# Skript testet, ob die choco-Packages auf der software.txt vorhanden sind

$misses = 0 # should remain 0!
$errors = 0
foreach($line in Get-Content D:\WissPr-Provisionierung\Win10_Base\software.txt){

  choco search --approved-only -e $line
  if ($LastExitCode -eq 1){
    $errors++
  } 
  if ($LastExitCode -eq 2){
    $misses++
  }
}

echo ""; echo "";
echo "Finished search packages"
echo "Nicht gefunden: $misses"
echo "Fehler $errors"

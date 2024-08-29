#Powershell script to concatenate files with common prefix in the same directory

# Current date | Format: YYYYMMDD
$Date = Get-Date -Format "yyyyMMdd"
# ALternative: use the first script argument as the date
if ($args[0] -ne $null) {
    $Date = $args[0]
    $Date
}

# Files
#TODO: get the prefixes automatically
$Errores = Get-ChildItem -Path . -Filter "Errores*.*"
$Empleados = Get-ChildItem -Path . -Filter "Empleados*.*"
$IMSS = Get-ChildItem -Path . -Filter "IMSS*.*"
$Bitacora = Get-ChildItem -Path . -Filter "Bitacora*.*"

# Concatenate the files
Get-Content $Errores | Set-Content -Path ("Errores" + $Date + "_CAT.txt")
Get-Content $Empleados | Set-Content -Path ("Empleados" + $Date + "_CAT.txt")
Get-Content $IMSS | Set-Content -Path ("IMSS" + $Date + "_CAT.txt")
Get-Content $Bitacora | Set-Content -Path ("Bitacora" + $Date + "_CAT.txt")

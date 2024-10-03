#==========================================================================
# AUTEUR: Richard Jean 
# DATE  : 5 février 2023
#
# La variable $info contient des informations sur les groupes
# qui sont dans l'unité d'organisation "GROUPES".
#
# Le contenu de la variable $info est trié en ordre alphabétique selon
# la propriété CanonicalName.
#==========================================================================
Clear-Host

$OU = "OU=GROUPES,OU=FORMATION,DC=FORMATION,DC=LOCAL"

$info = Get-ADGroup -Filter * `
                    -SearchBase $OU `
                    -Properties CanonicalName | Sort-Object CanonicalName

Write-Host ("-" * 100) -ForegroundColor Yellow
Write-Host ("CanonicalName") -ForegroundColor Yellow
Write-Host ("-------------") -ForegroundColor Yellow
$info.CanonicalName

Write-Host ("-" * 100) -ForegroundColor Yellow
Write-Host ("DistinguishedName") -ForegroundColor Yellow
Write-Host ("-----------------") -ForegroundColor Yellow
$info.DistinguishedName

Write-Host ("-" * 100) -ForegroundColor Yellow

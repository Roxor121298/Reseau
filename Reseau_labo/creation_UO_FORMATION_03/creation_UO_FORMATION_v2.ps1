#==========================================================================
# Technique: Fichier CSV avec PowerShell
# 
# Cr�ation de la structure des unit�s d'organisation
# Cette version utilise "Try and Catch" avec le nom du message d'erreur
# 
# AUTEUR: Richard Jean
# DATE:   14 septembre 2022
# 
# COMMENTAIRES: 
#   Le fichier csv contient
#   - le nom de la UO
#   - le DistinguishedName de son parent
#==========================================================================
Clear-Host

#-------------------------------------------------------------------------------
$OU = "OU=FORMATION,DC=formation,DC=local"

try
{
  Get-ADOrganizationalUnit -Identity $OU
  
  $message = "$OU existe, donc on l'efface."
  Write-Host $message  -ForegroundColor Green

  Set-ADOrganizationalUnit -Identity $OU `
                           -ProtectedFromAccidentalDeletion $false

  Remove-ADOrganizationalUnit -Identity $OU `
                              -Recursive `
                              -Confirm:$false 
}
catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
{
  $message = "$OU n'existe pas."
  Write-Host $message -ForegroundColor Yellow
}
catch
{
  Write-Warning "ERREUR INATTENDUE !!!"
  Exit
}

#-------------------------------------------------------------------------------
# Cr�ation de la structure des UO en utilisant le fichier CSV
$FichierCSV = Import-Csv -Path "UO_FORMATION.csv" `
                         -Delimiter ";"

$Compte = 0

Foreach ($Ligne in $FichierCSV)
{
  $Nom    = $Ligne.Nom
  $Parent = $Ligne.Parent
  
  New-ADOrganizationalUnit -Name $Nom `
                           -Path $Parent `
                           -ProtectedFromAccidentalDeletion $false

  $Compte++
}

$message = "Cr�ation de $Compte unit�s d'organisation."
Write-Host $message

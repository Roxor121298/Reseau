#==========================================================================
# Technique: Fichier CSV avec PowerShell
# 
# Cr�ation de la structure des unit�s d'organisation (version 1)
# Cette version n'utilse pas "Try and Catch"
# 
# AUTEUR: Richard Jean
# DATE:   14 septembre 2021
# 
# COMMENTAIRES: 
#   Le fichier csv contient
#   - le nom de la UO
#   - le DistinguishedName de son parent
#==========================================================================
Clear-Host

#-------------------------------------------------------------------------------
$OU = "OU=FORMATION,DC=formation,DC=local"

# Enl�ve la protection contre la suppression accidentelle
# Si la OU n'existe pas il y aura un message d'erreur
Set-ADOrganizationalUnit -Identity $OU `
                         -ProtectedFromAccidentalDeletion $false

# On efface la OU
# Si la OU n'existe pas il y aura un message d'erreur
Remove-ADOrganizationalUnit -Identity $OU `
                            -Recursive `
                            -Confirm:$false 

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

Write-Host "Cr�ation de $Compte unit�s d'organisation."

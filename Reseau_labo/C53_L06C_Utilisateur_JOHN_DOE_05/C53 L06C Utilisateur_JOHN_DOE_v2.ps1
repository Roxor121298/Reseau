#==========================================================================
# AUTEUR: Richard Jean 
# DATE  : 25 mai 2024
#
# Cr�ation d'un utilisateur � l'aide des cmdlets du module ActiveDirectory
# L'utilisateur sera cr�� directement sous l'unit� d'organisation TEST
#==========================================================================
Clear-Host

# On efface le compte utilisateur avant de le cr�er
try
{
  Get-ADUser -Identity "John.Doe" | Out-Null
  Write-Warning "Le compte utilisateur 'John Doe' existe, donc on l'efface." 

  Remove-ADUser -Identity "John.Doe" -Confirm:$False
}
catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
{
  Write-Host "Le compte 'John Doe' n'existe pas." -ForegroundColor Yellow
}
catch
{
  Write-Warning "ERREUR INATTENDUE !!!"
  Exit
}

$mdp = ConvertTo-SecureString -AsPlainText "AAAaaa111" -Force

# $params contient les param�tres de New-ADUser
$params = @{
  Name = "John Doe"
  SamAccountName = "John.Doe"
  UserPrincipalName = "John.Doe@FORMATION.LOCAL"
  Path = "OU=test,DC=formation,DC=local"
  GivenName = "John"
  Surname = "Doe"
  DisplayName = "John Doe" 
  Description = "Mon premier utilisateur"
  Office = "INFORMATIQUE"
  OfficePhone = "514-999-6000"
  HomePhone = "450-222-2222"
  MobilePhone = "450-333-3333"
  Fax = "450-444-4444"
  EmailAddress = "John.Doe@FORMATION.LOCAL"
  HomePage = "WWW.FORMATION.LOCAL"
  OtherAttributes = @{'c'="CA";'co'="CANADA";'countryCode'=124;
                      'otherTelephone'="514-999-7000","514-999-8000"}
  AccountPassword = $mdp
  PasswordNeverExpires = $true
  Enabled = $true
}
New-ADUser @params

Write-Host "Fin de la cr�ation du compte utilisateur 'John Doe'" -ForegroundColor Cyan

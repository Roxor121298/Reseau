#====================================================
# Solution programmation des unités d'organisation
# 1 septembre 2023
#====================================================
Clear-Host

#====================================================
# Code pour détruire la UO "PROG"
#Enlève la protection contre la suppression accidentelle
#Si la OU n'existe pas il y aura un message d'erreur
Set-ADOrganizationalUnit -Identity "OU=prog,DC=formation,DC=local" `
                         -ProtectedFromAccidentalDeletion $false

#Suppression de la OU "PROG" qui est sous le domaine FORMATION.LOCAL
#Si la OU n'existe pas il y aura un message d'erreur
Remove-ADOrganizationalUnit -Identity "OU=prog,DC=formation,DC=local" `
                            -Confirm:$false `
                            -Recursive

#====================================================  
#Création de la OU "PROG" sous le domaine FORMATION.LOCAL
New-ADOrganizationalUnit -Name "PROG" `
                         -Path "DC=formation,DC=local" `
                         -Description "PROG est sous le domaine" `
                         -ProtectedFromAccidentalDeletion $false

#Création de la OU "Niveau1" sous "PROG"
New-ADOrganizationalUnit -Name "Niveau1" `
                         -Path "OU=PROG,DC=formation,DC=local" `
                         -Description "Niveau1 est sous PROG" `
                         -ProtectedFromAccidentalDeletion $false

#Création de la OU "Niveau2" sous "Niveau1"
New-ADOrganizationalUnit -Name "Niveau2" `
                         -Path "OU=Niveau1,OU=PROG,DC=formation,DC=local" `
                         -Description "Niveau2 est sous Niveau1" `
                         -ProtectedFromAccidentalDeletion $false

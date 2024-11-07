@ECHO OFF
REM Vous devez exécuter ce script en tant qu'Administrateur

xcopy \\SERVEUR1\C$\Windows\PolicyDefinitions \\formation.local\SYSVOL\formation.local\Policies\PolicyDefinitions\  /S

PAUSE

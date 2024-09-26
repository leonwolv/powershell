onnect-AzureAD

$name = Import-Csv -Path "C:\Install\teamsroom.csv" -Delimiter ";"



foreach ($naam in $name){


$mailaddres = $naam.naam + "@provincieutrecht.onmicrosoft.com"
$Alias = $naam.naam  + "@provincie-utrecht.nl"
$displayname = $naam.naam

$accountobjectId = Get-AzureADUser -ObjectID $mailaddres | Select-Object ObjectId
#$acountobjectid
Set-AzureADUser -ObjectID $accountobjectId.objectid -PasswordPolicies DisablePasswordExpiration

# licentie groep koppelen

Add-AzureADGroupMember  -ObjectId "hier object id groep platsen" -RefObjectId $accountobjectId.objectid

# condtional access groep koppelen

Add-AzureADGroupMember -ObjectId "hier object id groep platsen" -RefObjectId $accountobjectId.objectid


}

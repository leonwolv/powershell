$mailboxname = ""
$mailaddres = $mailboxname + "domain"
$beheerder = ""
$Securitygroupname = $mailboxname + "_autorisatie" 
$Securitygroupmail= $Securitygroupname + "domain"

Write-Output("mailadres = " + $mailaddres)
Write-Output("groepsnaam = " + $Securitygroupname)
Write-Output("Securitygroupmail = " + $Securitygroupmail)

New-DistributionGroup -Name $Securitygroupname -Type "Security" -PrimarySmtpAddress $Securitygroupmail -ManagedBy $beheerder
New-Mailbox -Shared -name $mailboxname -PrimarySmtpAddress $mailaddres
Add-MailboxPermission -Identity $mailaddres -User $Securitygroupmail -AccessRights FullAccess
Add-RecipientPermission -Identity $mailaddres -AccessRights SendAs -Trustee $Securitygroupmail
get-MailboxPermission -Identity $mailaddres

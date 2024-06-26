Connect-ExchangeOnline


$name = Import-Csv -Path C:\Install\teamsroom.csv -Delimiter ";"



foreach ($naam in $name){


$mailaddres = $naam.naam + "@domain.onmicrosoft.com"
$Alias = $naam.naam  + "@domain.nl"


New-Mailbox -MicrosoftOnlineServicesID $mailaddres -Name $naam.naam -Alias $naam.naam -Room -EnableRoomMailboxAccount $true  -RoomMailboxPassword (ConvertTo-SecureString -String $naam.wachtwoord -AsPlainText -Force)
Start-Sleep -Seconds 30
Set-CalendarProcessing -Identity $naam.naam -AutomateProcessing AutoAccept -AllowConflicts $false -MaximumDurationInMinutes 1440 -AddOrganizerToSubject $false -DeleteComments $True -DeleteSubject $false -ProcessExternalMeetingMessages $true -RemovePrivateProperty $true -AddAdditionalResponse $false -AdditionalResponse "This is a Microsoft Teams Meeting room!"
add-MailboxPermission -Identity $mailaddres -User "group naam" -AccessRights FullAccess

Set-Mailbox $naam.naam -EmailAddresses @{add=$Alias}
Set-MailboxCalendarConfiguration -Identity $mailaddres -WorkingHoursTimeZone "W. Europe Standard Time"
Set-MailboxRegionalConfiguration -Identity $mailaddres -TimeZone "W. Europe Standard Time"
}

$groups = Get-DistributionGroup -ResultSize unlimited
$memberInfoCollection = @()

foreach ($group in $groups) {
    $Owners = Get-DistributionGroup -Identity $group | Select-Object -ExpandProperty ManagedBy

    foreach ($Owner in $Owners){
        if ($owner -ne 'Beheer Exchange' -and $owner -ne 'Organization Management'){
        
        $user = Get-User -Identity $Owner
        if ($user.Department -eq "") {
            $memberInfo = New-Object PSObject -Property @{
                GroupName   = $group.DisplayName
                GroupEmail  = $group.PrimarySmtpAddress
                MemberName  = $user.DisplayName
                MemberEmail = $user.UserPrincipalName
                Department  = $user.Department
            }
            $memberInfoCollection += $memberInfo
        }
    }
}
}
# Output the collection or export it to a CSV file
$memberInfoCollection | Export-Csv -Path "C:\DistributionGroupMembers.csv" -NoTypeInformation

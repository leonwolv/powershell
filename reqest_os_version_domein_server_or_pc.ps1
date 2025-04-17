$servers = Import-Csv -Path "C:\Install\servers.csv" -Delimiter ";"
$serversinfo = @()
foreach ($server in $servers.name) {
    $serveros = Get-CimInstance Win32_OperatingSystem -ComputerName $server | Select-Object Caption, PSComputerName
   
    $serverinfo = New-Object PSObject -Property @{
        ServerName = $serveros.PSComputerName
        OSVersion  = $serveros.Caption
    }
    $serversinfo += $serverinfo
    
}
$serversinfo | Export-Csv -Path "C:\Install\serversinfo.csv" 

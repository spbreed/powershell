# variables
$spec_alias = 'ShareSQL'
$AliasName = Read-Host -Prompt "Enter name of the Alias you want to set. Press Enter if you want the alias to be $spec_alias"
If ($AliasName -eq "") {$AliasName = $spec_alias}
$ServerName = gc env:computername
$TCP = "DBMSSOCN," + $ServerName
$NamedPipes = "DBNMPNTW,\\" + $ServerName + "\pipe\sql\query"
 
# two Registry locations for the SQL Alias locations
$x86 = "HKLM:\Software\Microsoft\MSSQLServer\Client\ConnectTo"
$x64 = "HKLM:\Software\Wow6432Node\Microsoft\MSSQLServer\Client\ConnectTo"
 
# Check to see if the ConnectTo reg keys already exist
if ((test-path -path $x86) -ne $True)
{
    write-host "$x86 doesn't exist"
    New-Item $x86
}
if ((test-path -path $x64) -ne $True)
{
    write-host "$x64 doesn't exist"
    New-Item $x64
}
 
#Create TCP/IP Alias
New-ItemProperty -Path $x86 -Name $AliasName -PropertyType String -Value $TCP
New-ItemProperty -Path $x64 -Name $AliasName -PropertyType String -Value $TCP
 
#Create Named Pipes Alias
#New-ItemProperty -Path $x86 –Name $AliasName -PropertyType String -Value $NamedPipes
#New-ItemProperty -Path $x64 –Name $AliasName -PropertyType String -Value $NamedPipes

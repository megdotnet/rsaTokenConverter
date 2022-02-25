
Write-Host $user
function get-device {
    Write-Host "Device Type"
    Write-Host "1) Android"
    Write-Host "2) iPhone"
    Read-Host
 }

do {
    $d = get-device     
    switch ($d) 
    {
        "1" {$device = "-android"}
        "2" {$device = "-ios"}
        Default {Write-Host "Invalid Selection"}    
    }
} Until ($d -eq "1" -or $d -eq "2")

Expand-Archive -Path $PSScriptRoot\*.zip -DestinationPath $PSScriptRoot -Force
$item = Split-Path -Path $PSScriptRoot\*.sdtid -Leaf -Resolve
$user = $item.Split("_")[0]
New-Item -Path $PSScriptRoot\$user -ItemType Directory -Force
Move-Item $PSScriptRoot\$item -Destination $PSScriptRoot\$user -Force

Set-Location $PSScriptRoot
$sdtid = Get-ChildItem $user\*.sdtid | Split-Path -Leaf
$sdtid = $user + "\" + $sdtid

$arg = '-jar TokenConverter.jar ' + $sdtid + ' ' + $device + ' -qr -o ' + $user + "\" + $user + '.jpeg"'
Start-Process java -ArgumentList $arg
Remove-Item .\Software_Tokens.zip
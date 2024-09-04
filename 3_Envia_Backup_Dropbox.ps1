<#
Fonte:
https://blog.kartech.com/2021/07/file-backups-to-dropbox-with-powershell.html
#>

function SendToDropbox {
    
    Param(
        [Parameter(Mandatory=$true)]
        [string]$SourceFilePath,

        [Parameter(Mandatory=$true)]
        [string]$TargetFilePath
    )

    $token = $env:DropBoxAccessToken.Trim()
    $authorization = "Bearer $token"

    Write-Host "Authorization Header: $authorization"  # Para verificar o valor do token
    
    $arg = '{ "path": "' + $TargetFilePath + '", "mode": "add", "autorename": true, "mute": false }'

    $headers = @{
        "Authorization" = $authorization
        "Dropbox-API-Arg" = $arg
        "Content-Type" = 'application/octet-stream'
    }

    Invoke-RestMethod -Uri "https://content.dropboxapi.com/2/files/upload" -Method Post -InFile $SourceFilePath -Headers $headers
}

$files = Get-ChildItem "C:\WKRadar\Backup" -Filter *.7z

foreach ($f in $files) {
    $target = "/WKWKRadar/Backup/" + $f.Name
    Write-Host "Uploading: $($f.FullName) to $target"
    SendToDropbox -SourceFilePath $f.FullName -TargetFilePath $target
}

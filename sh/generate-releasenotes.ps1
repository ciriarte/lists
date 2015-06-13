param (
  [string]$owner    = $(throw "-owner is required."),
  [string]$repo     = $(throw "-repo is required."),
  [string]$base     = 'master',
  [string]$username = $(throw "-username is required."),
  [string]$password = $(throw "-password is required.")
)

$command = 'git log --oneline ' + $base + '..HEAD'

$issueNumbers =
iex $command | 
    Select-String -pattern '(issues?|hotfix(es)?)/(\d+)' -allmatches |
    ForEach-Object { $_.matches } |
    ForEach-Object { $_.groups[3].Value } |
    Sort | Select-Object -Unique

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username,$password)))

$baseApiUri = 'https://api.github.com/'

$issues =
$issueNumbers | ForEach-Object {
    $uri = $baseApiUri + 'repos/' + $owner + '/' + $repo + '/issues/' + $_
    Invoke-RestMethod -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -Uri $uri
}

$filename = '.\release-notes.md'

Out-File $filename -InputObject '# Release Notes  ' -Encoding utf8
$issues | ForEach-Object {
    Out-File $filename -InputObject '  ' -Append -Encoding utf8
    $title = '## ' + $_.number + ' - ' + $_.title + '  ' 
    Out-File $filename -InputObject $title -Append -Encoding utf8
    Out-File $filename -InputObject '  ' -Append -Encoding utf8
    Out-File $filename -InputObject $_.body -Append -Encoding utf8
}

# Powershell is a bit stupid and writes BOMbs happily
$content = Get-Content $filename
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding($False)
[System.IO.File]::WriteAllLines($PSScriptRoot + $filename, $content, $Utf8NoBomEncoding)

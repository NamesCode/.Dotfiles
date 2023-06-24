$prefix = Join-Path $env:USERPROFILE -ChildPath ".config"
$sourcePath = Join-Path $PWD "ext"

$destPath = Join-Path $prefix "wezterm"
Remove-Item $destPath -Recurse -Force
Copy-Item $sourcePath\wezterm -Destination $destPath -Recurse

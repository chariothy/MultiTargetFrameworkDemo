param($installPath, $toolsPath, $package, $project)

Import-Module (Join-Path $toolsPath VS.psd1)
if ($project.Type -eq 'Web Site') {
    $projectRoot = Get-ProjectRoot $project
    if (!$projectRoot) {
        return;
    }

    $binDirectory = Join-Path $projectRoot "bin"
    $libDirectory = Join-Path $installPath "lib"
    $nativeBinDirectory = Join-Path $installPath "NativeBinaries"
    $resourceDirectory = Join-Path $installPath "Resource"

    Remove-FilesFromDirectory $libDirectory $binDirectory
    Remove-FilesFromDirectory $nativeBinDirectory $binDirectory
    Remove-FilesFromDirectory $resourceDirectory $binDirectory
}
else {
    Remove-PostBuildEvent $project $installPath
}
Remove-Module VS
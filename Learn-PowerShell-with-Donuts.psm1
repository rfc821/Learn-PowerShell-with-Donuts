$ModuleRoot = Split-Path -Parent $PSCommandPath;
Get-ChildItem -Path "$ModuleRoot\Functions\" -Include '*.ps1' -Recurse |
    ForEach-Object {
        Write-Verbose "Loading Function ""$_.FullName""";
        . $_.FullName;
    }

$exportedFunctions = @(
  'Get-Donut',
  'New-Donut',
  'Set-Donut'
);

Export-ModuleMember -Function $exportedFunctions;
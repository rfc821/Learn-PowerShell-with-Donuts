<#
    .SYNOPSIS
    Retrieves Donuts to show some fundamental PowerShell concepts.

    .DESCRIPTION
    The function retrieves Donut-Objects (PSCustom-Objects) that have been created with
    New-Donut.

    This is a nice way to get familiar with the object-oriented pipeline in PowerShell.

    The Donut module showes following concepts:
    - Writing functions (New-Donut, Set-Donut, Get-Donut)
    - Use this fuctions to create a simple script-module (Learn-PowerShell-with-Donuts)

    The functions demonstrate following concepts:
    - Error Handling with try/catch
    - Object-oriented pipeline

    Like any other Get-Cmdlet this does not make any changes on your system.
    In the background it retrieves the Donut-Objects from a global variable.

    .PARAMETER Identity
    Specifies the Identity of the Donut. Each Donut has an unique identifier.

    .EXAMPLE
    Get-Donut -Identity 5

    Outputs Donut 5

    .EXAMPLE
    Get-Donut | Where Style -eq 'Glazed' | Set-Donut -Style 'Boston Creme'

    Turns Glazed Donuts into delicous Boston Creme Donuts.

    .NOTES
    This function was created and tested on macOS using Visual Studio Code (VS Code).
    Therefore it is based on the functionality of .NET Core.

    I formed this idea during a travel in ICE from Frankfurt to Nuremberg. We had some
    technical problems on the train and stopped for a while. No Dunkin Donut was nearby.
    So this code was born to create at least some virtual Donuts.

    .LINK
    http://github.com/rfc821/Learn-PowerShell-with-Donuts
#>

[CmdletBinding()]
param(
    [Parameter(Position=1,ValueFromPipeline=$True)]
    [string]$Identity
)


BEGIN {}

PROCESS {

    if ($Identity) {

        foreach ($Id in $Identity) {
        Write-Debug "User  specified an Identity. Looking for Identity ""$Id"""

            try {
                $Donut = $Global:DonutBox | Where-Object Identity -eq $Id
                if ($Donut -eq $Null) {
                    throw
                }
                
                Write-Output $Donut
            }

            catch {
                Write-Warning "Donut ""$Identity"" not found"
            }

        }

    } else {

        Write-Debug "Output the whole DonutBox"
        Write-Output $DonutBox

    }

}

END {}
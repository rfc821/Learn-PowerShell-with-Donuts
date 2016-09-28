<#
    .SYNOPSIS
    Modifies Donuts to show some fundamental PowerShell concepts.

    .DESCRIPTION
    The function is one possible way to modify Donut-Objects (PSCustom-Objects).
    This is a nice way to get familiar with the object-oriented pipeline in PowerShell.

    Welcome to the Donut shop!

    ********    Note that the baker has following business hours    ********
        Monday - Saturday
        8:00 am - 3:00 pm
    
        Outside this business hours you maye receive a PowerShell
        exeption when trying to modify donuts.

        Opened on public holidays!
    ************************************************************************

    The Donut module showes following concepts:
    - Writing functions (New-Donut, Set-Donut, Get-Donut)
    - Use this fuctions to create a simple script-module (Learn-PowerShell-with-Donuts)

    The functions demonstrate following concepts:
    - Functions
    - Input Arrays into you scripts
    - Error Handling with try/catch
    - Object-oriented pipeline

    Instead of other Cmdlets like New-ADUser this function does not make any changes on your system.
    In the background it saves the Donut-Objects in a global variable.

    .PARAMETER Identity
    Specifies the Identity of the Donut. Each Donut has an unique identifier.

    .PARAMETER Style
    Sets the kind of Donut you want. Option are:
    - Sugar
    - Boston Creme
    - Bavarian Creme
    - Glazed
    - Blue Sky
    - Blueberry Crunch

    .PARAMETER Force
    
    You may force the Donut baker to manipulate Donuts outside his business hours.

    .EXAMPLE
    Set-Donut -Identity 5 -Style 'Boston Creme'

    Turns Donut 5 into a Boston Creme Donut.

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

[CmdletBinding()]    <# add: What-If #>
param(
    [Parameter(Mandatory=$True,Position=1,ValueFromPipeline=$True)]
    [string]$Identity,
    <# add:   ValueFromPipelineByPropertyName=$true #>

    [Parameter(Mandatory=$True,Position=1,ValueFromPipeline=$True)]
    [ValidateSet("Sugar","Boston Creme","Bavarian Creme","Glazed","Blue Sky","Blueberry Crunch")]
    [string]$Style,

    [Parameter(Mandatory=$False)]
    [switch]$Force
)

BEGIN {

    Write-Debug "Checking if we are within business hours"
    if(!($Force)) {
        $Date = Get-Date
        if (($Date.DayOfWeek -eq 'Sunday') -or ($Date.Hour -lt 8) -or ($Date.Hour -gt 15)) {
            throw "Outside business hours. Try again later."
        }
    }
    <# add:   funny error messages during daytime and evenings #>

}

PROCESS {

    try {
        Write-Verbose "Checking if Donut $Identity exists"
        if (!($Global:DonutBox.$Identity)) {
            throw <# add: Information for catch about the error #>
        }
        <# add: Blueberry Crunch only on Wednesdays! - Exception #> <# add: Information for catch about the error #>

        Write-Verbose "Modify Donut-Object"
        <# add:   find out array number from existing Donut #>
        <# add:   modify the existing object #>

    }
    catch {
        Write-Warning "Donut ""$Identity"" not exists!"
    }

}

END {}
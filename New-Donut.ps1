<#
    .SYNOPSIS
    Creates new Donuts to show some fundamental PowerShell concepts.

    .DESCRIPTION
    The purpose is simple: You input the arguments 'Style' and 'Identity'.
    The function returns some very tasty Donut-Objects (PSCustom-Objects).

    This is a nice way to get familiar with the object-oriented pipeline in PowerShell.
    You can manipulate this output with many Cmdlets like Sort-Object or Set-Donut.

    Welcome to the Donut shop!

    ********    Note that the baker has following business hours    ********
        Monday - Saturday
        8:00 am - 3:00 pm
    
        Outside this business hours you maye receive a PowerShell
        exeption when trying to create new donuts.

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
    Specifies the name of the Donut. You may choose your own, unique identity for each Donut.

    .PARAMETER Style
    Determines what kind of Donut you want. Option are:
    - Sugar
    - Boston Creme
    - Bavarian Creme
    - Glazed
    - Blue Sky
    - Blueberry Crunch

    .PARAMETER Force
    
    You may force the Donut baker to make Donuts outside his business hours.

    .EXAMPLE
    New-Donut -Style 'Glazed'

    Creates two Glazed Donuts.

    .EXAMPLE
    Import-Csv $home\order.csv | New-Donut

    This is convenient for big orders.
    It imports an order from a CSV and creates Donuts.

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

    Write-Debug "Creating an empty array if DonutBox does not exist"
    if ($Global:DonutBox -eq $null) {
        $Global:DonutBox = @()
    }

}

PROCESS {

    try {
        Write-Debug "Checking if Donut $Identity is a unique identifier"
        if (($Global:DonutBox | Where Identity -eq $Identity) -ne $null) {
           Write-Debug "Throw an exception because Donut already exists"
           throw "Donut ""$Identity"" already exists."
        }

        Write-Debug "Checking if Blueberry Crunch available"
        if ($Date.DayOfWeek -ne 'Wednesday' -and $Style -eq "Blueberry Crunch") {
            throw "Blueberry Crunch is only available on Wednesday"
        }

        Write-Debug "Creating a new Donut-Object"
        $properties = @{Identity = $Identity;
                        Style = $Style}

        $Donut = New-Object -TypeName PSObject -Property $properties
        $Donut.PSObject.TypeNames.Insert(0,'DonutObject')
        Write-Output $Donut

        Write-Debug "Adding Donuts on DonutBox-Variable"
        $Global:DonutBox += $Donut
    }
    catch {
        Write-Debug "Output Exception Message"
        $ErrorMessage = $Error[0].Exception.Message
        Write-Warning $ErrorMessage
    }

}

END {}
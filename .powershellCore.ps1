Set-PSReadLineOption -EditMode Emacs

# a metric fuck town of this came from @mrled
# he's very great. thanks for the kick start
# Add git, register ssh utils
## Update path for SSH (Loaded in PowerShell Profile)
$env:path += ";" + (Get-Item "Env:ProgramFiles").Value + "\Git\bin"
$env:path += ";" + (Get-Item "Env:ProgramFiles").Value + "\Git\usr\bin"

## Spoof terminal environment for git color.
$env:TERM = 'cygwin'

Pop-Location

function ConvertTo-MaskLength {
  <#
    .Synopsis
      Returns the length of a subnet mask.
    .Description
      ConvertTo-MaskLength accepts any IPv4 address as input, however the output value 
      only makes sense when using a subnet mask.
    .Parameter SubnetMask
      A subnet mask to convert into length
  #>

  [CmdLetBinding()]
  param(
    [Parameter(Mandatory = $True, Position = 0, ValueFromPipeline = $True)]
    [Alias("Mask")]
    [Net.IPAddress]$SubnetMask
  )

  process {
    $Bits = "$( $SubnetMask.GetAddressBytes() | ForEach-Object { [Convert]::ToString($_, 2) } )" -replace '[\s0]'

    return $Bits.Length
  }
}

function set-capsToCtrl {
    $hexified = "00,00,00,00,00,00,00,00,02,00,00,00,1d,00,3a,00,00,00,00,00".Split(',') | % { "0x$_"}
    $kbLayout = 'HKLM:\System\CurrentControlSet\Control\Keyboard Layout'
    New-ItemProperty -Path $kbLayout -Name "Scancode Map" -PropertyType Binary -Value ([byte[]]$hexified)
}


$Beep         = [char]7      # beeps @ u
$DoublePrompt = [char]187    # ?? (RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK)
$Lambda       = [char]955    # ?? (GREEK LETTER LAMBDA)
$HammerSickle = [char]9773   # ??? (HAMMER AND SICKLE)
$VisualStudio = [char]42479  # ??? (VAI SYLLABLE GBE)
   

function Set-UserPrompt {
    [CmdletBinding(DefaultParameterSetName='BuiltIn')] param(
        [Parameter(Position=0, ParameterSetName='BuiltIn')] [ValidateSet('Color','Simple','Tiny')] [String] $builtInPrompt = 'Color',
        [Parameter(Position=0, Mandatory=$True, ParameterSetName='Custom')] [Scriptblock] $newPrompt
    )

    $builtIns = @{
        # A color prompt that looks like my bash prompt. Colors require write-host, which sometimes
        # doesn't play nice with other things. 
        Color = {
            # Useful with ConEmu's status bar's "Console Title" field - always puts your CWD in the status bar
            $Host.UI.RawUI.WindowTitle = $pwd
            Write-Host $(get-date -format HH:mm:ss) -nonewline -foregroundcolor White
            Write-Host " ǰ $Lambda " -nonewline -foregroundcolor Blue
            #return " $Lambda "
            $SoyAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
            if ($SoyAdmin) {
                Write-Host " $($SpecialCharacters.HammerSickle) " -NoNewLine -ForegroundColor Red -BackgroundColor Yellow
            }
            else {
                Write-Host $SpecialCharacters.DoublePrompt -NoNewLine -ForegroundColor White
            }
            # Always return a string or PS will echo the standard "PS>" prompt and it will append to yours
            return " "
        }

        # A one-line-only prompt with no colors that uses 'return' rather that 'write-host'
        Simple = {
            $SoyAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
            $lcop = if ($SoyAdmin) {"#"} else {'>'}
            return "$((get-date).Tostring('HH:mm:ss')) $env:COMPUTERNAME $(Get-DisplayPath $pwd) PS$lcop "
        }

        # A very tiny prompt that at least differentiates based on color
        Tiny = {
            if (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) { $lcop = "#" }
            else { $lcop = ">" }
            write-host "$([Security.Principal.WindowsIdentity]::GetCurrent().Name) PS$lcop" -foreground Green -nonewline
            return " "
        }
    }

    if ($PsCmdlet.ParameterSetName -eq 'BuiltIn') {
        Set-UserPrompt -newPrompt $builtIns[$builtInPrompt]
        return
    }
    New-Item -Force -Path Function:\prompt -Value $newPrompt | Out-Null
}

function reimport-module {
    param([parameter(mandatory=$true)] [string] $moduleName)
    $module = get-module $moduleName
    if ($module) {
        write-host "Module is imported. Removing and re-adding."
        remove-module $moduleName
        import-module $module.path
    }
    else {
        write-host "Module was not imported. Trying to add module $modulename..."
        import-module $modulename
    }
}

<#
.description
Useful in case one of those fucking color commands perma fucks with your background/foreground color. These are my preferences. Get the default values by launching Powershell -NoProfile and examining $Host.UI.RawUI and $Host.PrivateData
#>
function Set-ConsoleColors {
    [CmdletBinding()] Param(
        $BackgroundColor = 'Black',
        $ForegroundColor = 'White',
        $ErrorForegroundColor = 'Red',
        $ErrorBackgroundColor = 'Black',
        $WarningForegroundColor = 'Magenta',
        $WarningBackgroundColor = 'Black',
        $DebugForegroundColor = 'Yellow',
        $DebugBackgroundColor = 'Black',
        $VerboseForegroundColor = 'Green',
        $VerboseBackgroundColor = 'Black',
        $ProgressForegroundColor = 'DarkBlue',
        $ProgressBackgroundColor = 'White'
    )
    $Host.UI.RawUI.BackgroundColor = $BackgroundColor
    $Host.UI.RawUI.ForegroundColor = $ForegroundColor
    $Host.PrivateData.ErrorForegroundColor = $ErrorForegroundColor
    $Host.PrivateData.ErrorBackgroundColor = $ErrorBackgroundColor
    $Host.PrivateData.WarningForegroundColor = $WarningForegroundColor
    $Host.PrivateData.WarningBackgroundColor = $WarningBackgroundColor
    $Host.PrivateData.DebugForegroundColor = $DebugForegroundColor
    $Host.PrivateData.DebugBackgroundColor = $DebugBackgroundColor
    $Host.PrivateData.VerboseForegroundColor = $VerboseForegroundColor
    $Host.PrivateData.VerboseBackgroundColor = $VerboseBackgroundColor
    $Host.PrivateData.ProgressForegroundColor = $ProgressForegroundColor
    $Host.PrivateData.ProgressBackgroundColor = $ProgressBackgroundColor
}

function Test-ProgressBar {
    for ($i = 0; $i -lt 100; $i+=20 ) {
        Write-Progress -Activity "Test in progress" -Status "$i% Complete:" -PercentComplete $i
        Start-Sleep 1
    }
}

# make 'ls -la' actually work in powershell since i type it by
# default all the fucking time:
function ls     {
    param(
        [switch] $la
    )
    get-childitem
}

# Run commands
Set-UserPrompt
remove-item alias:ls

set-alias lsl Get-ChildItem
set-alias emacsclient emacsclientw.exe

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

Import-Module "~\Documents\projects\agares\powershell\AsciiArt.psm1"

Show-AsciiCurvyWindowsLogo

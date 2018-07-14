# handle mass install of programs needed for new windows workstations
Import-Module .\deploy-WinWorkstation.psm1

$chocoPrograms = @(
    "pwsh",
    "git",
    "vscode",
    "emacs64",
    "python2",
    "python3",
    "docker",
    "slack",
    "discord",
    "keybase",
    "spotify",
    "1password",
    "firefox",
    "dropbox",
    "conemu",
    "virtualbox"
)
choco install $chocoPrograms -y

DisableAdvertisingID
DisableAppSuggestions
DisableBackgroundApps
DisableCortana
DisableDiagTrack
DisableFeedback
DisableLockScreenSpotlight
DisableMapUpdates
DisableOneDrive
DisableSmartScreen
DisableSMB1
DisableTelemetry
DisableWebSearch
DisableXboxFeatures
EnableRemoteDesktop
HideTaskbarPeopleIcon
InstallHyperV
InstallLinuxSubsystem
SetExplorerThisPC
SetP2PUpdateLocal
SetPhotoViewerAssociation
ShowKnownExtensions
ShowSmallTaskbarIcons
ShowTaskManagerDetails
ShowTrayIcons
UninstallMsftBloat
UninstallOneDrive
UninstallThirdPartyBloat
UninstallWindowsStore
UnpinStartMenuTiles
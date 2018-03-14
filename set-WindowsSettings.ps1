# set privacy settings:
function set-RegistryValue ($path, $name)        {
    # a restart is required for all changes made by this function
    New-Item -path $path -name $name -itemtype DWORD -Value 0 -Force
}
function disable-WindowsTracking        {
    # must run as administrator
    # i choose to leave the language localization on, but you may not. data on how to disable is available here 
    # https://privacy.microsoft.com/en-us/general-privacy-settings-in-windows-10
    try {
        set-RegistryValue -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows -Name AdvertisingInfo
        set-RegistryValue -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows -Name EnableSmartScreen
        set-RegistryValue -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name Start_TrackProgs
        set-RegistryValue -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name SubscribedContent-338393Enabled
    }
    catch {
        return $false
    }
    return $true
}

# disable dumb default windows settings:
function disable-WindowsDefaults        {
    # disable bing
    $doesFolderExist = Test-Path -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    if($doesFolderExist -eq $false)      {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\" -Name "Windows Search" -Force -ItemType Folder 
    }
    $doesDWORDExist = Test-Path -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search\ConnectedSearchUseWeb"
    if($doesDWORDEXist -eq $false)       {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search\" -Name ConnectedSearchUseWeb -Force -ItemType DWORD -Value 0
    }
    else        {
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search\" -name ConnectedSearchUseWeb -value 0
    }
}
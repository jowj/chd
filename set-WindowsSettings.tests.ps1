import-module .\set-windowssettings.ps1

Describe  'Windows Setting Tests' {
    Context 'Verify that registry logic works.' {
        It 'can create registry keys' {
            set-RegistryValue -path HKLM:\testFolder -name testDword
            test-path -Path HKLM:\testFolder\testDword| Should be $true
        }
    }
}
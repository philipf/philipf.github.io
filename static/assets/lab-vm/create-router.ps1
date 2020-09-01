## Settings
# Download settings
$DebianIsoUri = 'https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-10.5.0-amd64-netinst.iso'
$InstallMedia = Join-Path $env:USERPROFILE 'debian.iso'

# New VM settings
$VmName = 'LinuxRouter'
$VmPath = Join-Path $env:PROGRAMDATA Microsoft\Windows\Hyper-V 'Virtual Machines' 
$VmVhdPath = Join-Path $env:PUBLIC Documents Hyper-V 'Virtual hard disks' "$VmName.vhdx"
$ExternalSwitch = 'External (LAN)' # <1>
$InternalSwitch = 'Internal Switch' # <2>
$MemoryStartupBytes = 2GB # <3>
$NewVHDSizeBytes = 1GB

## Actions
# Download ISO to the user's download folder
Invoke-WebRequest -Uri $DebianIsoUri -OutFile $InstallMedia # <4>

# Create the VM for the Linux router
New-VM -Name $VmName `
    -NewVHDPath $VmVhdPath `
    -MemoryStartupBytes $MemoryStartupBytes `
    -NewVHDSizeBytes $NewVHDSizeBytes `
    -Generation 1 `
    -Switch $ExternalSwitch

Add-VMNetworkAdapter -VMName $VmName -SwitchName $InternalSwitch    
Set-VMDvdDrive $VMName -ControllerNumber 1 -ControllerLocation 0 -Path $InstallMedia

## Start and connect to the VM
Start-VM $VmName
vmconnect.exe localhost $VmName
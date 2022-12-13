# ASUS ROG STRIX Z370-G GAMING Hackintosh Notes

Based on [OpenCore Desktop Guide](https://dortania.github.io/OpenCore-Desktop-Guide/)
Configuration is based on OpenCore 0.6.5

## Comments
Configuration seems stable, no kernel panics or anything not working (unless due to missing hardware i.e. airport wireless).

The motherboard doesn't require too many patches. No need for a custom DSDT.

I only included a config.plist. This repo is supposed to be a reference rather than a copy and paste build. Avoid using anything that automates most of the process.

## Considerations
* iGPU hasn't been strenuously tested. It didn't work the last time I tried to use it.
* You must make your own USB map. Mine doesn't map the front ports since my case lacks them.
## UEFI/BIOS Settings
No configuration needed if using default. Remember to disable VT-d!

If you want the USB 3.1 to work, set these.

* Boot -> CSM -> Launch CSM -> Enabled (Optional, enable for USB 3.1) 

## Working/Not Working
**Working**
* Suspend and Wakeup w/ Power Nap
* Ethernet
* CPU power management
* Audio on-board + external DAC
* SIP
* Multi-monitor, up to 4 tested. Hot-plugging works.
* DRM with HW acceleration, full support
* Functions with iServices with proper SMBIOS configuration. Config in repo has identifing information removed.
* FileVault
* Internal Audio
* USB 3.1 ports seem to require CSM to be enabled in the UEFI.

**Untested**
* NVMe, you should follow a guide if you choose to go down this route.
* iGPU, as mentioned above.

**Not working**
* Bluetooth and Wifi, there is no driver in macOS for the ones on-board. You must buy a compatible device in order to use them.

## Other

### System Specs
* CPU: Intel Core i7 9700K
* Cooler: Cryorig C7G
* Motherboard: ASUS ROG Strix Z370-G Gaming
* Memory: G-Skill F4-3000C16-8GTZR 2x8GB, XMP applied
* Storage: Samsung SSD 860 EVO 1TB
* Video card: XFX Reference AMD Radeon RX Vega 64 RX-VEGMTBFX6
* USB Sound: Focusrite Scarlett Solo 1st Gen + Behringer XENYX Q802USB

UEFI info
* UEFI Version 2401 x64
* Build Date: 07/15/2019
* EC: MBEC-Z370-0206
* ME FW: 11.8.65.3590
* LED EC: AUMA0-E6K5-0104

The XFX card works perfectly fine despite the brand being infamous for capability issues in macOS.

### Issues and Contributions

You can use GitHub's issue tab in the repo if you have questions or have a bugs to report. There is no guarantee that your problem is going to receive attention or not.

### Older Versions

A wiki page is available, detailing what systems the configuration file was confirmed working on during testing.

I tried to organize OpenCore upgrades and major + minor macOS upgrades into seperate branches.

### DSDT/SSDT

The kexts will have the proper corrections for the DSDT and we don't need to define patches or a custom DSDT in OpenCore. Follow OpenCore documentation for SSDT. Our board does not have a AWAC, so you do not need the AWAC patch since the motherboard doesn't feature AWAC.

Therefore, we only need the following SSDT:
* SSDT-EC-USBX
* SSDT-PLUG

Note that if you use SSDTTime, you will only get SSDT-EC. You can just use the generic sample file provided, there are no modifications needed.

## Annotated Steps
You should follow [OpenCore Install Guide](https://dortania.github.io/OpenCore-Install-Guide) and use this guide to supplement.
### Obtaining MacOS
Note that downloading an image of macOS from an unofficial source can be dangerous. Check hashsums to avoid tampered images. gibmacOS seems to be the standard way of retrieval these days.
### Adding the Base OpenCore Files
Our CPU codename is Coffee Lake. The key concern for this section is to remove the unecessary files that aren't needed for our system or purpose. For my logic, I kept the tools since I use it to debug the machine, kept OpenCanopy to have a nice graphical interface that tries to simulate a real Mac on bootup, AudioDxe to get the chime on boot, and the Ps2 files since I still use a PS2 keyboard.
#### Kexts
I'll provide the reasoning why I chose each Kext or Kext Package.
* **VirtualSMC**
macOS requires a SMC to boot to verify if the hardware is genuine. This emulates one. You should use the following kext unless you know what you are doing
> 1. VirtualSMC
>This is the main package to emulate the SMC
> 2. SMCProcessor
> Provides sensor readings in Intel CPUs
> 3. SMCSuperIO
> Other sensor readings.
* **Lilu**
Lilu is a dependency for other important kexts.
* **WhateverGreen**
Patches for GPUs, usually necessary in order to take advantage of hardware acceleration.
* **AppleALC**
Generic HD audio support, likely not needed since I use an USB DAC, but important for general hardware support.
* **IntelMausi**
LAN kext for the on-board Intel GBE
* **VoodooPS2**
I still use a PS2 keyboard. Most people aren't like me. If you are normal and use a USB keyboard, you probably don't need this.

You might need some more depending on your usage, but for my general use, this is fine.

### plist config

Follow the documentation for Coffee Lake on the OpenCore doc. Very little differs from our specific board. You can always reference this repo if you are stuck.

### iServices note

Just want to add a thing. Your IP can be flagged by apple if you exceed login limits or use an invalid SMBIOS configuration. If this happens, you are usually able to login to iCloud, but will not be allowed to use any social iService (e.g. FaceTime, iMessage) without calling Apple. Tethering with your phone hotspot connection via HoRNDIS is the best way if your main isn't already flagged. Avoid using VPNs to activate.





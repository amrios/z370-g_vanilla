Based on [OpenCore Desktop Guide](https://dortania.github.io/OpenCore-Desktop-Guide/)

## Considerations
* iGPU has not been tested and probably doesn't work.
* On-board audio has not been tested.
* Onboard Wi-fi and BT probably doesn't work, I don't use it
* You must make your own USB map. Mine doesn't map the front ports.

This is not a drag and drop build. You are expected to follow OpenCore documentation, use my commit history and notes to figure out my logic. You are expected to have some knowledge on how macOS and the tools function. The OpenCore documentation was pretty much spot on and I had the system booting in one try with almost everything working.

## Working/Not Working
**Working**
* Suspend and Wakeup w/ Power Nap
* Ethernet, might have to play with ethernet options to obtain > 100Mb full duplex
* CPU power management
* Audio via USB DAC via AppleUSBAudioDevice
* SIP
* Multi-monitor, up to 4. Hot-plugging sometimes works, but will always fail if not monitors are plugged in on boot.
* DRM with HW acceleration, full support
* Functions with iServices with proper SMBIOS configuration. Config in repo has identifing information removed.
**Untested**
* USB 3.1 ports. They are on a seperate Asmedia ASM-105x chipset not provided by CPU or SB. I have it disabled in the UEFI. Mapping might not be necessary for these 2 ports.
* FileVault, the configuration has a necessary options for it in order to work though.
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
* Video card: AMD Radeon RX Vega 64
* USB Sound: Focusrite Scarlett Solo 1st Gen

UEFI info
* UEFI Version 2401 x64
* Build Date: 07/15/2019
* EC: MBEC-Z370-0206
ME FW: 11.8.65.3590
LED EC: AUMA0-E6K5-0104

### DSDT/SSDT

The kexts will have the proper corrections for the DSDT and we don't need to define patches or a custom DSDT in OpenCore. Follow OpenCore documentation for SSDT. Our board does not have a AWAC, so you do not need the AWAC patch.

## Annotated Steps
You should follow [OpenCore Desktop Guide](https://dortania.github.io/OpenCore-Desktop-Guide/) and use this guide to supplement.
### Obtaining MacOS
Note that downloading an image of macOS from an unofficial source can be dangerous. Check hashsums to avoid tampered images.
### Adding Base Files
Our CPU codename is Coffee Lake. You'll want to follow the removal part since our goal is to make our modification as small as possible. You can add OpenCanopy if you want. I found some of the tools useful, so I kept some.
#### Kexts
I'll provide the reasoning why I chose each Kext or Kext Package.
* **VirtualSMC**
macOS requires a SMC to boot to verify if the hardware is genuine. This emulates one. You should use the following kext unless warranted.
1. VirtualSMC
This is the main package to emulate the SMC
2. SMCProcessor
Provides sensor readings in Intel CPUs
3. SMCSuperIO
Other sensor readings.
* **Lilu**
Lilu is a dependency for other important kexts.
* **WhateverGreen**
Patches for GPUs, usually necessary in order to take advantage of hardware acceleration.
* **AppleALC**
Generic HD audio support, likely not needed since I use an USB DAC, but important for general hardware support.
* **IntelMausi**
LAN kext for the on-board Intel GBE
* **NoTouchID**
I think you don't need this due to the SMBIOS, but certain prompts may lag when the system expect you to have Touch ID compatible hardware.
* **VoodooPS2**
Generic mouse support

You might need some more depending on your usage, but for my general use, this is fine.

### plist config

Follow the documentation for Coffee Lake on the OpenCore doc. Very little differs from our specific board. You can always reference this repo if you are stuck.





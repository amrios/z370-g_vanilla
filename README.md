Based on [OpenCore Desktop Guide](https://dortania.github.io/OpenCore-Desktop-Guide/)

## Considerations
* iGPU has not been tested and probably doesn't work.
* On-board audio has not been tested.
* Onboard Wi-fi and BT probably doesn't work, I don't use it

This is not a drag and drop build. You are expected to follow OpenCore documentation, use my commit history and notes to figure out my logic. You are expected to have some knowledge on how macOS and the tools function.

### Freely redistributable files only
Files that are not redistributable have copyrighted information will not be included. The file names along with the hash (if possible) will be placed in the same folder where the file is supposed to be under nonfree.txt

## Other

### System Specs
* CPU: Intel Core i7 9700K
* Cooler: Cryorig C7G
* Motherboard: ASUS ROG Strix Z370-G Gaming
* Memory: G-Skill F4-3000C16-8GTZR 2x8GB, XMP applied
* Storage: Samsung SSD 860 EVO 1TB
* Video card: AMD Radeon RX Vega 64
* USB Sound: Focusrite Scarlett Solo 1st Gen

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
* **SATA-200-series-unsupported**
Apple does not use Intel SATA controller in their products. Our board contains a 200 series SATA controller. Do not mix with 100-series.

You might need some more depending on your usage, but for my general use, this is fine.





#!/bin/sh

LINKS[0]="https://api.github.com/repos/acidanthera/Lilu/releases/latest"
LINKS[1]="https://api.github.com/repos/acidanthera/whatevergreen/releases/latest"
LINKS[2]="https://api.github.com/repos/acidanthera/AppleALC/releases/latest"
LINKS[3]="https://api.github.com/repos/acidanthera/IntelMausi/releases/latest"
LINKS[4]="https://api.github.com/repos/acidanthera/VoodooPS2/releases/latest"
LINKS[5]="https://api.github.com/repos/acidanthera/virtualsmc/releases/latest"

for i in "${LINKS[@]}"
do
   curl -s $i \
|   grep "browser_download_url.*RELEASE.zip" \
|   cut -d : -f 2,3 \
|   tr -d \" \
|   wget -qi -

done
   

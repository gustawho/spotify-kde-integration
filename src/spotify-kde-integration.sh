#! /usr/bin/env bash

set -e

#############################################################################
## Helpers & Config
#############################################################################

msg() {
    tput setab 2 # green bg
    tput setaf 7 # white text
    echo ">>> $1"
    tput sgr 0
    sleep 1
}

tmp_dir="/tmp/fsi-$(date +%s)"

#############################################################################
## Main Script
#############################################################################

main() {
    msg "Entering temporary directory..."
    mkdir "$tmp_dir"
    cd "$tmp_dir"

    msg "Making a copy of resources.zip..."
    cp /opt/spotify/spotify-client/Data/resources.zip resources_old.zip
    unzip resources_old.zip -d resources_old/

    msg "Downloading assets..."
    wget -O skin.xml https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/skin.xml
    # Icons
    wget -O spotify-linux-16.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/spotify-linux-16.png
    wget -O spotify-linux-22.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/spotify-linux-22.png
    wget -O spotify-linux-24.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/spotify-linux-24.png
    wget -O spotify-linux-32.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/spotify-linux-32.png
    wget -O spotify-linux-48.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/spotify-linux-48.png
    wget -O spotify-linux-64.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/spotify-linux-64.png
    wget -O spotify-linux-128.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/spotify-linux-128.png
    wget -O spotify-linux-256.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/spotify-linux-256.png
    wget -O spotify-linux-512.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/spotify-linux-512.png
    # Images
    wget -O images.zip https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/images.zip
    # Skin
    wget -O skin.xml https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/skin.xml
    
    msg "Extracting ZIP..."
    unzip images.zip -d images/

    msg "Applying new skin..."
    cp spotify-linux-16.png resources_old/_linux/spotify-linux-16.png
    cp spotify-linux-22.png resources_old/_linux/spotify-linux-22.png
    cp spotify-linux-24.png resources_old/_linux/spotify-linux-24.png
    cp spotify-linux-32.png resources_old/_linux/spotify-linux-32.png
    cp spotify-linux-48.png resources_old/_linux/spotify-linux-48.png
    cp spotify-linux-64.png resources_old/_linux/spotify-linux-64.png
    cp spotify-linux-128.png resources_old/_linux/spotify-linux-128.png
    cp spotify-linux-256.png resources_old/_linux/spotify-linux-256.png
    cp spotify-linux-512.png resources_old/_linux/spotify-linux-512.png
    cp -f images/*.png resources_old/
    cp -f skin.xml resources_old/skin.xml

    msg "Packaging resources.zip..."
    cd resources_old/
    zip -r resources_patched.zip .
    cd ..
    mv resources_old/resources_patched.zip .

    msg "Replacing current resources.zip..."
    sudo cp resources_patched.zip /opt/spotify/spotify-client/Data/resources.zip

    msg "Cleaning up..."
    rm -rf "$tmp_dir"

    msg "The Spotify icon has been replaced successfuly!"
    msg "Start Spotify again to check it out."
    sleep 2
}

#############################################################################
## Bootstrap it
#############################################################################

main "$@"

#!/usr/bin/env bash

set -e

## Helpers & Config

msg() {
  tput sgr0
  tput setaf 2
  echo ">>> $1"
  sleep 1
}

tmp_dir="/tmp/fsi-$(date +%s)"

## Main Script

main() {

  msg "Entering temporary directory..."
  mkdir "$tmp_dir"
  cd "$tmp_dir"

  msg "Backing up resources.zip..."
  cp /usr/share/spotify/spotify-client/Data/resources.zip resources_old.zip
  unzip -z resources_old.zip -d resources_old/

  while true; do
  echo "There are two variants for the tray icon, one for each Breeze style (light and dark),"
  read -p "Which one should I use, (D)ark or (L)ight?" $userin
  if [[ $userin = [dD] ]]; then
    msg "Downloading assets..."
    wget -O spotify-linux-16.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/dark/spotify-linux-16.png
    wget -O spotify-linux-22.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/dark/spotify-linux-22.png
    wget -O spotify-linux-24.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/dark/spotify-linux-24.png
    wget -O spotify-linux-32.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/dark/spotify-linux-32.png
    wget -O spotify-linux-48.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/dark/spotify-linux-48.png
    wget -O spotify-linux-64.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/dark/spotify-linux-64.png
    wget -O spotify-linux-128.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/dark/spotify-linux-128.png
    wget -O spotify-linux-256.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/dark/spotify-linux-256.png
    wget -O spotify-linux-512.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/dark/spotify-linux-512.png
    break
  else
    if [[ $userin = [lL] ]]; then
      msg "Downloading assets..."
      wget -O spotify-linux-16.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/light/spotify-linux-16.png
      wget -O spotify-linux-22.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/light/spotify-linux-22.png
      wget -O spotify-linux-24.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/light/spotify-linux-24.png
      wget -O spotify-linux-32.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/light/spotify-linux-32.png
      wget -O spotify-linux-48.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/light/spotify-linux-48.png
      wget -O spotify-linux-64.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/light/spotify-linux-64.png
      wget -O spotify-linux-128.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/light/spotify-linux-128.png
      wget -O spotify-linux-256.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/light/spotify-linux-256.png
      wget -O spotify-linux-512.png https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/icons/light/spotify-linux-512.png
      break
    else
      echo "You didn't give a valid option. Press D for Dark or L for Light."
      continue
    fi
  fi

  # Images
  wget -O images.zip https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/images.zip
  # Skin
  wget -O skin.xml https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/skin.xml
  
  msg "Extracting ZIP..."
  unzip -z images.zip -d images/

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
  sudo cp resources_patched.zip /usr/share/spotify/spotify-client/Data/resources.zip

  msg "Cleaning up..."
  rm -rf "$tmp_dir"

  msg "Skin successfuly applied!"
  msg "Restart Spotify to check it out."
  sleep 2
}

main "$@"

#! /usr/bin/env bash

set -e

echo -e "\e[1m\e[32m==> \e[39mDownloading main script...\e[0m"
wget -O spotify-kde-integration.sh https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/spotify-kde-integration.sh 2> /dev/null

chmod +x spotify-kde-integration.sh

echo -e "\e[1m\e[32m==> \e[39mInstalling script..."
sudo mv spotify-kde-integration.sh /usr/bin/spotify-kde-integration

sh /usr/bin/spotify-kde-integration
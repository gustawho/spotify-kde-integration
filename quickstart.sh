#! /usr/bin/env bash

set -e

wget -O spotify-kde-integration.sh https://raw.githubusercontent.com/gustawho/spotify-kde-integration/master/src/spotify-kde-integration.sh

chmod +x spotify-kde-integration.sh

sudo mv spotify-kde-integration.sh /usr/bin/spotify-kde-integration

spotify-kde-integration.sh
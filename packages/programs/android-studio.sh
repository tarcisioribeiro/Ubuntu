#!/bin/bash
wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2024.3.1.13/android-studio-2024.3.1.13-linux.tar.gz
tar -zxvf android-studio-2024.3.1.13-linux.tar.gz
sudo mv android-studio /opt/
sudo ln -sf /opt/android-studio/bin/studio /bin/android-studio
sudo cp "$HOME/repos/Ubuntu/packages/programs/android-studio.desktop" /usr/share/applications/

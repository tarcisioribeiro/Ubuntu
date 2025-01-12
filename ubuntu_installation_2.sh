#!/usr/bin/bash
red() {
    echo -e "\033[31m$1\033[0m"
}
green() {
    echo -e "\033[32m$1\033[0m"
}

blue() {
    echo -e "\033[34m$1\033[0m"
}

red "\n|--------- Instalação - Parte 2 ---------|\n"

brew install eza glow tldr fd git-delta
nvm install 20.17.0

git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
mv ~/.config/nvim ~/.config/nvim_old
cp -r ~/repos/Terminal/customization/nvim ~/.config

mkdir -p ~/.config/tilix/schemes/
wget  -qO $HOME"/.config/tilix/schemes/dracula.json" https://git.io/v7QaT

sleep 3

cd ~/Downloads

blue "\nInstalando o i3wm...\n"

sleep 3

sudo apt install -y build-essential libxcb1-dev libxcb-keysyms1-dev \
libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev \
libxcb-randr0-dev libxcb-xinerama0-dev \
libpango1.0-dev libx11-dev libxrandr-dev libxinerama-dev \
libxss-dev libglib2.0-dev libev-dev

sudo apt install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
libstartup-notification0-dev libxcb-randr0-dev \
libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev

/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2024.03.04_all.deb keyring.deb SHA256:f9bb4340b5ce0ded29b7e014ee9ce788006e9bbfe31e96c09b2118ab91fca734
sudo apt install ./keyring.deb
echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
sudo apt update

sudo apt install i3

blue "\nInstalando o i3lock-color...\n"
sleep 3
sudo apt install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev
cd ~/Downloads
git clone https://github.com/Raymo111/i3lock-color.git
cd i3lock-color
./build.sh
./install-i3lock-color.sh
cd ~/Downloads
sudo rm -r i3lock-color

cp ~/repos/Ubuntu/scripts/lock ~/scripts/

blue "\nInstalando gaps do i3...\n"

cd ~/Downloads
git clone https://www.github.com/jbenden/i3-gaps-rounded i3-gaps
cd i3-gaps
mkdir -p build && cd build
meson ..
ninja
sudo ninja install
cd ~/Downloads
sudo rm -r i3-gaps

sudo mv /usr/share/mysql-workbench/data/code_editor.xml /usr/share/mysql-workbench/data/code_editor_old.xml
sudo cp ~/repos/Ubuntu/mysql/code_editor.xml /usr/share/mysql-workbench/

sudo nala install cmatrix pavucontrol

cd ~/repos

git clone https://github.com/tarcisioribeiro/Arch_Linux.git

cp ~/repos/Ubuntu/packages/ookla-speedtest-1.2.0-linux-x86_64.tgz ~/Downloads
cd ~/Downloads
sudo tar -xvzf ookla-speedtest-1.2.0-linux-x86_64.tgz -C /usr/bin
rm ookla-speedtest-1.2.0-linux-x86_64.tgz

sudo snap install youtube-music-desktop-app spotify dbeaver-ce
sudo snap install android-studio --classic

sleep 10

blue "\nBaixando o Flutter...\n"

mkdir -p ~/development

cd ~/Downloads
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.27.1-stable.tar.xz
tar -xf ~/Downloads/flutter_linux_3.27.1-stable.tar.xz -C ~/development/
rm flutter_linux_3.27.1-stable.tar.xz

mkdir -p ~/snap
cd ~/Downloads
cp ~/repos/Arch_Linux/packages/youtube-music-desktop-app.zip .
unzip youtube-music-desktop-app.zip
mv youtube-music-desktop-app ~/snap
rm youtube-music-desktop-app.zip
sudo rm -r Dracula
sudo rm -r snapd

sudo apt install libconfig-dev cmake clang ninja libgtk3-dev libdbus-1-dev libegl-dev libev-dev libgl-dev libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev meson ninja-build uthash-dev

cd ~/Downloads
git clone https://github.com/yshui/picom.git
cd picom
meson setup --buildtype=release build
ninja -C build
ninja -C build install

cp -r ~/repos/Ubuntu/config/autostart ~/.config/
cp -r ~/repos/Ubuntu/config/btop ~/.config/
cp -r ~/repos/Ubuntu/config/cava ~/.config/
cp -r ~/repos/Ubuntu/config/gtk-3.0 ~/.config/
cp -r ~/repos/Ubuntu/config/i3 ~/.config/
cp -r ~/repos/Ubuntu/config/i3status ~/.config/
cp -r ~/repos/Ubuntu/config/rofi ~/.config/
cp -r ~/repos/Ubuntu/config/dunst ~/.config/

cp -r ~/repos/Ubuntu/wallpapers ~/Pictures

mkdir -p ~/scripts
cp -r ~/repos/Ubuntu/scripts ~

ssh-keygen

sudo ufw enable
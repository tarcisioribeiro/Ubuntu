#!/bin/bash
set -e

msg_color() {
  clear
  echo -e "\n\033[$1m$2\033[0m\n"
  sleep 2
}
sudo apt upgrade && sudo apt install nala -y

PACKAGES=(
  toilet curl wget build-essential gcc g++ clang make cmake automake autoconf git stow pkg-config meson ninja-build scdoc
  neofetch tmux rofi fzf bat gdebi feh nitrogen polybar redshift gnome-tweaks gnome-shell-extension-manager xclip xsel
  mpv vlc shotcut obs-studio cava flatpak libpam0g-dev deluge deluged deluge-web deluge-console pavucontrol timeshift openssh-server
  mysql-server default-libmysqlclient-dev dkms perl ruby-full libsdl2-dev libusb-1.0-0-dev adb cpu-checker gh p7zip pv
  qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils ffmpeg libavcodec-dev libavdevice-dev libavformat-dev libavutil-dev
  libswresample-dev gimp libgtk-4-dev libadwaita-1-dev blueman python3 python3-venv python3-tk python3-pip python3-openssl
  python3.10-full python3.10-dev libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libncurses5-dev libncursesw5-dev
  libffi-dev liblzma-dev tk-dev btop stow scrot maim playerctl libxcb1-dev libxcb-keysyms1-dev libxcb-util0-dev i3lock
  libxcb-icccm4-dev libxcb-randr0-dev libxcb-xinerama0-dev libpango1.0-dev libx11-dev libxrandr-dev libxinerama-dev libxss-dev
  libglib2.0-dev libev-dev libxcb-cursor-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev libxcb-xrm0 libxcb-xrm-dev
  libxcb-shape0-dev libconfig-dev libdbus-1-dev libegl-dev libgl-dev libepoxy-dev libpcre2-dev libpixman-1-dev xdotool
  autoconf gcc pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev cargo xss-lock gradle
  libev-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev build-essential dkms nvtop breeze-cursor-theme
  libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev ranger dmenu
  libx11-xcb-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-render0-dev
  acpi light libxcb-render-util0-dev libxcb-util-dev libxcb-xfixes0-dev uthash-dev libfreetype6-dev libfontconfig1-dev
  libxcb-xfixes0-dev libgtk-3-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev
  gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav libgif-dev
  gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio
  libmpv1 locate libcurl4-openssl-dev libgd-dev libonig-dev libpq-dev libzip-dev unzip jq zsh toilet libstartup-notification0-dev libyajl-dev
)

msg_color "34" "Atualizando pacotes e instalando dependências..."
sudo nala update && sudo nala upgrade -y
sudo nala install -y "${PACKAGES[@]}"

msg_color "34" "Instalando o Oh My ZSH..."
REPO_DIR="$HOME/repos/Ubuntu"
TERMINALS_DIR="$REPO_DIR/packages/terminals"
CUSTOMIZATION_DIR="$REPO_DIR/customization"

cd "$TERMINALS_DIR" && ./oh_my_zsh_install.sh || exit

msg_color "34" "Instalando o Oh My Posh..."
sudo wget -q https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh
mkdir -p "$HOME/.poshthemes"
wget -q https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O "$HOME/.poshthemes/themes.zip"
unzip -q "$HOME/.poshthemes/themes.zip" -d "$HOME/.poshthemes"
rm "$HOME/.poshthemes/themes.zip"
ln -sf "$CUSTOMIZATION_DIR/zsh/tj-dracula.omp.json" "$HOME/.poshthemes/tj-dracula.omp.json"

msg_color "34" "Criando diretórios..."
mkdir -p "$HOME/repos" "$HOME/.icons" "$HOME/.themes" "$HOME/scripts"

msg_color "34" "Instalando fontes..."
FONT_DIR="/usr/share/fonts/"
LOCAL_FONT_DIR="$HOME/.local/share/fonts/"
mkdir -p $LOCAL_FONT_DIR
sudo mkdir -p $FONT_DIR
cd "$REPO_DIR/fonts" || exit
sudo cp JetBrains_Mono_Medium_Nerd_Font_Complete_Mono_Windows_Compatible.ttf "$FONT_DIR"
sudo cp JetBrains_Mono_Medium_Nerd_Font_Complete_Mono_Windows_Compatible.ttf "$LOCAL_FONT_DIR"
sudo cp Ubuntu_Mono_Nerd_Font_Complete_Mono.ttf "$FONT_DIR"
sudo cp Ubuntu_Mono_Nerd_Font_Complete_Mono.ttf "$LOCAL_FONT_DIR"
sudo cp JetBrainsMonoNerdFontMono-*.ttf "$FONT_DIR"
sudo cp JetBrainsMonoNerdFontMono-*.ttf "$LOCAL_FONT_DIR"

msg_color "34" "Instalando logo-ls..."
cp "$CUSTOMIZATION_DIR/bash/logo-ls_Linux_x86_64.tar.gz" "$HOME/Downloads"
cd "$HOME/Downloads" || exit
tar -zxf logo-ls_Linux_x86_64.tar.gz
sudo cp logo-ls_Linux_x86_64/logo-ls /usr/local/bin
rm -r logo-ls_Linux_x86_64 logo-ls_Linux_x86_64.tar.gz

msg_color "34" "Ativando o acesso aos apps Flatpak..."
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

msg_color "34" "Instalando o HomeBrew..."
cd "$REPO_DIR/packages/package-managers" && ./brew_install.sh || exit

msg_color "34" "Instalando o Oh My Bash..."
cd "$TERMINALS_DIR" && ./oh_my_bash_install.sh || exit

msg_color "34" "Instalando o Starship..."
cd "$TERMINALS_DIR" && ./starship_install.sh || exit

msg_color "34" "Configurando Tmux..."
git clone --quiet https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
ln -sf "$CUSTOMIZATION_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
tmux new-session -d -s "dev"
tmux source "$HOME/.tmux.conf"
tmux kill-session -t "dev"

msg_color "34" "Configurando HomeBrew no shell..."
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' | tee -a "$HOME/.bashrc" "$HOME/.zshrc" >/dev/null
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
echo ". $HOME/.asdf/asdf.sh" >>~/.bashrc
echo ". $HOME/.asdf/asdf.sh" >>~/.zshrc

#!/usr/bin/env bash
type="$HOME/.config/rofi/applets/type-2"
style='style-2.rasi'
theme="$type/$style"

prompt='Apps'
mesg="Pacotes instalados : $(dpkg --list | grep '^ii' | wc -l) (APT)"

if [[ ("$theme" == *'type-1'*) || ("$theme" == *'type-3'*) || ("$theme" == *'type-5'*) ]]; then
  list_col='1'
  list_row='6'
elif [[ ("$theme" == *'type-2'*) || ("$theme" == *'type-4'*) ]]; then
  list_col='6'
  list_row='1'
fi

term_cmd='$HOME/development/kitty/kitty/launcher/kitty'
file_cmd='nautilus'
text_cmd='code'
web_cmd='firefox'
music_cmd='spotify'
setting_cmd='cinnamon-settings'

# Options
layout=$(cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2)
if [[ "$layout" == 'NO' ]]; then
  option_1=" Terminal <span weight='light' size='small'><i>($term_cmd)</i></span>"
  option_2=" Arquivos <span weight='light' size='small'><i>($file_cmd)</i></span>"
  option_3=" Editor <span weight='light' size='small'><i>($text_cmd)</i></span>"
  option_4=" Navegador <span weight='light' size='small'><i>($web_cmd)</i></span>"
  option_5=" Música <span weight='light' size='small'><i>($music_cmd)</i></span>"
  option_6=" Configurações <span weight='light' size='small'><i>($setting_cmd)</i></span>"
else
  option_1=""
  option_2=""
  option_3=""
  option_4=""
  option_5=""
  option_6=""
fi

rofi_cmd() {
  rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
    -theme-str 'textbox-prompt-colon {str: "";}' \
    -dmenu \
    -p "$prompt" \
    -mesg "$mesg" \
    -markup-rows \
    -theme ${theme}
}

run_rofi() {
  echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6" | rofi_cmd
}

run_cmd() {
  if [[ "$1" == '--opt1' ]]; then
    ${term_cmd}
  elif [[ "$1" == '--opt2' ]]; then
    ${file_cmd}
  elif [[ "$1" == '--opt3' ]]; then
    ${text_cmd}
  elif [[ "$1" == '--opt4' ]]; then
    ${web_cmd}
  elif [[ "$1" == '--opt5' ]]; then
    ${music_cmd}
  elif [[ "$1" == '--opt6' ]]; then
    ${setting_cmd}
  fi
}

chosen="$(run_rofi)"
case ${chosen} in
$option_1)
  run_cmd --opt1
  ;;
$option_2)
  run_cmd --opt2
  ;;
$option_3)
  run_cmd --opt3
  ;;
$option_4)
  run_cmd --opt4
  ;;
$option_5)
  run_cmd --opt5
  ;;
$option_6)
  run_cmd --opt6
  ;;
esac

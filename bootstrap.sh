#!/usr/bin/env bash

base=$(pwd)

do_link() {
  local source_rel_path="$1"
  local source_abs_path="$base/$source_rel_path"
  local dest_abs_path="$2"
  local paths_out="'./$source_rel_path' -> '$dest_abs_path'"

  # Just link if it does not exist
  if [[ ! -e "$dest_abs_path" ]]; then
    ln -s "$source_abs_path" "$dest_abs_path"
    echo "Linked $paths_out"
    return 0
  fi

  echo "==============="
  echo "Action for $paths_out: "
  echo "==============="
  select CHOICE in backup replace skip
  do
    case $CHOICE in
      backup)
        mv "$dest_abs_path" "$dest_abs_path-pre-dotfiles"
        ln -s "$source_abs_path" "$dest_abs_path"
        echo "Backed up and replaced $paths_out"
      ;;
      replace)
        rm -r "$dest_abs_path"
        ln -s "$source_abs_path" "$dest_abs_path"
        echo "Replaced $paths_out"
      ;;
      skip)
        echo "Skipped $paths_out"
      ;;
    esac
    break # Avoid infinite loop
  done
}


mac_sublime_path="$HOME/Library/Application Support/Sublime Text 3/Packages/User"
mac_sublime_pref_path="$mac_sublime_path/Preferences.sublime-settings"
mac_sublime_font_face="Menlo"
mac_sublime_font_size="12"

linux_sublime_path="$HOME/.config/sublime-text-3/Packages/User"
linux_sublime_pref_path="$linux_sublime_path/Preferences.sublime-settings"
linux_sublime_font_face="DejaVu Sans Mono"
linux_sublime_font_size="10"


# Sublime Text 3
if [[ "$(uname)" == "Darwin" ]]; then
  # Mac OS
  do_link "sublime" "$mac_sublime_path"
  cp "$mac_sublime_pref_path.template" "$mac_sublime_pref_path"
  sed -i '' "s/%FONT_FACE%/$mac_sublime_font_face/g" "$mac_sublime_pref_path"
  sed -i '' "s/%FONT_SIZE%/$mac_sublime_font_size/g" "$mac_sublime_pref_path"
else
  # Ubuntu 14.04
  do_link "sublime" "$linux_sublime_path"
  cp "$linux_sublime_pref_path.template" "$linux_sublime_pref_path"
  sed -i "s/%FONT_FACE%/$linux_sublime_font_face/g" "$linux_sublime_pref_path"
  sed -i "s/%FONT_SIZE%/$linux_sublime_font_size/g" "$linux_sublime_pref_path"
fi

# ZSH
# Ubuntu 14.04
do_link "zsh/.zshrc" "$HOME/.zshrc"

# Oh My Zsh
# Ubuntu 14.04
do_link "zsh/.oh-my-zsh/custom/plugins/gnome" "$HOME/.oh-my-zsh/custom/plugins/gnome"
do_link "zsh/.oh-my-zsh/custom/plugins/react-native-extras" "$HOME/.oh-my-zsh/custom/plugins/react-native-extras"
do_link "zsh/.oh-my-zsh/custom/plugins/ffmpeg" "$HOME/.oh-my-zsh/custom/plugins/ffmpeg"
do_link "zsh/.oh-my-zsh/custom/themes/mradionov.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/mradionov.zsh-theme"

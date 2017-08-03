#!/usr/bin/env bash

base=$(pwd)

do_link() {
  local source_rel_path="$1"
  local source_abs_path="$base/$source_rel_path"
  local dest_abs_path="$2"
  local paths_out="'./$source_rel_path' -> '$dest_abs_path'"

  # Just link if it does not exist
  if [[ ! -e "$dest_abs_path" ]]; then
    ls -s "$source_abs_path" "$dest_abs_path"
    echo "Linked $paths_out"
    return 0
  fi

  echo "Action for $paths_out: "
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


# Sublime Text 3
if [[ "$(uname)" == "Darwin" ]]; then
  # Mac OS
  do_link "sublime" "$HOME/Library/Application Support/Sublime Text 3/Packages/User"
else
  # Ubuntu 14.04
  do_link "sublime" "$HOME/.config/sublime-text-3/Packages/User"
fi

# ZSH
# Ubuntu 14.04
do_link "zsh/.zshrc" "$HOME/.zshrc"

# Oh My Zsh
# Ubuntu 14.04
do_link "zsh/.oh-my-zsh/custom" "$HOME/.oh-my-zsh/custom"

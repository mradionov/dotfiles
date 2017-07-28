# Based on robbyrussell theme, but with Node.js version

# Highlights current working directory name
HOST_PROMPT_="%{$fg_bold[cyan]%}%c "

# Highlights current Node.JS version based on NVM
# Example:
# nvm:(v7.9.0)
NVM_PROMPT_="%{$fg_bold[blue]%}nvm:(%{$fg[green]%}\$(nvm current)%{$fg_bold[blue]%})%{$reset_color%} "

# Highlights current Git branch and it's state
# Example:
# git:(master) ✗
GIT_PROMPT="%{$fg_bold[blue]%}\$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}"

# Combines all highlights mentioned above
# Example:
# project nvm:(v7.9.0) git:(master) ✗
PROMPT="$HOST_PROMPT_$NVM_PROMPT_$GIT_PROMPT"

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

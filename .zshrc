
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init zsh)"

export EDITOR='nvim'

op  inject --in-file "${HOME}/dotfiles/secrets.zsh" | while read -r line; do
  eval "$line"
done

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/gilcreque/bin/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/gilcreque/bin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/gilcreque/bin/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/gilcreque/bin/google-cloud-sdk/completion.zsh.inc'; fi


# Load Angular CLI autocompletion.
source <(ng completion script)

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
[ -f ~/.shell/.locale ] && . ~/.shell/.locale

eval "$(starship init zsh)"

export TERM=xterm-256color
export ZSH=$HOME/.oh-my-zsh
export UPDATE_ZSH_DAYS=1

# ZSH_THEME=""
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# =======================================
# zpug section
# =======================================

export ZPLUG_HOME=/usr/local/opt/zplug

[ -f "$ZPLUG_HOME/init.zsh" ] && . $ZPLUG_HOME/init.zsh

# =======================================
# /zpug section
# =======================================

plugins=(git zsh-navigation-tools colored-man-pages themes asdf zsh-autosuggestions zsh-interactive-cd)

export PATH="/usr/local/sbin:$PATH:$HOME/bin":"$HOME/go/bin:$HOME/.pub-cache/bin"

[ -f "$ZSH/oh-my-zsh.sh" ] && . $ZSH/oh-my-zsh.sh

export HOMEBREW_EDITOR=nvim

export GOPATH=/Users/yesworld/go

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

[ -f ~/.shell/.tokens ] && . ~/.shell/.tokens
[ -f ~/.shell/.aliases ] && . ~/.shell/.aliases
[ -f ~/.shell/.functions ] && . ~/.shell/.functions
[ -f ~/.shell/.python ] && . ~/.shell/.python
[ -f ~/.zshrc.private ] && . ~/.zshrc.private

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

# The next line updates PATH for Yandex Cloud CLI.
if [ -f '/Users/yesworld/yandex-cloud/path.bash.inc' ]; then source '/Users/yesworld/yandex-cloud/path.bash.inc'; fi

# The next line enables shell command completion for yc.
if [ -f '/Users/yesworld/yandex-cloud/completion.zsh.inc' ]; then source '/Users/yesworld/yandex-cloud/completion.zsh.inc'; fi

# The next line updates PATH for Yandex Cloud Private CLI.
if [ -f '/Users/yesworld/ycp/path.bash.inc' ]; then source '/Users/yesworld/ycp/path.bash.inc'; fi

eval "$(zoxide init zsh)"
# eval $(thefuck --alias)
eval "$(fzf --zsh)"
# Created by `pipx` on 2022-10-14 11:29:19
export PATH="$PATH:/Users/yesworld/.local/bin"

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
. ~/.asdf/plugins/java/set-java-home.zsh
# . "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

source "/Users/yesworld/.asdf/installs/rust/1.76.0/env"

export DOCKER_CONFIG="$HOME/.docker"
export HELM_REGISTRY_CONFIG="$DOCKER_CONFIG/config.json"


### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
# export PATH="/Users/yesworld/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

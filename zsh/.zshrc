[ -d "$HOME/.shell" ] && for file in $(ls -a "$HOME/.shell"); do source "$HOME/.shell/$file"; done

eval "$(starship init zsh)"

export TERM=xterm-256color
export UPDATE_ZSH_DAYS=1
export ZSH=$HOME/.oh-my-zsh

COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git zsh-navigation-tools colored-man-pages themes zsh-autosuggestions zsh-interactive-cd)

export PATH="/usr/local/sbin:$PATH:$HOME/bin:$HOME/.local/bin"

[ -f "$ZSH/oh-my-zsh.sh" ] && . $ZSH/oh-my-zsh.sh

[ -f ~/.zshrc.private ] && . ~/.zshrc.private

if type brew &>/dev/null; then
  export HOMEBREW_EDITOR=nvim

  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

# The next line updates PATH for Yandex Cloud CLI.
if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi

# The next line enables shell command completion for yc.
if [ -f "$HOME/yandex-cloud/completion.zsh.inc" ]; then source "$HOME/yandex-cloud/completion.zsh.inc"; fi

# The next line updates PATH for Yandex Cloud Private CLI.
if [ -f "$HOME/ycp/path.bash.inc" ]; then source "$HOME/ycp/path.bash.inc"; fi

eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
eval "$(mise activate zsh)"


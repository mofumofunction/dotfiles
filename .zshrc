#
if [[ -t 0 ]]; then
  stty stop undef
  stty start undef
fi

# language
export LANG=ja_JP.UTF-8
export WCWIDTH_CJK_LEGACY=yes

# no beep
setopt nobeep

# VCS
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}+"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}!"



# prompt
autoload -Uz promptinit
promptinit
PROMPT='%(?.%K{008}%F{002}●%f%k.%K{008}%F{001}●%f%k)[%~]
>'


# history
setopt histignorealldups sharehistory

#
setopt no_tify

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -v

# directory color
if [ -f $HOME/.dircolors ]; then
	eval "$(dircolors ~/.dircolors)"
fi
alias ls='ls -F --color=always'

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000

SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=1
#eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


source ~/.zplug/init.zsh

# terminal color
zplug "chrissicool/zsh-256color"

# syntax highlight
zplug "zsh-users/zsh-syntax-highlighting", \
	defer:2

# history 
zplug "zsh-users/zsh-history-substring-search"

# zsh git prompt
zplug "olivierverdier/zsh-git-prompt"


# fuzzy finder
zplug "junegunn/fzf-bin", \
	as:command, \
	rename-to:"fzf", \
	from:gh-r

zplug "junegunn/fzf", \
	as:command, \
	use:bin/fzf-tmux

# enhanced moving
zplug "b4b4r07/enhancd", \
	use:init.sh, \
	on:"junegunn/fzf-bin"

# json processor
zplug "stedolan/jq", \
	from:gh-r, \
	as:command, \
	rename-to:jq

# emoji
zplug "b4b4r07/emoji-cli", \
	on:"stedolan/jq"

# additional completions 
zplug "zsh-users/zsh-completions"

# suggest completionss
zplug "zsh-users/zsh-autosuggestions"

# install plugins
if ! zplug check --verbose; then
	printf "Install? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi

# load and path
zplug load --verbose


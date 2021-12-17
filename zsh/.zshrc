# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="/home/felladog/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="hyperzsh"

#ZSH_THEME="spaceship"
#ZSH_THEME="oxide"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
    #export EDITOR='vim'
fi
#neofetch
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
# my change

# Example aliases
#
# alias for virtual env
#alias flaskenv='source Desktop/Workspace/VirtualEnv/flask_env/bin/activate'
#alias djangoenv='source ~/Desktop/Workspace/VirtualEnv/django_env/bin/activate'
alias mlenv='source ~/anaconda3/bin/activate'
alias deep='source ~/anaconda3/bin/activate && conda activate deep'
alias vim='nvim'
alias activatePip='source .venv/bin/activate'
alias music="~/.ncmpcpp/ncmpcpp-ueberzug/ncmpcpp-ueberzug"
alias dotfiles="cd ~/Desktop/dotfiles"
#alias yt_audio="youtube-dl --add-metadata -i -x --audio-format best"
alias yt_audio="youtube-dl --add-metadata -i -x --audio-format best"
# Download best format available but no better than 720p
alias yt_video="youtube-dl -f 'bestvideo[height<=720]+bestaudio/best[height<=720]'"

# dual Monitor set for intel
alias dual_monitor="bash ~/.screenlayout/fine.sh"
alias single_monitor="bash ~/.screenlayout/single.sh"
# dual Monitor set for nvidia 
alias dual_monitor_n="bash ~/.screenlayout/n_fine.sh"
alias dual_monitor_n_left="bash ~/.screenlayout/n_l_r.sh"
alias single_monitor_n="bash ~/.screenlayout/n_single.sh"

# running the hugo blog server locally
alias blog_serve="cd ~/Documents/org_blog && hugo server -D"

# git alias
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gpush="git push"
alias gpull="git pull"
# git alias end

# don't put duplicate lines or lines starting with space in the history
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export PATH="$HOME/.cargo/bin:$PATH"

autoload -Uz compinit
compinit

#neofetch 
#
#pfetch 
PF_INFO="ascii title os host kernel shell wm uptime memory" PF_ASCII="kiss" pfetch
#/home/felladog/Desktop/Workspace/grepy/gre2.py
#fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PIPENV_VENV_IN_PROJECT=True
export PATH=/home/felladog/.gem/ruby/2.7.0/bin:$PATH

# MPD
export MPD_PORT=6900

# cheat.sh 
function cheat(){ curl cheat.sh/"$@"; }
# Obsidian
function obsidian(){ 
   cd $HOME && ./Obsidian/Obsidian-0.9.3.AppImage;
}
#
function nvidia_active(){ 
    cat "/sys/bus/pci/devices/0000:57:00.0/power/runtime_status"
}
#function

# emacs vterm fix
vterm_printf(){
    if [ -n "$TMUX" ]; then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

# nvm 
load_nvm(){
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}
# eval "$(pyenv init -)"
eval "$(pyenv init --path)"

eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
eval "$(pyenv virtualenv-init -)"

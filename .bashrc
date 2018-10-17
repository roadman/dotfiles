# .bashrc

# if not running interactively, don't do anything
[ -z "$PS1" ] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#PATH=/usr/bin/:$PATH:/sbin/:/usr/local/sbin/
PATH=/usr/local/bin:$PATH
export LANG=ja_JP.UTF-8

export HOMEBREW_CACHE=~/Library/Caches/Homebrew/

PLATFORM=`uname`

# User specific aliases and functions
. ~/.alias_setting
. ~/.alias_setting_ssh
. ~/.alias_setting_git

if [ $PLATFORM = "Darwin" ];then
  . ~/.alias_setting_mac
fi

if [ -f /usr/share/git-core/contrib/completion/git-completion.bash ]; then
  source /usr/share/git-core/contrib/completion/git-completion.bash
fi

## bash_completion
# Check for recent enough version of bash.
bash=${BASH_VERSION%.*}; bmajor=${bash%.*}; bminor=${bash#*.}
if [ $bmajor -gt 3 ] || [ $bmajor -eq 3 -a $bminor -ge 2 ]; then
    if shopt -q progcomp && [ -r /usr/local/etc/bash_completion ]; then
        # Source completion code.
        . /usr/local/etc/bash_completion
    fi
fi
unset bash bmajor bminor

if [ -d $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
  eval "$(rbenv init -)"
fi

if [ -d $HOME/.pyenv ]; then
  export PATH=$HOME/.pyenv/bin:$HOME/.pyenv/shims:$PATH
  eval "$(pyenv init -)"
fi

if [ -d $HOME/.plenv ]; then
  export PATH=$HOME/.plenv/bin:$HOME/.plenv/shims/:$PATH
  eval "$(plenv init -)"
fi

export GOPATH=$HOME/_go
if [ -d $GOPATH ]; then
  PATH=$PATH:$GOPATH/bin
fi

if [ $PLATFORM = "Darwin" ];then
    Z_PATH=`brew --prefix`/etc/profile.d/z.sh
    if [ -f $Z_PATH ]; then
        . $Z_PATH
    fi
elif [ $PLATFORM = "Linux" ];then
    Z_PATH=/etc/profile.d/z.sh
    if [ -f $Z_PATH ]; then
        . $Z_PATH
    fi
fi

# fullpath prompt
export PS1='\w $ '

# .bashrc

# if not running interactively, don't do anything
[ -z "$PS1" ] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#PATH=/usr/bin/:$PATH:/sbin/:/usr/local/sbin/
export LANG=ja_JP.UTF-8

# User specific aliases and functions
. ~/.alias_setting
. ~/.alias_setting_git

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

if [ -d $HOME/.nvm ]; then
  . ~/.nvm/nvm.sh
  nvm use default
fi

if [ -d $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

if [ -d $HOME/.plenv ]; then
  export PATH=~/.plenv/bin:~/.plenv/shims/:$PATH
else
  export XBUILD_HOME=$HOME/xbuild
  if [ -d $XBUILD_HOME ]; then
    export PATH=$PATH:$XBUILD_HOME
  fi
  export PATH=$HOME/local/perl-5.16/bin:$PATH
fi

export GOPATH=$HOME/_go
if [ -d $GOPATH ]; then
  PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
fi

if [ -d $HOME/vimbuild ]; then
    export PATH="$HOME/vimbuild/build/7.4/vim74/src/:$PATH"
fi

if [ -d /usr/local/git-1.9.0 ];then
    export PATH="/usr/local/git-1.9.0/bin/:$PATH"
fi

if [ `uname` = "Darwin" ];then
    Z_PATH=`brew --prefix`/etc/profile.d/z.sh
    if [ -f $Z_PATH ]; then
        . $Z_PATH
    fi
elif [ `uname` = "Linux" ];then
    Z_PATH=/etc/profile.d/z.sh
    if [ -f $Z_PATH ]; then
        . $Z_PATH
    fi
fi


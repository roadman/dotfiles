# .bash_profile
export PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \w\[\033[0;32m\] - [$(git branch 2>/dev/null | grep "^*" | colrm 1 2)\[\033[0;32m\]]\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\]\[\033[0m\] '

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
export PATH="$PATH:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin"

export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"
complete -C '/Users/roadman/.pyenv/shims/aws_completer' aws

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/roadman/google-cloud-sdk/path.bash.inc' ]; then . '/Users/roadman/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/roadman/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/roadman/google-cloud-sdk/completion.bash.inc'; fi

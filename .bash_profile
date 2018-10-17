# .bash_profile
export PS1='\w $ '

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:/sbin:/usr/sbin
export PATH


# The next line updates PATH for the Google Cloud SDK.
source '/Users/roadman/google-cloud-sdk/path.bash.inc'

# The next line enables shell command completion for gcloud.
source '/Users/roadman/google-cloud-sdk/completion.bash.inc'

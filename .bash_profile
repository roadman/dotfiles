# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin:/sbin:/usr/sbin
export PATH


# The next line updates PATH for the Google Cloud SDK.
source '/Users/ochiaiseiji/google-cloud-sdk/path.bash.inc'

# The next line enables shell command completion for gcloud.
source '/Users/ochiaiseiji/google-cloud-sdk/completion.bash.inc'

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
source '/Users/ochiaiseiji/google-cloud-sdk/path.bash.inc'

# The next line enables shell command completion for gcloud.
source '/Users/ochiaiseiji/google-cloud-sdk/completion.bash.inc'

export PATH=$PATH:/Users/ochiaiseiji/azure-cli/bin

source '/Users/ochiaiseiji/azure-cli/lib/azure-cli/az.completion'

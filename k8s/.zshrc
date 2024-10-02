# MACOS zsh rc file

# aliases
alias k=kubectl
# shellprompt with clustername
source "$HOMEBREW_PREFIX/opt/kube-ps1/share/kube-ps1.sh"
PS1='$(kube_ps1)'$PS1
# k8s autocompletion
autoload -Uz compinit
compinit
source <(kubectl completion zsh)

# MACOS zsh rc file
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# aliases
alias k=kubectl
alias docker=podman

# shellprompt with clustername
source "$HOMEBREW_PREFIX/opt/kube-ps1/share/kube-ps1.sh"
PS1='$(kube_ps1)'$PS1

# k8s autocompletion
autoload -Uz compinit
compinit
source <(kubectl completion zsh)
eval "$(ssh-agent -s)"

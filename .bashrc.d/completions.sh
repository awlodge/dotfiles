# Enable auto-complete for key tools

# pipx
eval "$(/home/developer/.local/bin/register-python-argcomplete pipx)"

# Kubernetes &c
source <(/usr/local/bin/kubectl completion bash)
source <(/usr/sbin/helm completion bash)
source <(/usr/local/bin/kubelogin completion bash)

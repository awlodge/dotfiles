# Kubernetes aliases and functions

# Set KUBECONFIG.
export KUBECONFIG=$HOME/.kube/config:$HOME/.kube/kubeconfig-ases:$HOME/.kube/kubeconfig-5g-newk8s:$HOME/.kube/config-ro-mcn

alias kc=kubectl
complete -F __start_kubectl kc
alias kcpods="kubectl get pods"
alias k9s="docker run --rm -it -v /home/developer/.kube/config:/root/.kube/config quay.io/derailed/k9s"

kctrexec() {
  kubectl exec -it -c troubleshooter $1 -- ${@:2}
}

kcpodname() {
  kubectl get pods -o jsonpath="{.items[0].metadata.name}" -l app=$1
}

kclogs() {
  kubectl logs $(kcpodname $1) $1 ${@:2}
}

kcpcap() {
  kubectl cp -c troubleshooter $1:/tmp/tcpdump/$2 $3
}

kc_node_ip() {
  kubectl get nodes -o jsonpath="{.items[0].status.addresses[0].address}"
}

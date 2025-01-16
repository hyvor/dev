cluster-name = hyvor-staging
cluster-endpoint = https://cluster.hyvorstaging.com:6443
server-ip = 91.107.234.247

Notes:
https://datavirke.dk/posts/bare-metal-kubernetes-part-1-talos-on-hetzner/
https://www.notion.so/hyvor/2025-01-talos-kubernetes-17c85601a4ec80a3b9dcff5bf910145b

Comands:

```bash
talosctl gen config \
        --output rendered/n1.yaml                                 \
        --output-types controlplane                               \
        --dns-domain local.$CLUSTER_NAME                          \
        --with-cluster-discovery=false                            \
        --with-secrets secrets.yaml                               \
        --config-patch @patches/cluster-name.yaml                 \
        --config-patch @patches/disable-cni.yaml   \
        --config-patch @patches/allow-controlplane-workloads.yaml \
        hyvor-staging                                             \
        https://cluster.hyvorstaging.com:6443

# apply config to node
talosctl --nodes 91.107.234.247 apply-config --file rendered/n1.yaml --insecure
# config endpoint
talosctl --talosconfig=./talosconfig config endpoint 91.107.234.247
# check dashboard
talosctl --talosconfig=./talosconfig -n 91.107.234.247 dashboard
# bootstrap k8s
talosctl bootstrap --nodes 91.107.234.247 --talosconfig=./talosconfig

# reboot server
talosctl --talosconfig=./talosconfig -n 91.107.234.247 reboot
# kubeconfig (if sets the cluster as the context in local kubectl)
talosctl --talosconfig=./talosconfig -n 91.107.234.247 kubeconfig

kubectl get nodes
# node is NotReady because CNI is not installed
```

### 2. Install CNI

```bash
helm repo add cilium https://helm.cilium.io/

export KUBERNETES_API_SERVER_ADDRESS=cluster.hyvorstaging.com
export KUBERNETES_API_SERVER_PORT=6443
export CLUSTER_DOMAIN=local.cluster.hyvorstaging.com

# https://www.talos.dev/v1.9/kubernetes-guides/network/deploying-cilium/
# https://datavirke.dk/posts/bare-metal-kubernetes-part-2-cilium-and-firewalls/#installing-cilium
helm install                                         \
    cilium                                                      \
    cilium/cilium                                               \
    --version 1.16.5                                          \
    --namespace kube-system                                     \
    --set ipam.mode=kubernetes                                  \
    --set hostFirewall.enabled=true                             \
    --set hubble.relay.enabled=true                             \
    --set hubble.ui.enabled=true                                \
    --set hubble.peerService.clusterDomain=${CLUSTER_DOMAIN}    \
    --set etcd.clusterDomain=${CLUSTER_DOMAIN}                  \
    --set kubeProxyReplacement=true                           \
    --set securityContext.capabilities.ciliumAgent="{CHOWN,KILL,NET_ADMIN,NET_RAW,IPC_LOCK,SYS_ADMIN,SYS_RESOURCE,DAC_OVERRIDE,FOWNER,SETGID,SETUID}" \
    --set securityContext.capabilities.cleanCiliumState="{NET_ADMIN,SYS_ADMIN,SYS_RESOURCE}" \
    --set cgroup.autoMount.enabled=false                        \
    --set cgroup.hostRoot=/sys/fs/cgroup                        \
    --set k8sServiceHost="${KUBERNETES_API_SERVER_ADDRESS}"     \
    --set k8sServicePort="${KUBERNETES_API_SERVER_PORT}"
```

#bin/bash

scp mars@192.168.40.79:/etc/kubernetes/pki/ca.crt .
scp mars@192.168.40.79:/etc/kubernetes/pki/apiserver-kubelet-client.crt .
scp mars@192.168.40.79:/etc/kubernetes/pki/apiserver-kubelet-client.key .


kubectl config set-cluster corgi --server=https://192.168.40.79:6443 --certificate-authority=ca.crt --embed-certs

kubectl config set-credentials corgi --client-key=apiserver-kubelet-client.key --client-certificate=apiserver-kubelet-client.crt --embed-certs=true

kubectl config set-context corgi --cluster=corgi --user=corgi

kubectl config use-context corgi

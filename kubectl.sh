#kubectl cmd
  kubectl get namespaces

  kubectl config set-context $(kubectl config current-context) --namespace=bf
  kubectl port-forward pod/mongodb-replicaset-2 27018:27017
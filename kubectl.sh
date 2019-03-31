#kubectl cmd
  kubectl get namespaces

  kubectl config set-context $(kubectl config current-context) --namespace=bf
  kubectl port-forward pod/mongodb-replicaset-2 27018:27017


#reload gateway
curl https://gist.githubusercontent.com/mnadel/4ddcc0ba07d398b35dad89b4dfdc8308/raw/f2b27f93c17bc4212c0f72174fd871693aeb1661/kcdo > run.sh
sh run.sh -s gateway -n bf nginx -s reload
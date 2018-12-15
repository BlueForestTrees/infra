#!/usr/bin/env bash
#initialiser une machine
apt update
apt upgrade
adduser pi
sudo groupadd docker
sudo usermod -aG sudo pi
sudo usermod -aG docker pi

#docker last, script
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -SsL https://get.docker.com | bash

#docker ubuntu 17
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get install docker-ce=17.03.3~ce-0~ubuntu-xenial

#docker ubuntu
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt-get update && sudo apt-get -y upgrade
sudo apt install --yes docker-ce

#docker debian 8
#Open /etc/default/grub in your favourite text editor
#Add cgroup_enable=memory swapaccount=1 to GRUB_CMDLINE_LINUX
#Run sudo update-grub2 followed by sudo reboot
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

#démarrer rancher
docker run -d --restart=unless-stopped -p 80:80 -p 443:443 -v /var/lib/rancher:/var/lib/rancher --name=rancher-server rancher/rancher --acme-domain ranch.blueforest.org

docker images prune #supprime les images non utilisées ??
docker rm -f $(docker ps -a -q) #supprimer tous les containers
docker rmi $(docker images -q) #supprimer toutes les images



#connection string mongo
#mongodb://admin:7Rlititi@mongodb-replicaset.mongodb-replicaset.svc.cluster.local:27017/BlueForestTrees?replicaSet=rs0&authSource=admin




#mongo
#storage-class
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: local-storage
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer



#mongo from catalog
defaultImage: true
installImage.repository: k8s.gcr.io/mongodb-install
installImage.tag: '0.6'
image.repository: mongo
image.tag: xenial
replicas: '3'
port: '27017'
replicaSetName: rs0
auth.enabled: true
auth.key: fe54fefe92
auth.adminUser: god
auth.adminPassword: tirlititi
persistentVolume.enabled: true
persistentVolume.size: 40Gi
persistentVolume.storageClass: local-storage


apiVersion: v1
kind: PersistentVolume
metadata:
  name: mongo-one
spec:
  capacity:
    storage: 40Gi
  volumeMode: Filesystem
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: local-storage
  local:
    path: /var/lib/mongo
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - one

apiVersion: v1
kind: PersistentVolume
metadata:
  name: mongo-two
spec:
  capacity:
    storage: 40Gi
  volumeMode: Filesystem
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: local-storage
  local:
    path: /var/lib/mongo
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - two


apiVersion: v1
kind: PersistentVolume
metadata:
  name: mongo-three
spec:
  capacity:
    storage: 40Gi
  volumeMode: Filesystem
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: local-storage
  local:
    path: /var/lib/mongo
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - three
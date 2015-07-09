#!/bin/sh



# Helpers
# ------------------------------------------------------------
dockerup-vm-add-port () {
  VBoxManage modifyvm "boot2docker-vm" --natpf1 "$1,tcp,127.0.0.1,$2,,$2";
}

dockerup-vm-delete-port (){
  VBoxManage modifyvm "boot2docker-vm" --natpf1 delete "$1"
}




# Common Runners
# ------------------------------------------------------------
dockerup-run () {
  case $1 in
    'elasticsearch')
      docker run --name=elasticsearch_instance -p 9200:9200 -p 9300:9300 -d elasticsearch
      ;;
    'mongod')
      docker run --name=mongo_instance -p 27017:27017 -d mongo
      ;;
    'rabbitmq')
      docker run --name=rabbitmq_instance -p 5672:5672 -p 15672:15672 -d rabbitmq:3-management
      ;;
    *)
      echo 'No valid run commands found'
      ;;
  esac
}



dockerup-stop () {
  docker stop $1
  docker rm $1
}





dockerup-vm () {
  case $1 in
    'add-ports')
      dockerup-vm-add-port elasticsearch-9200 9200
      dockerup-vm-add-port elasticsearch-9300 9300
      dockerup-vm-add-port mongodb 27017
      dockerup-vm-add-port rabbitmq 5672
      dockerup-vm-add-port rabbitmq-management 15672
      dockerup-vm-add-port web 8200
      ;;
    'delete-ports')
      dockerup-vm-delete-port elasticsearch-9200
      dockerup-vm-delete-port elasticsearch-9300
      dockerup-vm-delete-port mongodb
      dockerup-vm-delete-port rabbitmq
      dockerup-vm-delete-port rabbitmq-management
      dockerup-vm-delete-port web
      ;;
    'remove-users')
      VBoxManage sharedfolder remove boot2docker-vm --name Users
      ;;
  esac
}






# Core
# ------------------------------------------------------------

dockerup () {
  case $1 in
    'nfs')
      sudo nfsd checkexports
      sudo nfsd restart
      ;;
    'down')
      boot2docker down
      unset DOCKER_HOST
      unset DOCKER_CERT_PATH
      unset DOCKER_TLS_VERIFY
      ;;
    'ssh')
      boot2docker ssh
      ;;
    'fix-certs')
      boot2docker ssh sudo /etc/init.d/docker restart
      eval "$(boot2docker shellinit)"
      ;;
    'init')
      eval "$(boot2docker shellinit)"
      ;;
    'open')
      open "http://$(boot2docker ip):$2"
      ;;
    'up')
      boot2docker start --vbox-share=disable
      eval "$(boot2docker shellinit)"
      boot2docker ssh "sudo mkdir -p $DOCKERUP_HOME_USER && sudo mount -t nfs -o noatime,soft,nolock,vers=3,udp,proto=udp,rsize=8192,wsize=8192,namlen=255,timeo=10,retrans=3,nfsvers=3 -v 192.168.59.3:$DOCKERUP_FOLDER_USER $DOCKERUP_HOME_USER"
      boot2docker ssh "sudo mkdir -p $DOCKERUP_HOME_REPO && sudo mount -t nfs -o noatime,soft,nolock,vers=3,udp,proto=udp,rsize=8192,wsize=8192,namlen=255,timeo=10,retrans=3,nfsvers=3 -v 192.168.59.3:$DOCKERUP_FOLDER_REPO $DOCKERUP_HOME_REPO"
      ;;
  esac
}
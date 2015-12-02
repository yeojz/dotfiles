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
    'redis')
      docker run --name=redis_instance -p 6379:6379 -d redis
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
      docker-machine stop
      unset DOCKER_HOST
      unset DOCKER_CERT_PATH
      unset DOCKER_TLS_VERIFY
      ;;
    'ssh')
      docker-machine ssh
      ;;
    'fix-certs')
      docker-machine ssh sudo /etc/init.d/docker restart
      eval "$(docker-machine env)"
      ;;
    'init')
      eval "$(docker-machine env)"
      ;;
    'open')
      open "http://$(docker-machine ip):$2"
      ;;
    'up')
      docker-machine start --vbox-share=disable
      eval "$(docker-machine env)"
      docker-machine ssh "sudo mkdir -p $DOCKERUP_HOME_USER && sudo mount -t nfs -o noatime,soft,nolock,vers=3,udp,proto=udp,rsize=8192,wsize=8192,namlen=255,timeo=10,retrans=3,nfsvers=3 -v 192.168.59.3:$DOCKERUP_FOLDER_USER $DOCKERUP_HOME_USER"
      docker-machine ssh "sudo mkdir -p $DOCKERUP_HOME_REPO && sudo mount -t nfs -o noatime,soft,nolock,vers=3,udp,proto=udp,rsize=8192,wsize=8192,namlen=255,timeo=10,retrans=3,nfsvers=3 -v 192.168.59.3:$DOCKERUP_FOLDER_REPO $DOCKERUP_HOME_REPO"
      ;;
  esac
}
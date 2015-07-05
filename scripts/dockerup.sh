#!/bin/sh



# Helpers
# ------------------------------------------------------------
dockerup-add-port() {
  VBoxManage modifyvm "boot2docker-vm" --natpf1 "$1,tcp,127.0.0.1,$2,,$2";
}

dockerup-delete-port(){
  VBoxManage modifyvm "boot2docker-vm" --natpf1 delete "$1"
}




# Common Runners
# ------------------------------------------------------------
dockerup-run() {
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




# Main
# ------------------------------------------------------------
dockerup () {
  case $1 in
    'down')
      boot2docker down
      unset DOCKER_HOST
      unset DOCKER_CERT_PATH
      unset DOCKER_TLS_VERIFY
      ;;    
    'fix-cert')
      boot2docker ssh sudo /etc/init.d/docker restart
      eval "$(boot2docker shellinit)"
      ;;
    'init')
      eval "$(boot2docker shellinit)"
      ;;
    'open')
      open "http://$(boot2docker ip):$2"
      ;;
    'stopremove')
      docker stop $2
      docker rm $2
      ;;
    'up')
      boot2docker up
      eval "$(boot2docker shellinit)"
      ;;
    'vm-add-ports')
      dockerup-add-port elasticsearch-9200 9200
      dockerup-add-port elasticsearch-9300 9300
      dockerup-add-port mongodb 27017
      dockerup-add-port rabbitmq 5672
      dockerup-add-port rabbitmq-management 15672
      dockerup-add-port web 8200
      ;;
    'vm-delete-ports')
      dockerup-delete-port elasticsearch-9200
      dockerup-delete-port elasticsearch-9300
      dockerup-delete-port mongodb
      dockerup-delete-port rabbitmq
      dockerup-delete-port rabbitmq-management
      dockerup-delete-port web
      ;;
    *)
      docker $1
      ;;
  esac
}
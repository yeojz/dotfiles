#!/bin/sh

sshec2() {
  ssh ec2-user@$2 -i ~/.ssh/$1
}

#! /bin/zsh

projs=(orp-font reptl versionary termpal wunderbar zsh-ansible flickpapr)

root=~/gitcontainer/projects
mkdir -p $root
cd $root
for p in $projs; git clone git@github.com:MicahElliott/$p.git

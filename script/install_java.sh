#!/bin/bash -

#sudo mv jdk1.6.0_34 /usr/lib/jvm/
#sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.6.0_34/bin/java 1

sudo update-alternatives --install /usr/bin/java   java   $(pwd)/java   1
sudo update-alternatives --install /usr/bin/javac  javac  $(pwd)/javac  1
sudo update-alternatives --install /usr/bin/javaws javaws $(pwd)/javaws 1

sudo update-alternatives --set java   $(pwd)/java
sudo update-alternatives --set javac  $(pwd)/javac
sudo update-alternatives --set javaws $(pwd)/javaws

#sudo update-alternatives --config java
#sudo update-alternatives --config javac
#sudo update-alternatives --config javaws

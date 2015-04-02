#!/bin/bash -

#sudo mv jdk1.6.0_34 /usr/lib/jvm/
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.6.0_34/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.6.0_34/bin/javac 1
sudo update-alternatives --install /usr/bin/javaws javaws /usr/lib/jvm/jdk1.6.0_34/bin/javaws 1

#sudo update-alternatives --config java
#sudo update-alternatives --config javac
#sudo update-alternatives --config javaws

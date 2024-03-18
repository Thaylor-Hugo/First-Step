#!/bin/bash

set_locale() {
    apt-get install locales -y
    locale-gen en_US en_US.UTF-8
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
    export LANG=en_US.UTF-8
}

enable_repos() {
    apt-get install software-properties-common -y
    yes '' | add-apt-repository universe
    apt-get update
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null
}

config_ros() {
    echo "source /opt/ros/iron/setup.bash" >> ~/.bashrc
    source ~/.bashrc
}

install_ros() {
    set_locale
    enable_repos
    apt-get update 
    apt-get upgrade -y
    apt-get install ros-dev-tools -y
    apt-get install ros-iron-desktop -y
    config_ros
}
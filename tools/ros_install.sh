#!/bin/bash

set_locale() {
    sudo apt-get install locales -y
    sudo locale-gen en_US en_US.UTF-8
    sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
    export LANG=en_US.UTF-8
}

enable_repos() {
    sudo apt-get install software-properties-common -y >> log/install.log
    sudo yes '' | sudo add-apt-repository universe >> log/install.log
    sudo apt-get update >> log/install.log
    sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
}

config_ros() {
    echo "source /opt/ros/iron/setup.bash" >> ~/.bashrc
    source ~/.bashrc
}

install_ros() {
    set_locale >> log/install.log
    enable_repos
    sudo apt-get update >> log/install.log
    sudo apt-get upgrade -y >> log/install.log
    sudo apt-get install ros-dev-tools -y >> log/install.log
    sudo apt-get install ros-iron-desktop -y >> log/install.log
    config_ros
}
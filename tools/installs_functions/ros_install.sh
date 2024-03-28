#!/bin/bash

#TODO: Make the gum_spin stop blinking

set_locale() {
    $gum_spin "$title" -- sudo apt-get install locales -y
    $gum_spin "$title" -- sudo locale-gen en_US en_US.UTF-8
    $gum_spin "$title" -- sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
    $gum_spin "$title" -- export LANG=en_US.UTF-8
}

enable_repos() {
    $gum_spin "$title" -- sudo apt-get install software-properties-common -y >> log/install.log
    sudo yes '' | sudo add-apt-repository universe >> log/install.log
    $gum_spin "$title" -- sudo apt-get update >> log/install.log
    $gum_spin "$title" -- sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
}

config_ros() {
    echo "source /opt/ros/iron/setup.bash" >> ~/.bashrc
    source ~/.bashrc
}

install_ros() {
    local title="Installing 'ROS2 - Robotics framework'..."
    local gum_spin='gum spin --spinner line --title'
    set_locale >> log/install.log
    enable_repos
    $gum_spin "$title" -- sudo apt-get update >> log/install.log
    $gum_spin "$title" -- sudo apt-get upgrade -y >> log/install.log
    $gum_spin "$title" -- sudo apt-get install ros-dev-tools -y >> log/install.log
    $gum_spin "$title" -- sudo apt-get install ros-iron-desktop -y >> log/install.log
    config_ros
}
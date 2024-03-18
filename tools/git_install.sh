#!/bin/bash

git_email=""
git_name=""

get_git_info() {
    read -p "Enter your git usergit_name: " git_name
    read -p "Enter your git git_email: " git_email
}

configure_git() {
    git config --global user.name "$git_name"
    git config --global user.email "$git_email"
}

configure_ssh() {
    ssh-keygen -t ed25519 -C "$git_email" -f ~/.ssh/id_ed25519
    eval "$(ssh-agent -s)" >> log/install.log
    ssh-add ~/.ssh/id_ed25519 >> log/install.log
    xclip -sel clip < ~/.ssh/id_ed25519.pub
    echo "The SSH key has been copied to the clipboard"
}

install_git() {
    sudo apt-get install git -y >> log/install.log
    get_git_info
    echo "Configuring git..."
    configure_git
    configure_ssh
}
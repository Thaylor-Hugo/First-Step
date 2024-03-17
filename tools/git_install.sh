#!/bin/bash

git_email=""
git_name=""

get_git_info() {
    read -p "Enter your git usergit_name: " git_name
    read -p "Enter your git git_email: " git_email
}

configure_git() {
    git config --global user.git_name "$git_name"
    git config --global user.git_email "$git_email"
}

configure_ssh() {
    ssh-keygen -t ed25519 -C "$git_email"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    xclip -sel clip < ~/.ssh/id_rsa.pub
    echo "The SSH key has been copied to the clipboard"
}

install_git() {
    apt install git -y
    get_git_info
    echo "Configuring git..."
    configure_git
    configure_ssh
}
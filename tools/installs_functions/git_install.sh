#!/bin/bash

git_email=""
git_name=""

get_git_info() {
    git_name=$(gum input --prompt.foreground "#0FF" --prompt "* Enter your git user_name: " --placeholder "your_user_name") 
    git_email=$(gum input --prompt.foreground "#0FF" --prompt "* Enter your git user_email: " --placeholder "your_email@email.com")
}

configure_git() {
    git config --global user.name "$git_name"
    git config --global user.email "$git_email"
}

configure_ssh() {
    ssh-keygen -t ed25519 -C "$git_email" -f ~/.ssh/id_ed25519
    $gum_spin "$title" -- eval "$(ssh-agent -s)" >> log/install.log
    $gum_spin "$title" -- ssh-add ~/.ssh/id_ed25519 >> log/install.log
    xclip -sel clip < ~/.ssh/id_ed25519.pub
    echo "The SSH key has been copied to the clipboard"
}

install_git() {
    local title="Installing 'Git - Version control system'..."
    local gum_spin='gum spin --spinner line --title'
    $gum_spin "$title" -- sudo apt-get install git -y >> log/install.log
    
    local title="Configuring 'Git - Version control system'..."
    gum confirm "Configure Git?"
    if [ $? -eq 0 ]; then
        get_git_info
        configure_git
        configure_ssh
    fi
}
#!/bin/bash

# This script is to be run as root, first priority after creating the VPS
# to set up a new user with sudo privileges, disable root login, and copy the
# SSH keys from root to the newly created user without password, just the SSH keys

apt-get update

echo "New username: "
read -r username

adduser newuser --disabled-password "$username"

adduser "$username" sudo

mv "/home/$username/.bashrc" "/home/$username/.bashrc.bak"
cp "$HOME/.bashrc" "/home/$username/.bashrc"
mkdir "/home/$username/.ssh"
chmod 700 "/home/$username/.ssh"

sudo cp "/root/.ssh/authorized_keys" "/home/$username/.ssh/authorized_keys"

sudo chown -R "$username:$username" "/home/$username/.ssh"

sudo mv "/etc/ssh/sshd_config" "/etc/ssh/sshd_config.bak"
sudo cp "./files/sshd_config" "/etc/ssh/sshd_config"

# sudo systemctl restart sshd

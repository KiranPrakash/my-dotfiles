#!/bin/bash
##################################
# .make.sh
# This script creates sylinks from the home directory to any desired dotfiles 
# in ~/dotfiles
##################################


## Variables

dir=~/dotfiles			# dotfiles directory
olddir=~/dotfiles_old		# backup directory
files="bashrc vimrc inputrc zshrc oh-my-zsh" # list of files/folders to symlink in homedirectory

## Directory Organization
# Create dotfiles_old backup in homedir
echo -n  "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir 
echo "done!"

# Change to the dotfiles directory
echo -n " changing to the $dir directory ..."
cd $dir
echo "done!"

# Move any existing dotfiles in homedir to dotfiles_old directory, then 
# Create symlinks for the homedir to any files in the ~/dotfiles directory specified in $files

for file in $files; do
       echo "Moving any existing dotfiles from ~ to $olddir"
       mv ~/.$file $olddir
       echo "Creating symlink to $file in home directory."
       ln -s $dir/$file ~/.$file
done



## Installation

## Zsh and Oh My Zsh installation
# Test to see if zshell is installed 
install_zsh() {
if [-f /bin/zsh -o -f /usr/bin/zsh ]; then
	# Clone my oh-my-zsh repo from github onfy if it isn't already preseent
	if [[! -d $dir/oh-my-zsh/ ]]; then
		git clone https://github.com/robbyrussell/oh-my-zsh.git

	fi 
	# Set the default shell to zsh if it isn't currently set to zsh
	if [[! $(echo $SHELL) == $(which zsh)]]; then
		chsh -s $(which zsh)
	fi
else
	# If zsh isn't get the platform of the current machine
	platform=$(uname);

	# Check the installed Operating system, and install zsh
	if [[ $platform == 'Linux' ]]; then
		if [[ -f /etc/redhat-release ]]; then
			sudo yum install zsh
			install_zsh
		fi 
		
		if [[ -f /etc/debian_version ]]; then
			sudo apt-get install zsh
			install_zsh
		fi

        # If the platform is OS X
	elif [[ $platform == 'Darwin' ]]; then
		echo "Please install zsh, then re-run the script!"
		exit
	fi
fi 
}
install_zsh

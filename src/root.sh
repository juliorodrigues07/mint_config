#!/bin/bash

## VARIABLES ##

DOWNLOAD_DIRECTORY="/home/$USER/Downloads/Software"

SOFTWARE_TO_INSTALL=(
    virtualbox-qt
    wireshark-qt
    siege
    postgresql
    git
    gimp
    psensor
    texworks
    gnome-sound-recorder
    spotify-client
    cheese
)

## REMOVING APT LOCKS AND UPDATING REPOSITORY ##

function initial_proceedings()
{
    sudo rm /var/lib/dpkg/lock-frontend
    sudo rm /var/cache/apt/archives/lock
    sudo apt update -y
}

## INSTALL .deb PACKAGES ##

function debs_install()
{
    sudo dpkg -i $DOWNLOAD_DIRECTORY/*.deb

}

## INSTALL APT SOFTWARE ##

function apt_install()
{
    sudo apt install vim

    for software_name in ${SOFTWARE_TO_INSTALL[@]}; do
        if ! dpkg -l | grep -q $software_name; then # ONLY INSTALL IF IT'S NOT ALREADY INSTALLED
            apt-get install "$software_name" -y
        else
            echo "[INSTALLED] - $software_name"
        fi
    done
}

## INSTALL FLATPAK PACKAGES ##

function flatpaks_install()
{
    flatpak install flathub com.discordapp.Discord -y
    flatpak install flathub com.obsproject.Studio -y
    flatpak install flathub org.eclipse.Java -y
    flatpak install flathub com.github.reds.LogisimEvolution -y
    flatpak install flathub com.opera.Opera -y
    flatpak install flathub io.github.shiftey.Desktop -y
    flatpak install flathub io.github.mimbrero.WhatsAppDesktop -y
    flatpak install flathub io.github.jeffshee.Hidamari -y
    
    # flatpak install flathub io.atom.Atom #
    # flatpak install flathub com.visualstudio.code #
}

## INSTALL GRUB CUSTOMIZER (PPA) ##

function add_grub()
{
    sudo add-apt-repository ppa:danielrichter2007/grub-customizer && sudo apt-get update && sudo apt-get install grub-customizer
}

## OTHER ## 

# sudo apt install python3 python3-pip build-essential python3-dev #
# python3 -m pip install -U pip #
# python3 -m ensurepip --upgrade #

## CONCLUSION, UPDATING AND CLEANING ##

function finish()
{
    sudo apt update && sudo apt dist-upgrade -y
    sudo apt autoclean
    sudo apt autoremove -y
}

## MAIN ##

initial_proceedings
debs_install
apt_install
flatpaks_install
add_grub
finish

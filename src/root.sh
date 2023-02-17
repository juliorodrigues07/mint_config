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

FLATPAK_TO_INSTALL=(
    com.discordapp.Discord
    com.obsproject.Studio
    org.eclipse.Java
    com.github.reds.LogisimEvolution
    com.opera.Opera
    io.github.shiftey.Desktop
    io.github.mimbrero.WhatsAppDesktop
    io.github.jeffshee.Hidamari
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

    # Proceedings for installing nodejs, npm and parcel #
    curl -fsSL https://deb.nodesource.com/setup_19.x | bash - && apt-get install -y nodejs
    npm install -g parcel-bundler

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
    for flatpak_name in ${FLATPAK_TO_INSTALL[@]}; do
        flatpak install flathub "$flatpak_name" -y
    done
    
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

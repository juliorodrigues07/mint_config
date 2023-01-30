#!/bin/bash

## VARIABLES ##

DOWNLOAD_DIRECTORY="/home/$USER/Downloads/Software"

SOFTWARE_TO_INSTALL=(
    virtualbox-qt
    vim
    wireshark-qt
    siege
    github-desktop
    grub-customizer
    psensor
    texworks
    gnome-sound-recorder
    opera-stable
    spotify-client
    cheese
    sticky
    staruml
    logisim-evolution
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
    for software_name in ${SOFTWARE_TO_INSTALL[@]}; do
        if ! dpkg -l | grep -q $software_name; then # ONLY INSTALL IF IT'S NOT ALREADY INSTALLED
            apt install "$software_name" -y
        else
            echo "[INSTALLED] - $software_name"
        fi
    done

    # sudo apt-get install nvidia-settings #
    # sudo apt-get install git #
}

## INSTALL FLATPAK PACKAGES ##

function flatpaks_install()
{
    flatpak install flathub com.discordapp.Discord -y
    flatpak install flathub com.obsproject.Studio -y
    flatpak install flathub org.eclipse.Java -y
    
    # flatpak install flathub io.atom.Atom #
    # flatpak install flathub com.visualstudio.code #
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
finish

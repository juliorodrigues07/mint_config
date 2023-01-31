#!/bin/bash

## VARIABLES ##

DOWNLOAD_DIRECTORY="$HOME/Downloads/Software"

URL_VS_CODE="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
URL_JFLAP="https://www.jflap.org/jflaptmp/july27-18/JFLAP7.1.jar"
URL_MARS="https://courses.missouristate.edu/kenvollmar/mars/MARS_4_5_Aug2014/Mars4_5.jar"
URL_JETBRAINS="https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.27.2.13801.tar.gz"

LIBS_TO_INSTALL=(
    pandas
    opencv-python
    pycryptodomex
    python-barcode
    pyzbar
    matplotlib
    networkx
    scipy
    numpy
)

## PYTHON LIBRARIES  ##

function libs_install()
{
    pip install -U scikit-learn
    pip install qrcode[pil]

    for lib_name in ${LIBS_TO_INSTALL[@]}; do
        if pip list | grep $lib_name; then # ONLY INSTALL IF IT'S NOT ALREADY INSTALLED
            echo -e "[ALREADY INSTALLED]\n"
        else
            echo -e "[INSTALLING - $lib_name]\n"
            pip install $lib_name
            echo -e ""
        fi
    done

    # pip install pathlib #
    # pip install graphviz #
    # pip install Pillow #
}

## EXTERNAL SOFTWARE DOWNLOAD

function downloading()
{
    mkdir "$DOWNLOADS_DIRECTORY"
    wget -c "$URL_VS_CODE"      -P "$DOWNLOAD_DIRECTORY"
    wget -c "$URL_JFLAP"        -P "$DOWNLOAD_DIRECTORY"
    wget -c "$URL_MARS"         -P "$DOWNLOAD_DIRECTORY"
    wget -c "$URL_JETBRAINS"    -P "$DOWNLOAD_DIRECTORY"
}

## MAIN ##

libs_install
downloading

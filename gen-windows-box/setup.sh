#!/bin/bash

## Colors
##-------
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

# Helper functions
#-----------------
function echoerr()
{
    echo $@ 1>&2
}

# Variables
#----------
IMAGE=image/14393.0.161119-1705.RS1_REFRESH_SERVER_EVAL_X64FRE_EN-US.ISO 
IMAGE_CHECKSUM=70721288bbcdfe3239d8f8c0fae55f1f 

PACKER=./tools/packer

if [ ! -f $IMAGE ]; then
    echoerr "${RED}"
    echoerr "Error: Windows Server Image not found."
    echoerr "       Please see the README.md file for instructions."
    echoerr "${NORMAL}"
    exit 1
fi

if [ ! -f $PACKER ]; then
    echoerr "${RED}"
    echoerr "Error: Packer tool not found."
    echoerr "       Please see the README.md file for instructions."
    echoerr "${NORMAL}"
    exit 1
fi

$PACKER build -var iso_url=$IMAGE \
              -var iso_checksum=$IMAGE_CHECKSUM \
               windows_server_2016_docker.json

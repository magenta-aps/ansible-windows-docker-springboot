#!/bin/bash

IMAGE=image/14393.0.161119-1705.RS1_REFRESH_SERVER_EVAL_X64FRE_EN-US.ISO 
IMAGE_CHECKSUM=70721288bbcdfe3239d8f8c0fae55f1f 

./tools/packer build -var iso_url=$IMAGE \
               -var iso_checksum=$IMAGE_CHECKSUM \
                windows_server_2016_docker.json

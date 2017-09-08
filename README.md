Vagrant-Ansible Example (Windows)
=================================

Example project for running Ansible, inside a newly created windows virtual machine.

## Installation:
### Ubuntu 16.04 (Xenial)

To install vagrant, run:

    apt-get update
    apt-get install vagrant

To install Ansible, run:

    apt-get update
    apt-get install ansible

### Other platforms

Not supported, please figure out a solution yourself, and add it via. a pull
request.

### Common steps

#### Acquiring the Windows Server image

As Windows images are not distribued freely, we need to acquire a Windows ISO
file. This can be done
[here](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2016).

The version we'll use is the 'Windows Server 2016' 180days evaluation.
Acquiring the image will require one to sign-up using email.

The expected image, is named:
* `14393.0.161119-1705.RS1_REFRESH_SERVER_EVAL_X64FRE_EN-US.ISO`

If your result differs, please contact the author of this repository.

Note: The image is 6.5GB, so it may take a while to download.

#### Acquiring packer

To setup the Windows image for Vagrant, we need to utilize `packer`. For Linux,
it can be acquired [here](https://www.packer.io/), or by running:

    curl -O https://releases.hashicorp.com/packer/1.0.4/packer_1.0.4_linux_amd64.zip

And then unzipped using the `unzip` program:

    unzip packer_1.0.4_linux_amd64.zip
    rm packer_1.0.4_linux_amd64.zip

#### Building the Vagrant image

At this point, it's assumed that `packer` has been installed, and that the
Windows Server 2016 ISO image is available.

Place the ISO file, into this folder (along side this README file), and start
the packer build, using:

    ./packer build -var iso_url=14393.0.161119-1705.RS1_REFRESH_SERVER_EVAL_X64FRE_EN-US.ISO \
                   -var iso_checksum=70721288bbcdfe3239d8f8c0fae55f1f \
                    windows_server_2016_docker.json


##ADAD


At this point are environment should be setup, and we can acquire a Windows
virtual-box image, from
[here](https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/).

Note: Make sure to download the 'MSEdge on Win10 (x64) Stable (xx.xxxxx)' with
      platform chosen as 'Vagrant'.

The resulting file should be: 'MSEdge.Win10.RS2.Vagrant.zip', move it to this
folder (along side this script), and extract it using:

    unzip MSEdge.Win10.RS2.VirtualBox.zip
    rm MSEdge.Win10.RS2.VirtualBox.zip
    mv "MSEdge - Win10_preview.box" win10-preview.box

At which point, the virtual machine image, should be available as
`win10-preview.box`. And can now be added to vagrant, using:

    vagrant box add win10-preview.box --name "windows10"

If successfull, you'll see the line:

    ==> box: Successfully added box 'windows10' (v0) for 'virtualbox'!

Now to communicate with windows, we'll utilize
[WinRM (Windows Remote Management)](https://technet.microsoft.com/en-us/library/ff700227.aspx)
instead of SSH, and as such; we need to install a few vagrant plugins:

    vagrant plugin install winrm
    vagrant plugin install winrm-fs

As there seems to be issues with the most recent winrm ruby gem, we'll install
a specific version, instead:

    vagrant plugin install winrm --plugin-version 1.8.1

At which point, the virtual machine is configured to start up.

## Usage:

Simply run `vagrant up`, and wait for the machine to be available.

A virtualbox windows will pop-up and allow you to configure the rest of the
steps, namely the steps required in order to make Windows support Anisble
provisioning.

## Privisioning:



## Usage2:

After this, the machine can be accessed over ssh, using:

    vagrant ssh

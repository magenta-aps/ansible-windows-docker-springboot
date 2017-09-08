Vagrant-Ansible Example (Windows)
=================================

To setup for Windows, we need to generate a Ansible-Ready VirtualBox image.

## Acquiring the Windows Server image

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
    mv packer tools/

#### Building the Vagrant image

At this point, it's assumed that `packer` has been installed (in `tools/**`),
and that the Windows Server 2016 ISO image is available (in `image/**`).

All that's left to do now, is let packer run, and create our Windows virtualbox
image, this can be done by running:

    ./setup.sh

If everything goes as planned, you should end up with the file
`windows_2016_docker_virtualbox.box` next to this README file.

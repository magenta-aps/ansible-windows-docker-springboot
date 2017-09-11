Vagrant-Ansible Example (Windows)
=================================

Example project for running Ansible, inside a newly created windows virtual machine.

## Installation:

Clone this project:

    git clone https://github.com/magenta-aps/vagrant-ansible-example.git


### Ubuntu 16.04 (Xenial)

To install vagrant, run:

    apt-get update
    apt-get install vagrant

To install Ansible, run:

    apt-get update
    apt-get install ansible

Additionally a hypervisor must be installed, the default is virtualbox:

    apt-get update
    apt-get install virtualbox


### MacOS Sierra (10.12.3)

Both vagrant and Ansible can be installed using the [Homebrew](https://brew.sh/) CLI.

Vagrant depends on [Virtualbox](https://www.virtualbox.org/) for MacOS.
To install vagrant and Virtualbox, add the 'cask' tap to homebrew and run:

    brew tap caskroom/cask
    brew install caskroom/cask/virtualbox
    brew install caskroom/cask/vagrant

To install Ansible, run:

    brew install ansible


### Other platforms

Not supported, please figure out a solution yourself, and add it via. a pull
request.


### Common steps

#### Acquiring an Ansible-Ready Windows Server box

Whereas with the Linux example, we had freely available Ansible-Ready machine
images to use, this is not the case for Windows, and as such one must be
generated.

To do so, please refer to the [README.md](gen-windows-box/README.md) file
within the `gen-windows-box` subfolder.

#### Utilizing the Windows Server Box

At this point, it's assumed we have our Windows Server Box 
`gen-windows-box/windows_2016_docker_virtualbox.box`.

We can now register this image with vagrant, by using:

    vagrant box add gen-windows-box/windows_2016_docker_virtualbox.box \
                    --name "windows-server-2016" \
                    --provider virtualbox

If successfull, you'll see the line:

    ==> box: Successfully added box 'windows-server-2016' (v0) for 'virtualbox'!

Now to communicate with windows, we'll utilize
[WinRM (Windows Remote Management)](https://technet.microsoft.com/en-us/library/ff700227.aspx)
instead of SSH, and as such; we need to install a few vagrant plugins:

    vagrant plugin install winrm
    vagrant plugin install winrm-fs

Note: Installing these, may require you to install ´zlib1g-dev`.

As there seems to be issues with the most recent winrm ruby gem, we'll install
a specific version, instead:

    vagrant plugin install winrm --plugin-version 1.8.1

At which point, we're ready to run the virtual machine.

## Provisioning:

To provision the machine using Ansible we need to install `pywinrm`, we can do
this by running:

    apt-get install python-winrm
    pip install --upgrade pywinrm

After this is done, the machine can be provisioned manually by running:

    vagrant provision

After the machine is up, or as a part of the VM setup process, when running:

    vagrant up


## Quirks:
### Installing winrm plugins fails.

It is a known issue, that installing the vagrant plugins, can result in an
issue, alike the one below:

    Installing the "winrm --version '1.8.1'" plugin. This can take a few minutes...
    /usr/lib/ruby/2.3.0/rubygems/specification.rb:946:in `all=':
        undefined method `group_by' for nil:NilClass (NoMethodError)
    ...

The solution to this issue, is running code of the internet:

    sed -i'' "s/Specification.all = nil/Specification.reset/" \
        /usr/lib/ruby/vendor_ruby/vagrant/bundler.rb

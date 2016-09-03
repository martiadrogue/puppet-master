# Puppet Master

Brave Vagrant config for a testing setup with Puppet Master.

A full Puppet test environment that It could be created and destroyed easily.
Automatically provision multiple VMs for Web Development environment with
Vagrant and VirtualBox.

## How to setup

-   Install vagrant using the [installation instructions][vagrant-installation]
-   Clone this repository and run `vagrant up`
-   Put your manifest in *puppet/manifest/site.pp* file
-   Put your modules in *puppet/modules*
-   Change remote's URL `git remote set-url origin https://github.com/vendor/environment`
-   Access `vagrant ssh` and enjoy!

## Included components

-   puppet master
-   puppet agent
-   facter

## NOTES

To change machine's name edit *Vagrantfile*, *shell/hosts* and *shell/network*.

[vagrant-installation]: https://www.vagrantup.com/docs/installation/

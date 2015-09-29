# jhere-devops
This repo contains everything that is necessary to provision boxes, deploy the jhere website(s), etc.

## Before starting

The following is needed (on OSX):

    $ sudo easy_install pip
    $ sudo pip install ansible
    $ sudo pip install dopy
    $ source ./ansible/utils/export_do_credentials.sh

If you have homebrew OSX Ansible can also be installed with:

    $ brew install ansible

## Vagrant box

The setup can be deployed locally on a Vagrant box. It is as simple as running:

    $ vagrant up

in the repository root. Ansible will ask for the password that decrypts the
vault files.

## DigitalOcean

Deploying to DigitalOcean is split in 2 phases.

### Phase 1: spin up a droplet

Ansible supports DigitalOcean as a core module. `droplet.yml` is a playbook that
spins up a droplet onto which everything (node, nginx, ghost) will be deployed.

The playbook uses a module with the Ansible 2 API. Unfortunately Ansible 2 is not
yet available as a stable release – thus is not available via Homebrew.

I decided not to downgrade the playbook to using the module available
for Ansible < 2 because that would use DigitalOcean's v1 API that is going to be
discontinued very soon.

Instead I just downloaded the module from the development branch and put it into
`library` so Ansible gives it priority over the default one.

To spin up the droplet simply do:

    $ cd ansible
    $ ansible-playbook droplet.yml -i inventories/localhosts --ask-vault-pass

Ansible will ask for the password that decrypts the vault files.

The ID of the
SSH key to be used is hardcoded in the playbook, in order to be able to proceed
with *Phase 2* you will need to have the corresponding private key on your
machine.

### Phase 2: configure the Droplet

Once the droplet is up and running, `playbook.yml` can be used to install
everything on it. The playbook relies on a couple of custom roles
(`roles` directory) to install the right version of Node.js via
[n](https://github.com/tj/n) and Ghost.

These roles are written for Ubuntu (they use `apt`),but can probably be easily
generalized to support other Linux distributions.

To run the playbook use the `dohosts` inventory that dynamically fetches the
IP of the droplets using the DigitalOcean API – pretty cool stuff.

To apply the configuration run:

    $ ansible-playbook playbook.yml -i inventories/dohosts --ask-vault-pass

Ansible will ask for the password that decrypts the vault files.

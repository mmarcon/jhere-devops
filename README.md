# jhere-devops
This repo contains everything that is necessary to provision boxes, deploy the jhere website(s), etc.

## Before starting

Before deploying to DigitalOcean the following is needed (on OSX):

    $ sudo easy_install pip
    $ sudo pip install ansible
    $ sudo pip install dopy
    $ source ./ansible/utils/export_do_credentials.sh

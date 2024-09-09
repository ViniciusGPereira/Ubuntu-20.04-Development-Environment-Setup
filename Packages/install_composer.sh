#!/bin/bash

sudo apt update
sudo apt install -y php-cli unzip curl

sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
sudo php -r "unlink('composer-setup.php');"

composer -v

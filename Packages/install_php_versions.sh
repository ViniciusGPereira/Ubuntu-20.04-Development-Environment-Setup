#!/bin/bash

install_php_version() {
  VERSION=$1
  echo "Instalando PHP $VERSION..."
  
  sudo apt update
  sudo apt install -y php$VERSION php$VERSION-cli php$VERSION-fpm php$VERSION-mbstring php$VERSION-xml php$VERSION-zip php$VERSION-curl

  if php$VERSION -v > /dev/null 2>&1; then
    echo "PHP $VERSION instalado com sucesso!"
  else
    echo "Erro ao instalar PHP $VERSION."
    exit 1
  fi
}

sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update

install_php_version 7.4
install_php_version 8.0
install_php_version 8.1
install_php_version 8.2

echo "Configurando PHP 8.1 como a versão padrão..."
sudo update-alternatives --set php /usr/bin/php8.1
sudo update-alternatives --set phpize /usr/bin/phpize8.1
sudo update-alternatives --set php-config /usr/bin/php-config8.1

echo "Versão atual do PHP:"
php -v

echo "Instalação concluída com sucesso!"

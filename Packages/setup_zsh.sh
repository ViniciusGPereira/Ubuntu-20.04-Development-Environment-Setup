#!/bin/bash

echo "Atualizando o sistema..."
sudo apt update && sudo apt upgrade -y

if ! [ -x "$(command -v zsh)" ]; then
  echo "Zsh não encontrado, instalando Zsh..."
  sudo apt install zsh -y
else
  echo "Zsh já está instalado."
fi

ZSH_PATH=$(which zsh) # Verifica o caminho do Zsh
 
echo "Definindo Zsh como shell padrão..."
chsh -s $ZSH_PATH # Define o Zsh como shell padrão

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Instalando Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh já está instalado."
fi

if [ ! -f "$HOME/.zshrc" ]; then
  echo "Criando o arquivo .zshrc..."
  cp /etc/skel/.zshrc ~/
else
  echo "Arquivo .zshrc já existe."
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  echo "Instalando o tema Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
else
  echo "Powerlevel10k já está instalado."
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
  echo "Instalando o plugin zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
else
  echo "zsh-syntax-highlighting já está instalado."
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
  echo "Instalando o plugin zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
else
  echo "zsh-autosuggestions já está instalado."
fi

if ! [ -x "$(command -v fzf)" ]; then
  echo "Instalando fzf..."
  sudo apt install fzf -y
else
  echo "fzf já está instalado."
fi

# Adiciona plugins
echo "Adicionando plugins e tema ao .zshrc..."
sed -i 's/^ZSH_THEME=.*$/ZSH_THEME="powerlevel10k\/powerlevel10k"/' $HOME/.zshrc

sed -i 's/^plugins=(/plugins=(git zsh-syntax-highlighting zsh-autosuggestions sudo fzf/' $HOME/.zshrc

if ! grep -q 'source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme' "$HOME/.zshrc"; then
  echo 'source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme' >> $HOME/.zshrc
fi

echo "Instalação e configuração concluídas."
echo "Você deve fazer logout e login novamente para que o Zsh seja aplicado como shell padrão."

read -p "Deseja reiniciar agora para aplicar as alterações? (s/n): " RESTART
if [[ $RESTART =~ ^[Ss]$ ]]; then
  echo "Reiniciando o sistema..."
  sudo reboot
else
  echo "Por favor, faça logout e login manualmente."
fi

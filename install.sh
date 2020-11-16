#!/bin/sh

# sudo pacman -S neovim git go nodejs npm ccls ttf-nerd-fonts-symbols python-jedi python-neovim gopls xsel
# sudo npm -g install instant-markdown-d
# mkdir -p ~/.config/nvim/autoload

# install vim-plug
# git clone https://github.com/junegunn/vim-plug.git --depth=1
# cp vim-plug/plug.vim ~/.config/nvim/autoload
# rm -rf vim-plug

# install powerline fonts
# git clone https://github.com/powerline/fonts.git --depth=1
# cd fonts
# ./install.sh
# cd ..
# rm -rf fonts

cp init.vim ~/.config/nvim
cp coc-settings.json ~/.config/nvim
# nvim -c PlugInstall

# install coc-ccls
# ln -s ~/.config/coc/extensions/node_modules/coc-ccls/node_modules/ws/lib ~/.config/coc/extensions/node_modules/coc-ccls/lib

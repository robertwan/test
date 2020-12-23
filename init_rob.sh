#/bin/bash
SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)
cd "$SHELL_FOLDER"

if [ "$1" = "idc" ]; then
    echo "init_idc"
    echo "cp ./vimrc_idc ~/"
    mv ~/.vimrc ~/.vimrc_back
    cp ./vimrc_idc ~/.vimrc

    mkdiri -p ~/.vim/autoload/
    cp ./plug.vim ~/.vim/autoload/

    echo "clone plugin"
    git clone https://git::@github.com/mhinz/vim-grepper
    git clone https://git::@github.com/jonathanfilip/vim-lucius
    git clone https://git::@github.com/elzr/vim-json.git
    mkdir -p ~/.vim/plugged
    mv vim-grepper  ~/.vim/plugged
    mv vim-json  ~/.vim/plugged
    mv vim-luciusr  ~/.vim/plugged

    echo "install fzf"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
     ~/.fzf/install

    echo "install plugin"
    vim +PlugInstall +qall; echo $?
fi

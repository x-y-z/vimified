#!/usr/env sh

INSTALLDIR=$HOME

create_symlinks () {
    if [ -f ~/.vim ] || [ -d ~/.vim ]; then
        mv ~/.vim ~/.vim.backup
    fi

    echo "Now, we will create ~/.vim and ~/.vimrc files to configure Vim."
    ln -sfn $INSTALLDIR/.vimified ~/.vim

    if [ -f ~/.vimrc ]; then
        mv ~/.vimrc ~/.vimrc.backup
    fi
    ln -sfn $INSTALLDIR/.vimified/vimrc ~/.vimrc
  }

echo "Welcome friend!"
echo "You are about to be vimified. Ready? Let us do the stuff for you."

which git > /dev/null
if [ "$?" != "0" ]; then
  echo "You need git installed to install vimified."
  exit 1
fi

which vim > /dev/null
if [ "$?" != "0" ]; then
  echo "You need vim installed to install vimified."
  exit 1
fi

if [ ! -d "$INSTALLDIR/.vimified" ]; then
    echo "As we can't find Vimified in the current directory, we will create it."
    git clone https://github.com/x-y-z/vimified.git $INSTALLDIR/.vimified
    create_symlinks
    cd $INSTALLDIR/.vimified

else
    echo "Seems like you already are one of ours, so let's update Vimified to be as awesome as possible."
    cd $INSTALLDIR/.vimified
    git pull origin master
    create_symlinks
fi

if [ ! -d "autoload" ]; then
    echo "Then, we install Vim plug (https://github.com/junegunn/vim-plug)."
	git clone https://github.com/junegunn/vim-plug.git autoload
	#curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		#https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    mkdir -p tmp/backup tmp/swap tmp/undo
fi

if [ ! -f local.vimrc ]; then
  echo "Let's create a 'local.vimrc' file so you have some bundles by default."
  echo "let g:vimified_packages = ['general', 'fancy', 'os', 'coding', 'color']" > 'local.vimrc'
fi

echo "There you are! Welcome in our world."
echo "From now, do not hesitate to ask for help to the people behind Vimified: https://github.com/zaiste/vimified/graphs/contributors"
echo "We welcome any bros/sistas who want to contribute: https://github.com/zaiste/vimified#call-for-help"
echo "Report any issue/need: https://github.com/zaiste/vimified/issues"
echo "At last, and before all, read the documentation: http://zaiste.github.com/vimified/"

echo "Enjoy!"

vim +PlugInstall +qall 2>/dev/null


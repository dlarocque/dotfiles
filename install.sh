#!bin/zsh

dir=~/dotfiles
olddir=~/dotfiles_old
$user=dlarocque

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

echo "Moving any existing dotfiles from ~ to $olddir"
mv ~/.config/nvim/init.vim ~/dotfiles_old/
echo "Creating symlink to ~/dotfiles/init.vim in ~/.config/nvim/init.vim"
ln -s $dir/init.vim ~/.config/nvim/init.vim

# echo "Creating lua directories"
# mkdir $dir/lua
# mkdir $dir/lua/$user
# echo "Creating symlinks to ~/dotfiles/lua/$user/..."
# ln -s $dir/lua/$user/init.lua ~/.config/nvim/lua/$user/init.lua
# ln -s $dir/lua/$user/lsp.lua ~/.config/nvim/lua/$user/lsp.lua


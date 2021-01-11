sh install.sh
cp zshrc ~/.zshrc
cp zshenv ~/.zshenv
cp zprofile ~/.zprofile
cp rossy.zsh-theme ~/.oh-my-zsh/themes/rossy.zsh-theme
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

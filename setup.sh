# Setup the dotfiles on a new machine.
#
# Copies the .xx files into ~, and softlinks the scripts into ~/bin.

if [[ $(basename $PWD) != "dotfiles" ]]
then
  echo Run script from within the 'dotfiles' directory.
  exit 1
fi

backupdir="~/.backupdotfiles"

if [[ -d $backupdir ]]
then
  echo Backup directory already exists. Remove before running script.

# Copy the existing file to the backup directory and copy in the new file.
backup_and_copy()
{
  filename=$1
  if [[ -e ~/$filename ]]
  then
    cp ~/$filename ~/backupdotfiles/$filename
  fi
  cp $filename ~/$filename
}

# Back up the old files
mkdir ~/backupdotfiles

# Copy in the dot files
backup_and_copy .bashrc
backup_and_copy .tmux.conf
backup_and_copy .gitconfig

# Softlink the scripts into ~/bin
for ff in $(ls scripts)
do
  ln -s ${PWD}/scripts/$ff ~/bin/$(echo $ff | sed -e 's/\.sh$//')
done

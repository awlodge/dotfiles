# Setup the dotfiles on a new machine.
#
# Copies the .xx files into ~, and softlinks the scripts into ~/bin.

if [[ $(basename $PWD) != "dotfiles" ]]
then
  echo Run script from within the 'dotfiles' directory.
  exit 1
fi

backupdir="$HOME/.backupdotfiles"

if [[ -d $backupdir ]]
then
  echo Backup directory already exists. Remove before running script.
  exit 1
fi

# Copy the existing file to the backup directory and copy in the new file.
backup_and_copy()
{
  filename=$1
  if [[ -e ~/$filename ]]
  then
    cp ~/$filename $backupdir/$filename
  fi
  cp $filename ~/$filename
}

# Link a script into ~/bin.
softlink_to_bin()
{
  filename=$1
  bin_filename=$(basename $filename | sed -e 's/\.sh$//')
  ln -s $filename ~/bin/$bin_filename
}
export -f softlink_to_bin

# Back up the old files
mkdir $backupdir

# Copy in the dot files
backup_and_copy .bashrc
backup_and_copy .tmux.conf
backup_and_copy .gitconfig

# Softlink the scripts into ~/bin
find scripts -name "*.sh" -exec bash -c 'softlink_to_bin "$@"' bash {} \;

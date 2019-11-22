# dotfiles

======

## Getting Started

```bash
> git clone https://github.com/yeojz/dotfiles.git ~/.dotfiles
# Create a local file.
> touch ~/.dotfiles.local
```

Source any files in the `/config` folder that you want in `.dotfiles.local`

```bash
source ~/.dotfiles/config/npm
source ~/.dotfiles/config/nvm
```

Add the following to your `.zshrc` / `.bashrc` / `.profile`

```bash
if [ -f ~/.dotfiles.local ]; then
  source ~/.dotfiles.local
fi
```

**Note:** All scripts assume the `dotfiles` repository is stored in `~/.dotfiles`

## Others

To install `git-aliases`:

```bash
cat ~/.dotfiles/misc/git-aliases | tee -a ~/.gitconfig
```

To install `homebrew`

```bash
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

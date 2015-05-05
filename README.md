Dotfiles
======



## Getting Started

```bash
$ cd
$ git clone https://github.com/yeojz/dotfiles.git ~/.dotfiles
$ ~/.dotfiles/scripts-setup/setup-zsh.sh
```

You may want to create a `~/.dotfiles.local` to store other aliases.

**Note:** All scripts assume the `dotfiles` repository is stored in `~/.dotfiles`



### `/setup`

|filename | description
|---|---|
| setup-profile | to initialise dotfiles to standard mac `bash` terminal
| setup-zsh | if you have installed `zsh` or `oh-my-zsh`
| notes.md  | List of commands for computer environment setup


### `/bootstrap`

Script to bootstrap all configurations into your shell.


### `/config`

You can just include `index.sh` which should reference all files in the folder.


### `/misc`

Other settings or files which can be included.

**Note:** `git-aliases` is automatically included into `.gitconfig` is setup scripts are used.


### `/scripts`

Helper scripts for various common use.


### `/scripts-env`

These are environment configuration files which you can use with prompts




## Other Helpful References

### SSH

**Generate SSH Key**

```
$ ssh-keygen -t rsa
```


**Copy SSH Key to Server**
```
$ cat ~/.ssh/id_rsa.pub | ssh user@server "mkdir -p ~/.ssh && cat >>  ~/.ssh/authorized_keys"
```


**SSH Config** 
```

Host <SHORTCUT>
	User <USERNAME>
	HostName <IP ADDRESS or DOMAIN NAME>
	IdentityFile <PATH TO KEY FILE>

```


### SCP - File Transfer
**Download (remote -> local)**

```
$ scp user@remote_host:directory/remote_file directory/local_file
```


**Upload (local -> remote)**

```
$ scp local_file user@remote_host:remote_file
```

### Global Git Config
```
$ git config --global color.ui true
$ git config --global user.name "NAME"
$ git config --global user.email "NAME@DOMAIN"
```




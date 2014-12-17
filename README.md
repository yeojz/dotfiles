Dotfiles
======



## Getting Started

```
$ cd
$ git clone https://github.com/yeojz/dotfiles.git dotfiles
```



## Setup Scripts
**folder**: `scripts-setup`

|filename | description
|---|---|
| setup-profile | to initialise dotfiles to standard mac `bash` terminal
| setup-zsh	| if you have installed `zsh` or `oh-my-zsh`
| setup-homebrew	| Homebrew setup (2014/12/18)
| setup-computer	| List of commands for computer environment setup

## Addon Scripts
**folder**: `scripts-addon`


## Non-User Specific Configs
**folder**: `config-generic`

These configuration files should be alright to use AS-IS

## User Specific Configs
**folder**: `config-specific`

These are configuration files you probably want to edit according to your environment


## Miscellaneous
**folder**: `misc`


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




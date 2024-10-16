# dotfiles

GNU Stow is being used for managing dotfiles.

If you want to install my config for specific application, just type:

```zsh
stow [application]
```

For example, you want to install the neovim config:

```zsh
stow nvim
```

Stow will create a symlink in the location the config is supposed to be to the config located in this repository.

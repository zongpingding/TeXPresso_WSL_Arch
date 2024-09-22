# TeXPresso_WSL_Arch
A precompile texpresso in WSL2 base on Arch Linux. ScreenShot:

![TexPresso example](./../texpresso.gif)

## binary and dotfile

Two pre-compile binaries:

* texpresso
* texpresso-tonic

are in the `build` folder,  My Neovim config dotfiles is the folder `nvim`.

### texpresso

copy these 2 binaries to path: `/usr/bin` using command

```shell
cd TeXPresso_WSL_Arch
sudo cp ./build/texpresso /usr/bin
sudo cp ./build/texpresso-tonic /usr/bin
```

### neovim

Put the neovim dotfile folder `nvim`  to the Path:

```shell
% windows
C:\Users\<User name>\AppData\Local\nvim

% linux
~/.config/nvim
```

> If you don't want to use my  neovim config, only want to using the plugin `TeXpresso.vim`, just copy the config:
>
> ```lua
> -- TeXPresso
> {
>   "let-def/texpresso.vim",
> },
> ```
>
> into your `lazyvim` config.

### use it

Then everything is setup,  start your Neovim to use it. For key-bindings see: [texpresso](https://github.com/let-def/texpresso/tree/main).

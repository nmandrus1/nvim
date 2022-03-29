# nvim
My nvim config for rust development mainly

Dependencies: lua, npm, neovim >= 0.6, and any LSP binaries you need

# Installation
Back up your current neovim configuraton

Clone the repository into your `~/.config/nvim/`

`$ git clone https://github.com/nmandrus1/nvim.git ~/.config/nvim`

open neovim and this the ':' to type "PlugInstall"

`:PlugInstall`

Restart neovim and then install any TreeSitter parsers you want, for rust

`:TSInstall rust`

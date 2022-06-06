local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git', 
    'clone', 
    '--depth', 
    '1', 
    'https://github.com/wbthomason/packer.nvim', 
    install_path
  })
  print "Installing packer close and reopen neovim..."
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Use a protected call so we don't error out 
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("require call for \"packer\" failed...")
  return
end

-- Have Packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install Plugins here
return packer.startup(function(use)


  use "wbthomason/packer.nvim" -- packer package manager

  use "nvim-lua/popup.nvim"    -- Popup API from Neovim
  use "nvim-lua/plenary.nvim"  -- Functions used by other plugins


  -- Automatically setup configs after bootstrapping packer
  if packer_bootstrap then
    require("packer").sync()
  end
end)

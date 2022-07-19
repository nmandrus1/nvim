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

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

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


  -- Packer
  use "wbthomason/packer.nvim"      -- packer package manager

  -- Common plugin deps
  use "nvim-lua/popup.nvim"         -- Popup API from Neovim
  use "nvim-lua/plenary.nvim"       -- Functions used by other plugins
  use "windwp/nvim-autopairs"       -- Autopairs

  -- Completion
  use "hrsh7th/nvim-cmp"            -- The completion plugin
  use "hrsh7th/cmp-buffer"          -- Buffer completions
  use "hrsh7th/cmp-path"            -- path completions
  use "hrsh7th/cmp-cmdline"         -- cmdline completions
  use "hrsh7th/cmp-nvim-lsp"        -- lsp completion
  use "saadparwaiz1/cmp_luasnip"    -- snippet completions

  -- LSP
  use "neovim/nvim-lspconfig"       -- enable LSP
  use "williamboman/nvim-lsp-installer"

  -- rust
  use "simrat39/rust-tools.nvim"
  -- java
  use "mfussenegger/nvim-jdtls"

  -- Snippets
  use "L3MON4D3/LuaSnip"            -- Snippet Engine

  -- Colorscheme
  use 'navarasu/onedark.nvim'       -- Onedark colorscheme

  -- Nvim-Tree
  use {
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons", -- optional, for file icon
    },
  }

  -- Comments
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-ui-select.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  -- Buffer Tabs
  use "akinsho/bufferline.nvim"

  -- Status Line
  use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use "folke/which-key.nvim"

  -- Automatically setup configs after bootstrapping packer
  if packer_bootstrap then
    require("packer").sync()
  end
end)

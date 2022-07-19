local opts = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = false, -- default bindings on <c-w>
      nav = false, -- misc bindings to work with windows
      z = false, -- bindings for folds, spelling and others prefixed with z
      g = false, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = '<c-d>', -- binding to scroll down inside the popup
    scroll_up = '<c-u>', -- binding to scroll up inside the popup
  },
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0
  },
  layout = {
    height = { min = 2, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 5, -- spacing between columns
    align = "center", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local wk = require("which-key")
wk.setup(opts)

local keymap = {
  ["e"] = { "<cmd>NvimTreeToggle<CR>",               "Open File Browser" },
  ["f"] = { "<cmd>Telescope find_files<CR>",         "Find Files" },
  ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>",      "Hover (K)" },

  b = {
    name = "Buffer",
    d = { "<Cmd>bd<CR>",     "Close Buffer" },
    f = { "<Cmd>bd!<CR>",    "Force Close Buffer" },
    q = { "<Cmd>%bd|e#<CR>", "Delete All Buffers" },
  },

  g = {
    name = "Goto",
    r = { "<cmd>Telescope lsp_references<CR>",                              "References (gr)" },
    d = { "<cmd>lua vim.lsp.buf.definintion()<CR>",    	                        "Definition (gd)" },
    D = { "<cmd>lua vim.lsp.buf.declaration()<CR>",    	                        "Declaration (gD)" },
    i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", 	                        "Implementation (gi)" },
    p = { "<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<CR>",  "Prev Diagnostic (CTL-p)" },
    n = { "<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<CR>",  "Next Diagnostic (CTL-n)" },
    l = { "<cmd>Telescope diagnostics<CR>",                                 "List Diagnostics (SPC-q)" },
  },
}

wk.register(keymap, { mode = "n", prefix = "<leader>" })

local function code_keymap()
  if vim.fn.has "nvim-0.7" then
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function()
        vim.schedule(CodeRunner)
      end,
    })
  else
    vim.cmd "autocmd FileType * lua CodeRunner()"
  end

  function CodeRunner()
    local bufnr = vim.api.nvim_get_current_buf()
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local keymap_c = {} -- normal key map
    local keymap_c_v = {} -- visual key map

    if ft == "rust" then
      keymap_c = {
        name = "Code",
        a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Actions (SPC-ca)" },
        h = { "<cmd>RustHoverActions<cr>",              "Hover Actions" },
        r = { "<cmd>RustRunnables<cr>",                 "Runnables" },
      }
    elseif ft == "java" then
      keymap_c = {
        name = "Code",
        a = { "<cmd>lua vim.lsp.buf.code_action()<CR>",           "Code Actions (SPC-ca)" },
        o = { "<cmd>lua require'jdtls'.organize_imports()<cr>",   "Organize Imports" },
        v = { "<cmd>lua require('jdtls').extract_variable()<cr>", "Extract Variable" },
        c = { "<cmd>lua require('jdtls').extract_constant()<cr>", "Extract Constant" },
        m = { "<cmd>lua require('jdtls').extract_method()<cr>",   "Extract Method" },
      }
      keymap_c_v = {
        name = "Code",
        a = { "<cmd>lua vim.lsp.buf.code_action()<CR>",               "Code Actions (SPC-ca)" },
        v = { "<cmd>lua require('jdtls').extract_variable(true)<cr>", "Extract Variable" },
        c = { "<cmd>lua require('jdtls').extract_constant(true)<cr>", "Extract Constant" },
        m = { "<cmd>lua require('jdtls').extract_method(true)<cr>",   "Extract Method" },
      }
    end

    if next(keymap_c) ~= nil then
      wk.register(
        { c = keymap_c },
        { mode = "n", silent = true, noremap = true, buffer = bufnr, prefix = "<leader>", nowait = true }
      )
    end

    if next(keymap_c_v) ~= nil then
      wk.register(
        { c = keymap_c_v },
        { mode = "v", silent = true, noremap = true, buffer = bufnr, prefix = "<leader>", nowait = true }
      )
    end
  end
end

code_keymap()

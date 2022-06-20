local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("user.lsp.handlers").setup()

local opts = {
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
}

require'lspconfig'.rust_analyzer.setup{
  on_attach = opts.on_attach,
  capabilities = opts.capabilities,
}

require'lspconfig'.pylsp.setup{
  on_attach = opts.on_attach,
  capabilities = opts.capabilities,
}

require'lspconfig'.clangd.setup{
  on_attach = opts.on_attach,
  capabilities = opts.capabilities,
}

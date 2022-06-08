local opts = {
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
}

require'lspconfig'.rust_analyzer.setup{
  on_attach = opts.on_attach,
  capabilities = opts.capabilities,
}

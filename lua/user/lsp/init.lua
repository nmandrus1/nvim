local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("user.lsp.handlers").setup()

require("user.lsp.rust_lsp")

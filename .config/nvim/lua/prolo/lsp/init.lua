local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("prolo.lsp.lsp-installer")
require("prolo.lsp.handlers").setup()


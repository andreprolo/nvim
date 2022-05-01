local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("prolo.lsp.handlers").on_attach,
		capabilities = require("prolo.lsp.handlers").capabilities,
	}

	 if server.name == "jsonls" then
	 	local jsonls_opts = require("prolo.lsp.settings.jsonls")
	 	opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	 end

	 if server.name == "sumneko_lua" then
	 	local sumneko_opts = require("prolo.lsp.settings.sumneko_lua")
	 	opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	 end

	 if server.name == "pyright" then
	 	local pyright_opts = require("prolo.lsp.settings.pyright")
	 	opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	 end

  if server.name == "omnisharp" then
    local omnisharp_opts = require("prolo.lsp.settings.omnisharp")
    opts = vim.tbl_deep_extend("force", omnisharp_opts, opts)
  end

  if server.name == "elixirls" then
    local elixirls_opts = require("prolo.lsp.settings.elixirls")
    opts = vim.tbl_deep_extend("force", elixirls_opts, opts)
  end

	server:setup(opts)
end)


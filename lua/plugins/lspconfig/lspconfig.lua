return function()
	-- Set up lspconfig.
	local capabilities = require('cmp_nvim_lsp').default_capabilities()
	local lspconfig = require("lspconfig")

	-- clangd
	lspconfig.clangd.setup {
		capabilities = capabilities
	}

	lspconfig.lua_ls.setup {
		capabilities = capabilities
	}

end

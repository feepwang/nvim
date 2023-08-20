return function()
	-- Set up lspconfig.
	local capabilities = require('cmp_nvim_lsp').default_capabilities()
	local lspconfig = require("lspconfig")

	-- c/c++
	require("clangd_extensions").setup()
	lspconfig.clangd.setup {
		capabilities = capabilities
	}

	-- lua
	require("neodev").setup()
	lspconfig.lua_ls.setup {
		capabilities = capabilities
	}

	lspconfig.cmake.setup {
		capabilities = capabilities
	}
end

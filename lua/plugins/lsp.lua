return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugins.lspconfig.binding")()
			require("plugins.lspconfig.lspconfig")()
		end,
		dependencies = {
			{
				"folke/neodev.nvim",
				ft = "lua",
				config = function()
					local lspconfig = require("lspconfig")
					local capabilities = require('cmp_nvim_lsp').default_capabilities()
					-- lua
					require("neodev").setup()
					lspconfig.lua_ls.setup {
						capabilities = capabilities
					}
				end
			},
			{
				"p00f/clangd_extensions.nvim",
				ft = { "c", "cpp" },
				config = function()
					local lspconfig = require("lspconfig")
					local capabilities = require('cmp_nvim_lsp').default_capabilities()
					-- c/c++
					require("clangd_extensions").setup()
					lspconfig.clangd.setup {
						capabilities = capabilities
					}
					-- cmake
					lspconfig.cmake.setup {
						capabilities = capabilities
					}
				end
			}
		}
	}
}

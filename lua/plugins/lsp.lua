local lsp_attach_keymap = function(ev)
	-- Buffer local mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {
		buffer = ev.buf,
		desc = "Go to definition"
	})
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {
		buffer = ev.buf,
		desc = "Go to declaration"
	})
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {
		buffer = ev.buf,
		desc = "Go to implementation"
	})
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, {
		buffer = ev.buf,
		desc = "Go to references"
	})
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf })
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, {
		buffer = ev.buf,
		desc = "Show signature help"
	})
	-- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = ev.buf })
	-- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = ev.buf })
	-- vim.keymap.set('n', '<leader>wl', function()
	--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, { buffer = ev.buf })
	vim.keymap.set('n', '<leader>f', function()
		vim.lsp.buf.format { async = true }
	end, { buffer = ev.buf, desc = "Format" })
	vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, {
		buffer = ev.buf,
		desc = "Go to type definition"
	})
	vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {
		buffer = ev.buf,
		desc = "Code Action"
	})
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {
		buffer = ev.buf,
		desc = "Rename signature"
	})
end

return {
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = { "UIEnter" },
		config = function()
			local lspconfig = require("lspconfig")
			-- lspconfig.lua_ls.setup({})
			lspconfig.clangd.setup({})
			lspconfig.cmake.setup({})
			lspconfig.gopls.setup {}

			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
			vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
			vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
			vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = lsp_attach_keymap,
			})
		end,
	},
	{
		"folke/neodev.nvim",
		dependencies = "neovim/nvim-lspconfig",
		ft = "lua",
		config = function()
			require("neodev").setup({})
			require("lspconfig").lua_ls.setup({
				settings = {
					Lua = {
						complettion = {
							callSnippet = "Replace"
						}
					}
				}
			})
		end
	},
	{
		"p00f/clangd_extensions.nvim",
		dependencies = "neovim/nvim-lspconfig",
		ft = { "c", "cpp" },
		opts = {}
	},
	{
		"olexsmir/gopher.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter"
		},
		ft = { "go" },
		opts = {},
	},
	{
		"simrat39/symbols-outline.nvim",
		lazy = true,
		event = "LspAttach",
		opts = {},
	}
}

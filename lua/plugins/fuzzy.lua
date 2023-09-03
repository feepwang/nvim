local fzf_keybinding = function()
	-- lsp
	vim.keymap.set({ "n", "v", "x" }, "<leader><C-P>", "<cmd>lua require('fzf-lua').files()<CR>",
		{
			desc = "Go to File",
		})
	vim.keymap.set({ "n", "v", "x" }, "<leader><C-T>", "<cmd>lua require('fzf-lua').lsp_live_workspace_symbols()<CR>",
		{
			desc = "Go to Symbol in Workspace",
		})
	vim.keymap.set({ "n", "v", "x" }, "<leader><C-O>", "<cmd>lua require('fzf-lua').lsp_document_symbols()<CR>",
		{
			desc = "Go to Symbol in Buffer",
		})
end

return {
	{
		"ibhagwan/fzf-lua",
		dependencies = "nvim-tree/nvim-web-devicons",
		init = function()
			fzf_keybinding()
		end,
		cmd = { "FzfLua" },
		opts = {},
	},
}

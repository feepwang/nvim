return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-refactor",
			"nvim-treesitter/nvim-treesitter-context",
		},
		build = ":TSUpdate",
		cmd = { "TSUpdateSync" },
		event = { "UIEnter" },
		opts = {
			highlight = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
			},
			indent = {
				enable = true
			},
			refactor = {
				highlight_definitions = {
					enable = true,
					-- Set to false if you have an `updatetime` of ~100.
					clear_on_cursor_move = true,
				},
				highlight_current_scope = {
					enable = false,
				},
			},
			textobjects = {
			},
		},
		config = function(_, opts)
			--  folding
			vim.cmd("set foldmethod=expr")
			vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
			vim.cmd("set nofoldenable")

			require("nvim-treesitter.configs").setup(opts)
		end
	}
}

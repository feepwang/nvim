return {
    {
        "rebelot/kanagawa.nvim",
		init = function()
			vim.opt.termguicolors = true
		end,
        priority = 1000,
        config = function()
			vim.cmd("colorscheme kanagawa")
        end
    }
}

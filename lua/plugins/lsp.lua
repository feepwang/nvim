return {
    {
        "neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("plugins.lspconfig.binding")()
            require("plugins.lspconfig.lspconfig")()
        end,
		dependencies = {
			"folke/neodev.nvim",
			"p00f/clangd_extensions.nvim"
		}
    }
}

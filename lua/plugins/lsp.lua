return {
    {
        "neovim/nvim-lspconfig",
        priority = 100,
        config = function()
            require("plugins.lspconfig.binding")()
            require("plugins.lspconfig.lspconfig")()
        end
    }
}

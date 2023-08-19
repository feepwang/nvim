return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("plugins.lspconfig.binding")()
            require("plugins.lspconfig.lspconfig")()
        end
    }
}

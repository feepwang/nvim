return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("plugins.treesitter.config")()
        end
    }
}

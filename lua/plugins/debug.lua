local plugins = {}

if not vim.g.vscode then
  plugins = {
    {
      "mfussenegger/nvim-dap",
    },
    {
      "rcarriga/nvim-dap-ui",
      dependencies = {
        "mfussenegger/nvim-dap",
      },
      ft = { "c", "cpp", "go" }
    }
  }
end

return plugins

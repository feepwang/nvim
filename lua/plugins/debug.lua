return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		enabled = false,
		config = function()
			local dap = require("dap")
			dap.adapters.lldb = {
				type = 'executable',
				command = '/usr/local/llvm/bin/lldb-vscode',
				name = 'lldb'
			}
		end
	}
}

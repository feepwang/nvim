return {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
      vulncheck = "Imports",
      hints = {
        assignVariableTypes = true,
        parameterNames = true
      }
    },
  }
}


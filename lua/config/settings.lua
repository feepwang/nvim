-- disable inline diagnostic
vim.diagnostic.config({
  sign = {
    severity = vim.diagnostic.severity.WARN
  },
  underline = {
    severity = vim.diagnostic.severity.WARN
  },
  virtual_text = false,
})


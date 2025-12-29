vim.opt.termguicolors = true
vim.opt.background = 'dark'
require("gruvbox").setup({
  overrides = {
    StatusLine = { bg = "#282828" },
    StatusLineNC = { bg = "#282828" },
  },
})
vim.cmd.colorscheme 'gruvbox'

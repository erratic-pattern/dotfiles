-- Defines a read-write directory for treesitters in nvim's cache dir
local parser_install_dir = vim.fn.stdpath("cache") .. "/ts_parsers"
vim.fn.mkdir(parser_install_dir, "p")
vim.opt.runtimepath:append(parser_install_dir)

require'nvim-treesitter.configs'.setup {
  auto_install = true,
  parser_install_dir = parser_install_dir,

  indent = {
    enable = true,
  },

  highlight = {
    enable = true,
  },
}

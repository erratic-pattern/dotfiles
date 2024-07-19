require'nvim-treesitter.configs'.setup {
  auto_install = false, -- managed by nix

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  indent = {
    enable = true,
  },

  highlight = {
    enable = true,
  },
}

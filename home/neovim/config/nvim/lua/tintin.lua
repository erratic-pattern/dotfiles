-- add FileType for TinTin++ command files 
vim.filetype.add({
  extension = {
    tt = "tt",
    tin = "tt"
  },
})

-- load syntax file for TinTin++ command files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tt",
  command = [[
    runtime syntax/tt.vim
    setlocal nosmartindent
    setlocal commentstring=#nop\ %s
  ]],
})


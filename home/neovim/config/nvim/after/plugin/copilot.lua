vim.g.copilot_enabled = false

vim.api.nvim_create_user_command('CopilotToggle', function()
    vim.g.copilot_enabled = not vim.g.copilot_enabled
    vim.cmd('Copilot status')
end, { nargs = 0, })

vim.keymap.set('n', '<leader>cp', '<cmd>CopilotToggle<cr>', { noremap = true })


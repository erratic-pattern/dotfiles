require "ibl".setup({
    indent = {
        char = "▏", -- left aligned
        -- char = "│", -- center aligned
        highlight = { "LineNr" },
    },
    scope = {
        enabled = false,
    },
})

vim.keymap.set('n', '<leader>ig', '<cmd>IBLToggle<CR>')


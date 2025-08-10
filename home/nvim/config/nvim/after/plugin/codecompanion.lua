require("codecompanion").setup({
    adapters = {
        anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
                env = {
                    api_key = "cmd:op read op://Dev/claude-codecompanion.nvim/credential",
                },
            })
        end,
    },
})

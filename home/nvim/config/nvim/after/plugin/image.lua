require("image").setup({
    backend = "kitty",
    kitty_method = "normal",
    -- "magick_rock" or "magick_cli"
    processor = "magick_rock",
    integrations = {
        markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            floating_windows = true,              -- if true, images will be rendered in floating markdown windows
            filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here

            -- find images in obsidian vault
            resolve_image_path = function(document_path, image_path, fallback)
                local obsidian_installed, obsidian = pcall(function() return require 'obsidian' end)
                if obsidian_installed then
                    local obsidian_client = obsidian.get_client()
                    local new_image_path = obsidian_client:vault_relative_path(image_path).filename
                    if vim.fn.filereadable(new_image_path) == 1 then
                        return new_image_path
                    end
                end
                return fallback(document_path, image_path)
            end,
        },
        neorg = {
            enabled = false,
            filetypes = { "norg" },
        },
        typst = {
            enabled = false,
            filetypes = { "typst" },
        },
        html = {
            enabled = false,
        },
        css = {
            enabled = false,
        },
    },
    max_width = nil,
    max_height = nil,
    max_width_window_percentage = 100,
    max_height_window_percentage = 33,
    window_overlap_clear_enabled = true,                                               -- toggles images when windows are overlapped
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
    editor_only_render_when_focused = false,                                             -- auto show/hide images when the editor gains/looses focus
    tmux_show_only_in_active_window = true,                                              -- auto show/hide images in the correct Tmux window (needs visual-activity off)
    hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
})

local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end


-- graphics settings
config.front_end = "WebGpu"
config.webgpu_power_preference = 'HighPerformance'
config.max_fps = 240
config.animation_fps = 30

-- scrollback history
config.scrollback_lines = 10000

-- fonts
config.font = wezterm.font {
    family = 'Monaspace Argon',
    -- enable texture healing & ligatures
    harfbuzz_features = { 'calt', 'liga' },
}
config.font_size = 14

-- theme and appearance
config.color_scheme = 'nightfox'
config.use_fancy_tab_bar = false;
config.hide_tab_bar_if_only_one_tab = true;
config.tab_max_width = 64

-- terminfo settings
config.term = 'wezterm'
config.set_environment_variables = {
    TERMINFO_DIRS = '/home/user/.nix-profile/share/terminfo',
}

-- keyboard
config.enable_kitty_keyboard = true

-- Escape all regex special characters in string
local function regexEscape(str)
    return str:gsub("[%(%)%.%%%+%-%*%?%[%^%$%]]", "%%%1")
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local process_name
    if not tab.active_pane or tab.active_pane.foreground_process_name == '' then
        process_name = '[?]'
    else
        process_name = string.gsub(tab.active_pane.foreground_process_name, '(.*[/\\])(.*)', '%2')
    end

    local subtitle
    -- defer to multiplexer
    if process_name == "tmux" then
        subtitle = tab.window_title
    else
        local HOME_DIR = os.getenv("HOME")
        local current_dir = tab.active_pane.current_working_dir
        if current_dir.scheme == 'file' then
            current_dir = current_dir.file_path
            current_dir = string.gsub(current_dir, regexEscape(HOME_DIR), "~")
            current_dir = string.gsub(current_dir, "/$", "")
        end
        subtitle = current_dir
    end

    local title = string.format(" %s  [%s] %s ", tab.tab_index + 1, process_name, subtitle)
    return { { Text = title }, }
end)


-- Only perform the given action when not in fullscreen mode, otherwise passthru to running program
local function action_unless_fullscreen(action, key)
    return wezterm.action_callback(function(win, pane)
        if pane:is_alt_screen_active() then
            -- a program is full screen, passthrough the key
            win:perform_action(wezterm.action.SendKey { key = key, mods = 'NONE' }, pane)
        else
            -- do the action
            win:perform_action(action, pane)
        end
    end)
end

config.keys = {
    { key = 'PageUp',   mods = 'NONE', action = action_unless_fullscreen(wezterm.action.ScrollByPage(-0.5), 'PageUp') },
    { key = 'PageDown', mods = 'NONE', action = action_unless_fullscreen(wezterm.action.ScrollByPage(0.5), 'PageDown') },
}

return config

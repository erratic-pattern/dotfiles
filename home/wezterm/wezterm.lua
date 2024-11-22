local wezterm = require 'wezterm'
local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.front_end = "WebGpu"
config.webgpu_power_preference = 'HighPerformance'

config.font = wezterm.font 'Fira Code'
config.font_size = 13
-- disable ligatures
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

config.color_scheme = 'nightfox'

config.use_fancy_tab_bar = false;
config.hide_tab_bar_if_only_one_tab = true;

config.set_environment_variables = {
    TERMINFO_DIRS = '/home/user/.nix-profile/share/terminfo',
    WSLENV = 'TERMINFO_DIRS',
}
config.term = 'wezterm'

config.tab_max_width = 64

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

return config

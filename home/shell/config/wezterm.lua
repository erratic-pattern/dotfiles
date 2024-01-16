local wezterm = require 'wezterm'
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font = wezterm.font 'Fira Code'
config.font_size = 14

config.color_scheme = 'tokyonight_moon'

config.use_fancy_tab_bar = false;
config.hide_tab_bar_if_only_one_tab = true;

config.set_environment_variables = {
  TERMINFO_DIRS = '/home/user/.nix-profile/share/terminfo',
  WSLENV = 'TERMINFO_DIRS',
}
config.term = 'wezterm'

return config

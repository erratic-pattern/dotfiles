{ ... }:
{
  # add nvim config file
  xdg.configFile."nvim/after/plugin/influxql.lua" = {
    source = ./config/nvim/after/plugin/influxql.lua;
  };

}

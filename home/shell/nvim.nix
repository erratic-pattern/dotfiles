{ pkgs, lib, ... }: {
  # install packer plugin manager
  home.file.".local/share/nvim/site/pack/packer/start/packer.nvim" = {
      recursive = true;
      source = builtins.fetchGit {
          url = "https://github.com/wbthomason/packer.nvim";
          ref = "master";
          rev = "ea0cc3c59f67c440c5ff0bbe4fb9420f4350b9a3";
      };
  };

  # add nvim config directory
  xdg.configFile."nvim/" = {
    source = ./config/nvim;
    recursive = true;
  };

  #  add .vimrc for vim-compatible config that's also sourced by nvim/init.lua
  home.file.".vimrc" = {
    source = ./config/vimrc;
  };

  programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      withNodeJs = true; # used by copilot
      extraPackages = with pkgs; [
          ripgrep # used by telescope
          rustup # for rust-analyzer 
          luarocks # for Lua LSP
      ];
  };

  home.activation.packerSync = 
    lib.hm.dag.entryAfter ["writeBoundary"] ''
      ${pkgs.neovim}/bin/nvim --headless -u ./.config/nvim/lua/plugins.lua -c 'autocmd User PackerComplete quitall' -c 'PackerSync' 2> /dev/null
    '';
}  


{ pkgs, ... }: {
  # install packer plugin manager
  home.file.".local/share/nvim/site/pack/packer/start/packer.nvim" = {
      recursive = true;
      source = builtins.fetchGit {
          url = "https://github.com/wbthomason/packer.nvim";
          ref = "master";
          rev = "ea0cc3c59f67c440c5ff0bbe4fb9420f4350b9a3";
      };
  };

  programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      withNodeJs = true; # used by copilot
      extraPackages = with pkgs; [
          tree-sitter # for autoinstalling parsers
          ripgrep # used by telescope
          rustup # for rust-analyzer 
          luarocks # for Lua LSP
      ];
  };
}  


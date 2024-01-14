{ pkgs, ... }:
let
  # unstable = import <nixos-unstable> {};
  # installs a vim plugin from git with a given tag / branch
  # pluginGit = ref: repo: unstable.vimUtils.buildVimPlugin {
  #   pname = "${lib.strings.sanitizeDerivationName repo}";
  #   version = ref;
  #   src = builtins.fetchGit {
  #     url = "https://github.com/${repo}.git";
  #     ref = ref;
  #   };
  # };
  # always installs latest version
  # plugin = pluginGit "HEAD";

in {
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
          ripgrep # used by telescope
          rustup # for rust-analyzer 
          luarocks # for Lua LSP
      ];
  };
}  


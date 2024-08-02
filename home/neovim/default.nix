{ pkgs, nixvim, vim-tintin, ... }:
{
  imports = [
    nixvim.homeManagerModules.nixvim
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # add nvim config directory
  xdg.configFile."nvim/" = {
    source = ./config/nvim;
    recursive = true;
  };

  # add vim-tintin syntax file to nvim config directory
  xdg.configFile."nvim/syntax/tt.vim" = {
    source = "${vim-tintin}/syntax/tt.vim";
  };

  # add .vimrc for vim-compatible config that's also sourced by nvim/init.lua
  home.file.".vimrc" = {
    source = ./config/vimrc;
  };

  programs.nixvim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    # TODO: uncomment for future Linux setup
    # clipboard = {
    # providers = lib.optionalAttrs pkgs.stdenvNoCC.isLinux {
    #   # Required for copying to the system clipboard
    #   wl-copy.enable = wayland;
    #   xclip.enable = !wayland;
    # };
    # };

    withNodeJs = true; # used by copilot
    extraPackages = with pkgs; [
      ### LSP servers
      taplo-lsp # TOML
      yaml-language-server # YAML
      nodePackages.typescript-language-server # Typescript/Javascript
      nodePackages.vscode-json-languageserver # JSON
      python3Packages.python-lsp-server # Python
      sumneko-lua-language-server # Lua
      jsonnet-language-server #Jsonnet
      gopls # Go
      # Bash
      shellcheck
      nodePackages.bash-language-server
      # Nix
      nixd
      nixpkgs-fmt
      # Rust
      rust-analyzer

      ### Telescope dependencies
      ripgrep
      fd
    ];
    extraPlugins = with pkgs.vimPlugins; [

      # Status line, buffer line, tab line
      lualine-nvim

      # Fuzzy Finding / Search
      plenary-nvim
      nvim-web-devicons
      telescope-nvim
      telescope-ui-select-nvim

      # File Exploration and Manipulation
      nvim-tree-lua
      oil-nvim

      # General Editing
      vim-sleuth
      comment-nvim
      undotree
      # beacon-nvim

      # Git integrations
      gitsigns-nvim
      vim-fugitive
      vim-rhubarb

      # GitHub integrations
      nvim-unception
      # gist-nvim
      octo-nvim

      # AI Overlords
      copilot-vim

      # Color Schemes
      tokyonight-nvim
      nightfox-nvim
      nord-nvim
      zenbones-nvim
      # apprentice
      tender-vim
      gruvbox
      palenight-vim
      melange-nvim
      srcery-vim
      onehalf
      jellybeans-nvim
      iceberg-vim
      seoul256-vim
      kanagawa-nvim
      oceanic-next

      # Autocompletion
      nvim-cmp
      cmp-nvim-lsp
      cmp-path
      cmp-buffer
      cmp-cmdline
      cmp-git

      # LSP
      nvim-lspconfig

      # Syntax
      nvim-treesitter-textobjects
      {
        plugin = nvim-treesitter.withPlugins
          (plugins: with plugins; [
            tree-sitter-json
            tree-sitter-toml
            tree-sitter-yaml
            tree-sitter-rust
            tree-sitter-python
            tree-sitter-nix
            tree-sitter-cmake
            tree-sitter-make
            tree-sitter-cpp
            tree-sitter-c
            tree-sitter-bash
            tree-sitter-readline
            tree-sitter-lua
            tree-sitter-css
            tree-sitter-typescript
            tree-sitter-javascript
            tree-sitter-tsx
            tree-sitter-html
            tree-sitter-http
            tree-sitter-markdown
            tree-sitter-markdown-inline
            tree-sitter-regex
            tree-sitter-vim
            tree-sitter-vimdoc
            tree-sitter-query
            tree-sitter-llvm
            tree-sitter-go
            tree-sitter-zig
            tree-sitter-sql
            tree-sitter-proto
            tree-sitter-dockerfile
            tree-sitter-jsonnet
          ]);
      }
    ];
  };
}


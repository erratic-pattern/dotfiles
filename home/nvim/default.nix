{ pkgs, lib, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # add nvim config directory
  xdg.configFile."nvim/" = {
    source = ./config/nvim;
    recursive = true;
  };

  # add .vimrc for vim-compatible config that's also sourced by nvim/init.lua
  home.file.".vimrc" = {
    source = ./config/vimrc;
  };

  programs.neovim = {
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

    # fixes issue with rust-analyzer in user PATH shadowing the one here
    # https://github.com/nix-community/home-manager/issues/4330#issuecomment-2391709770
    extraWrapperArgs = [
      "--prefix"
      "PATH"
      ":"
      "${lib.makeBinPath [ pkgs.rust-analyzer ]}"
    ];

    extraPackages =
      with pkgs;
      [
        ### LSP servers
        marksman # Markdown
        taplo-lsp # TOML
        yaml-language-server # YAML
        nodePackages.typescript-language-server # Typescript/Javascript
        nodePackages.vscode-json-languageserver # JSON
        python3Packages.python-lsp-server # Python
        sumneko-lua-language-server # Lua
        jsonnet-language-server # Jsonnet
        gopls # Go
        buf # Protobuf
        # Bash
        shellcheck
        nodePackages.bash-language-server
        # Nix
        nixd
        nixfmt-rfc-style
        # Rust
        rust-analyzer

        ### Telescope dependencies
        ripgrep
        fd

        ### dependencies for image-nvim
        # imagemagick # ImageMagick CLI
      ]
      ++ lib.optionals stdenv.hostPlatform.isDarwin [
        ### obsidian-nvim dependencies on MacOS
        pngpaste
      ];

    # magick Lua rock for image-nvim
    extraLuaPackages = ps: with ps; [ magick ];

    plugins = with pkgs.vimPlugins; [

      # Status line, buffer line, tab line
      lualine-nvim

      # Fuzzy Finding / Search
      plenary-nvim
      nvim-web-devicons
      telescope-nvim
      telescope-ui-select-nvim
      telescope-oil

      # File Exploration and Manipulation
      nvim-tree-lua
      oil-nvim

      # General Editing
      vim-sleuth
      indent-blankline-nvim
      undotree

      # Spell Checking
      vim-dirtytalk

      # Git integrations
      gitsigns-nvim
      vim-fugitive
      vim-rhubarb

      # GitHub integrations
      nvim-unception
      # gist-nvim
      octo-nvim

      # Obsidian Integration
      obsidian-nvim

      # Display images
      image-nvim

      # Notifications / Progress Messages
      fidget-nvim

      # Vim Learning tools
      precognition-nvim

      # AI Overlords
      copilot-vim

      # Color Schemes
      nightfox-nvim
      oceanic-next
      palenight-vim
      onehalf
      tokyonight-nvim
      rose-pine
      # zenbones-nvim
      # apprentice # no nix package
      iceberg-vim
      nord-nvim
      tender-vim
      catppuccin-nvim
      melange-nvim
      kanagawa-nvim
      # jellybeans-nvim
      seoul256-vim
      srcery-vim
      gruvbox
      dracula-nvim

      # Autocompletion
      nvim-cmp
      cmp-nvim-lsp
      cmp-path
      cmp-buffer
      cmp-cmdline
      cmp-git

      # LSP
      nvim-lspconfig

      # Syntax Hightlighting
      nvim-colorizer-lua
      nvim-treesitter-textobjects
      {
        plugin = nvim-treesitter.withPlugins (
          plugins: with plugins; [
            tree-sitter-bash
            tree-sitter-c
            tree-sitter-cmake
            tree-sitter-cpp
            tree-sitter-css
            tree-sitter-dockerfile
            tree-sitter-gitcommit
            tree-sitter-gitignore
            tree-sitter-go
            tree-sitter-html
            tree-sitter-http
            tree-sitter-javascript
            tree-sitter-json
            tree-sitter-jsonnet
            tree-sitter-llvm
            tree-sitter-lua
            tree-sitter-make
            tree-sitter-markdown
            tree-sitter-markdown-inline
            tree-sitter-nix
            tree-sitter-proto
            tree-sitter-python
            tree-sitter-query
            tree-sitter-readline
            tree-sitter-regex
            tree-sitter-rust
            tree-sitter-sql
            tree-sitter-toml
            tree-sitter-tsx
            tree-sitter-typescript
            tree-sitter-vim
            tree-sitter-vimdoc
            tree-sitter-yaml
            tree-sitter-zig
          ]
        );
      }
    ];
  };
}

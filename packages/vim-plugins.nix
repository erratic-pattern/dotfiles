# collection of local vim/neovim plugins
{ prev, vimUtils, vimPlugins, fetchFromGitHub, fetchpatch, ... }:
{
  telescope-oil =
    vimUtils.buildVimPlugin {
      pname = "telescope-oil.nvim";
      version = "2024-12-01";
      src = fetchFromGitHub {
        owner = "albenisolmos";
        repo = "telescope-oil.nvim";
        rev = "1aaeb1a38a515498f1435d3d308049310b9a5f52";
        sha256 = "sha256-vZKtlNW2T+1ONyFSuv16d9KZgut5g3DHblKbHnUTCkw=";
      };
      buildInputs = [ vimPlugins.telescope-nvim ];
      meta.homepage = "https://github.com/albenisolmos/telescope-oil.nvim";
    };

  obsidian-nvim = prev.vimPlugins.obsidian-nvim.overrideAttrs
    {
      patches = [
        # https://github.com/epwalsh/obsidian.nvim/pull/774
        (fetchpatch
        {
          name = "bosvik:bug/NewFromTemplate-respect-id";
          url = "https://patch-diff.githubusercontent.com/raw/epwalsh/obsidian.nvim/pull/774.patch";
          hash = "sha256-LoIy0Bbl1aJJQrsFOaoHX1n9UXtKSdENYgjlAWGZhz0=";
        })
        # https://github.com/epwalsh/obsidian.nvim/pull/804 
        (fetchpatch
        {
          name = "sirjager:feat/extending-file-support";
          url = "https://patch-diff.githubusercontent.com/raw/epwalsh/obsidian.nvim/pull/804.patch";
          hash = "sha256-A2EOBsKfDObgWsAU0Fmg9UQ8r8xqNnp5exm0I0Vylg4=";
        })
        # https://github.com/epwalsh/obsidian.nvim/pull/709
        (fetchpatch
        {
          name = "cristobalgvera:feature/provide-note-in-substitutions";
          url = "https://patch-diff.githubusercontent.com/raw/epwalsh/obsidian.nvim/pull/709.patch";
          hash = "sha256-0gow3/7PpWguifx4KJh94UbB7cAo/mIGxKZoh2XT1SE=";
        })
        # https://github.com/epwalsh/obsidian.nvim/pull/817
        # (fetchpatch
        # {
        #   name = "adamtajti:blink-support";
        #   url = "https://patch-diff.githubusercontent.com/raw/epwalsh/obsidian.nvim/pull/817.patch";
        #   hash = "";
        # })
      ];
    };
}


# collection of local vim/neovim plugins
{ pkgs, fetchFromGitHub, ... }:
{
  telescope-oil =
    pkgs.vimUtils.buildVimPlugin {
      pname = "telescope-oil.nvim";
      version = "2024-12-01";
      src = fetchFromGitHub {
        owner = "albenisolmos";
        repo = "telescope-oil.nvim";
        rev = "1aaeb1a38a515498f1435d3d308049310b9a5f52";
        sha256 = "sha256-vZKtlNW2T+1ONyFSuv16d9KZgut5g3DHblKbHnUTCkw=";
      };
      buildInputs = [ pkgs.vimPlugins.telescope-nvim ];
      meta.homepage = "https://github.com/albenisolmos/telescope-oil.nvim";
    }
  ;
}

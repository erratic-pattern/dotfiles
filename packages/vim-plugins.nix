# collection of local vim/neovim plugins
{
  vimUtils,
  vimPlugins,
  fetchFromGitHub,
  ...
}:
{
  telescope-oil = vimUtils.buildVimPlugin {
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

  vim-dirtytalk = vimUtils.buildVimPlugin {
    pname = "vim-dirtytalk";
    version = "2024-04-14";
    src = fetchFromGitHub {
      owner = "psliwka";
      repo = "vim-dirtytalk";
      rev = "aa57ba902b04341a04ff97214360f56856493583";
      sha256 = "sha256-azU5jkv/fD/qDDyCU1bPNXOH6rmbDauG9jDNrtIXc0Y=";
    };
    meta.homepage = "https://github.com/psliwka/vim-dirtytalk";
  };
}

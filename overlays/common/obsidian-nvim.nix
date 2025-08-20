inputs: final: prev: {
  vimPlugins = prev.vimPlugins.extend (
    final: prev: {
      obsidian-nvim = prev.obsidian-nvim.overrideAttrs {
        nvimSkipModules = [
          "obsidian.pickers._fzf"
          "minimal"
        ];
      };
    }
  );
}

self: super: {
  ruff = super.ruff.overrideAttrs (oldAttrs: {
    checkFlags = [];
  });
}

self: super: {
  # patch discord-rpc to fix build failure with clang, see https://github.com/discord/discord-rpc/pull/387
  discord-rpc = super.discord-rpc.overrideAttrs
    (previous: {
      version = "3.4.0";
      src = super.fetchFromGitHub {
        owner = "erratic-pattern";
        repo = "discord-rpc";
        rev = "master";
        hash = "sha256-nAWr7eW8EzKW3ji60cFTcv0NqZXaCrQRoyEidajtlDo=";
      };
    });
}


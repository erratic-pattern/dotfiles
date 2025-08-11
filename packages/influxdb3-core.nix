{
  lib,
  rustPlatform,
  fetchFromGitHub,
  protobuf,
  python3,
  git,
  ...
}:
let
  rev = "9436baba87e0768c86f59ba95298be983f4946e0";
in
rustPlatform.buildRustPackage rec {
  pname = "influxdb3-core";
  version = "3.3.0";

  src = fetchFromGitHub {
    owner = "influxdata";
    repo = "influxdb";
    inherit rev;
    sha256 = "sha256-C/jNeulY5e5mKtsiekR7ukNvDlDb1vLBJrK4aVOM494="; # Replace after running nix-prefetch-github
  };

  cargoHash = "sha256-Dr7KwXBz7v3/yRDvyUcuqoezSkko4cl3wGS6l6X/nLM="; # Replace after running nix-build

  # Set GIT_HASH env variables for build.rs
  # env = {
  #   GIT_HASH = rev;
  #   GIT_SHORT_HASH = lib.substring 0 7 rev;
  # };
  # GIT_HASH = rev;
  # GIT_SHORT_HASH = lib.substring 0 7 rev;
  preBuild = ''
    export GIT_HASH=${rev}
    export GIT_SHORT_HASH=${lib.substring 0 7 rev}
  '';

  nativeBuildInputs = [
    protobuf
    python3
    git
  ];

  meta = with lib; {
    description = "InfluxDB 3 Core - high-performance time series database";
    homepage = "https://github.com/influxdata/influxdb";
    license = with licenses; [
      mit
      asl20
    ];
    maintainers = with maintainers; [ yourGithubUsername ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}

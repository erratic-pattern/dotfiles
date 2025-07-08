{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      duckdb
      python313
    ]
    ++ (with python313Packages; [ pandas ]);
}

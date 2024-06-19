{ pkgs, ... }: {
  home.packages = (with pkgs; [
    python311
    poetry
    ruff
  ] ++ (with python311Packages; [
    python-dateutil
  ]));
  home.sessionVariables = {
    PYTHONPATH = "${pkgs.python3}/${pkgs.python3.sitePackages}";
  };
}

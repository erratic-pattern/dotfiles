{ pkgs, ... }:
let
  pythonPackages = pkgs.python311Packages;
in
let
  evennia = with pythonPackages; let
    anything = buildPythonPackage
      rec {
        pname = "anything";
        version = "0.2.1";
        # format = "wheel";
        format = "pyproject";

        propagatedBuildInputs = [
          setuptools
        ];
        dependencies = [
        ];

        src = pkgs.fetchPypi {
          inherit pname version;
          hash = "sha256-rT+RErqw4Jp9BgilQTkyW/Jk4vOEcedsGU/npk+q0Zw=";
        };
        # src = pkgs.fetchPypi {
        #   inherit pname version format;
        #   dist = "py3";
        #   python = "py3";
        #   platform = "any";
        #   hash = "sha256-KzDEmM3IzToPP8iHxIBxmCMtDtefND24UyPxuIPMWXY=";
        # };
      };
    model-mommy = buildPythonPackage
      {
        pname = "model-mommy";
        version = "2.0.0";
        format = "wheel";

        propagatedBuildInputs = [
          setuptools
        ];
        dependencies = [
        ];

        src = pkgs.fetchurl {
          url = "https://files.pythonhosted.org/packages/0b/71/ae2850e1a466020e10f218ef5a917bed1812b50f9f0fd794330cb0475e70/model_mommy-2.0.0.tar.gz";
          hash = "sha256-PTMq/OlBxX8ZkPRbCDuhMlK6dPzRrkP9BH5a96cPsxI=";
        };
      };
    lunr =
      let
        hatch-fancy-pypi-readme =
          buildPythonPackage

            {
              pname = "hatch-fancy-pypi-readme";
              version = "24.2.0.dev0";
              # format = "wheel";
              format = "pyproject";

              propagatedBuildInputs = [
                setuptools
                hatchling
              ];
              dependencies = [
              ];
              src = pkgs.fetchurl {
                url = "https://files.pythonhosted.org/packages/b4/c2/c9094283a07dd96c5a8f7a5f1910259d40d2e29223b95dd875a6ca13b58f/hatch_fancy_pypi_readme-24.1.0.tar.gz";
                hash = "sha256-RN0jnxp3m53PjryUAaYR/X9+PhRXjc8iwmXfr3wVFLg=";
              };
            };
      in
      buildPythonPackage rec {
        pname = "lunr";
        version = "0.7.0.post1";
        # format = "wheel";
        format = "pyproject";

        propagatedBuildInputs = [
          setuptools
          hatchling
          hatch-fancy-pypi-readme
        ];
        dependencies = [
        ];

        src = pkgs.fetchPypi {
          inherit pname version;
          hash = "sha256-APyY9ZtTx+4PY4TJnmwJnyjLdG7P/4ZbvDcFw+kQS9o=";
        };
        # src = pkgs.fetchPypi {
        #   inherit pname version format;
        #   dist = "py3";
        #   python = "py3";
        #   platform = "any";
        #   hash = "sha256-KzDEmM3IzToPP8iHxIBxmCMtDtefND24UyPxuIPMWXY=";
        # };
      };
  in
  buildPythonPackage
    rec {
      pname = "evennia";
      version = "4.1.1";
      # format = "wheel";
      format = "pyproject";

      propagatedBuildInputs = [
        setuptools

      ];
      dependencies = [
        django
        twisted
        pytz
        djangorestframework
        pyyaml
        django-filter
        django-sekizai
        inflect
        autobahn
        lunr
        simpleeval
        uritemplate
        jinja2
        tzdata
        pydantic
        mock
        model-mommy
        anything
        black
        isort
        parameterized
      ];

      src = pkgs.fetchPypi {
        inherit pname version;
        hash = "sha256-T0PpozrmPwPIP/N1xVPO8atJ6pp14bxbrNOGMLctmXc=";
      };
      # src = pkgs.fetchPypi {
      #   inherit pname version format;
      #   dist = "py3";
      #   python = "py3";
      #   platform = "any";
      #   hash = "sha256-KzDEmM3IzToPP8iHxIBxmCMtDtefND24UyPxuIPMWXY=";
      # };
    };
in
{
  home.packages = (with pkgs;
    [
      python311
      poetry
      ruff
      evennia
    ] ++ (with pythonPackages; [
      pip
      python-dateutil
    ]));
  home.sessionVariables = {
    PYTHONPATH = "${pkgs.python3}/${pkgs.python3.sitePackages}";
  };
}

{
  lib,
  stdenv,
  python3Packages,
  fetchFromGitHub,
  ...
}:

with python3Packages;

buildPythonApplication rec {
  pname = "claude-monitor";
  version = "3.1.0";

  src = fetchFromGitHub {
    owner = "Maciek-roboblog";
    repo = "Claude-Code-Usage-Monitor";
    rev = "v${version}";
    hash = "sha256-v5ooniaN1iVerBW77/00SpghIVE1j8cl2WENcPnS66M=";
  };

  pyproject = true;

  # Build dependencies from pyproject.toml's build-system.requires
  build-system = [
    setuptools
    wheel
  ];

  # Runtime dependencies from pyproject.toml's dependencies
  dependencies = [
    numpy
    pydantic
    pydantic-settings
    pyyaml
    pytz
    rich
  ]
  ++ lib.optionals (pythonOlder "3.11") [
    tomli
  ]
  ++ lib.optionals stdenv.hostPlatform.isWindows [
    tzdata
  ];

  # Optional dependencies for development and testing
  # optional-dependencies = {
  #   dev = [
  #     black
  #     isort
  #     mypy
  #     pre-commit
  #     ruff
  #     build
  #     twine
  #   ];
  #   test = [
  #     pytest
  #     pytest-asyncio
  #     pytest-benchmark
  #     pytest-cov
  #     pytest-mock
  #     pytest-xdist
  #   ];
  # };

  # Test dependencies using pytestCheckHook as recommended
  nativeCheckInputs = [
    pytestCheckHook
    pytest
    pytest-asyncio
    pytest-benchmark
    pytest-cov
    pytest-mock
    pytest-xdist
  ];

  # Set HOME to a writable directory during tests
  # so they can reference ~/.claude and ~/.claude-monitor
  preCheck = ''
    export HOME=$NIX_BUILD_TOP
  '';

  # Skip Windows-specific test
  pytestFlagsArray = [
    "-k 'not test_get_timezone_windows'"
  ];

  pythonImportsCheck = [ "claude_monitor" ];

  meta = with lib; {
    description = "Beautiful real-time terminal monitoring tool for Claude AI token usage with advanced analytics and predictions";
    homepage = "https://github.com/Maciek-roboblog/Claude-Code-Usage-Monitor";
    changelog = "https://github.com/Maciek-roboblog/Claude-Code-Usage-Monitor/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "claude-monitor";
    platforms = platforms.all;
  };
}

{ pkgs ? import <nixpkgs> { } }:

let
  pythonPackages = pkgs.python3Packages;
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    # Flutter dependencies
    flutter
    cocoapods
    xcodebuild

    # Python and Django dependencies
    python3
    pythonPackages.django
    pythonPackages.djangorestframework
    pythonPackages.pip
    pythonPackages.virtualenv

    # Development tools
    git
    # nodejs
    # yarn
    
    # VSCode extensions (optional)
    vscode-extensions.dart-code.flutter
    vscode-extensions.ms-python.python
  ];

  shellHook = ''
    # Set up Python virtual environment
    # python -m venv .venv
    # source .venv/bin/activate
    # pip install -r requirements.txt

    # Set up Flutter
    # flutter pub get

    # Set up environment variables
    export FLUTTER_ROOT=${pkgs.flutter}
    export PATH=$PATH:$FLUTTER_ROOT/bin
    # export PUB_CACHE=~/.pub-cache

    echo "Flutter and Python/Django development environment is ready!"
  '';

  # Environment variables
  LANG = "en_US.UTF-8";
  FLUTTER_ROOT = "${pkgs.flutter}";
}

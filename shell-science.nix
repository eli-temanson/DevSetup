{ pkgs ? import <nixpkgs> {} }:

let
  root = pkgs.root;
  eigen = pkgs.eigen;
  clang-tools = pkgs.clang-tools;
in
pkgs.mkShell {
  buildInputs = [
    root
    eigen
    clang-tools
    pkgs.cmake
    pkgs.premake5
  ];

  shellHook = ''
    export CPLUS_INCLUDE_PATH=${eigen}/include/eigen3:$CPLUS_INCLUDE_PATH
    export ROOT_INCLUDE_PATH=${root}/include:$ROOT_INCLUDE_PATH
    export LD_LIBRARY_PATH=${root}/lib:$LD_LIBRARY_PATH

    echo "ROOT CERN, Eigen, and Clang LSP environment ready!"
  '';

  # Use Clang as the default compiler
  CC = "clang";
  CXX = "clang++";

  # Add Clang-specific flags
  NIX_CFLAGS_COMPILE = "-stdlib=libc++";
  NIX_LDFLAGS = "-stdlib=libc++";
}

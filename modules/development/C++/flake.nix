{
  description = "A basic flake with a shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.cmake
            pkgs.clang_16
            pkgs.clang-tools_16
            pkgs.clang-analyzer
            pkgs.doctest
          ];
          shellHook = ''
            export CMAKE=${pkgs.cmake}/bin/cmake
            export CLANG=${pkgs.clang}/bin/clang
            export CLANGD=${pkgs.clang-tools}/bin/clangd
          '';
        };
      }
    );
}

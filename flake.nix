{
  description = "Beeware tutorial devshell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        #
        devShells.default = pkgs.mkShell {
          # Packages
          packages = [
            pkgs.python3Full
            pkgs.rustup
            pkgs.maturin
          ];

          # Environment Variables
          env = let
            PROJECT_ROOT = builtins.getEnv "PWD";
          in {
            VIRTUAL_ENV = PROJECT_ROOT + "/.venv";
            PYTHONPATH = PROJECT_ROOT;
            MYPYPATH = PROJECT_ROOT;
          };

          shellHook = ''
            which python
          '';

          inputsFrom = [];
        };
      }
    );
}

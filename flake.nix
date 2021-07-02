{
  description = "A simple auditing program to check the state of a machine given an ansible.yml playbook";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    poetry2nix-src.url = "github:nix-community/poetry2nix";
  };

  outputs = { self, nixpkgs, flake-utils, poetry2nix-src }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ poetry2nix-src.overlay ];
        };
        p2n = pkgs.poetry2nix;
        devEnv = p2n.mkPoetryEnv {
          projectDir = ./.;
        };
        buildEnv = p2n.mkPoetryEnv {
          projectDir = ./.;
        };
        proj-devDeps = with pkgs; [
          poetry
          python38
          python38Packages.setuptools
        ];
      in
      rec {
        devShell = pkgs.mkShell {
          nativeBuildInputs = [ devEnv ]
            ++ proj-devDeps;
        };
      });
}

{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-23.11.tar.gz") { } }:

pkgs.mkShell {
  # nativeBuildInputs is usually what you want -- tools you need to run
  nativeBuildInputs = with pkgs; [
    nixpkgs-fmt
    nil
    docker-client
    gnumake

    # Ruby development
    ruby_3_2
    bundler
    rubyPackages.solargraph
  ];

  hardeningDisable = [ "all" ];
}

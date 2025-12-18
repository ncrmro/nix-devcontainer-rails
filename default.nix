{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-23.11.tar.gz") { } }:

pkgs.stdenv.mkDerivation {
  name = "nix-devcontainer-rails";
  src = ./.;
  
  buildInputs = with pkgs; [
    ruby_3_2
    bundler
  ];
  
  buildPhase = ''
    export HOME=$TMPDIR
    bundle config set --local path 'vendor/bundle'
    bundle install
  '';
  
  checkPhase = ''
    bundle exec rspec
  '';
  
  installPhase = ''
    mkdir -p $out
    cp -r . $out/
  '';
  
  doCheck = true;
}

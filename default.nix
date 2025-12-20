{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-23.11.tar.gz") { } }:

let
  gems = pkgs.bundlerEnv {
    name = "nix-devcontainer-rails-gems";
    ruby = pkgs.ruby_3_2;
    gemdir = ./.;
  };
in
pkgs.stdenv.mkDerivation {
  name = "nix-devcontainer-rails";
  src = ./.;
  
  buildInputs = [ gems gems.wrappedRuby ];
  
  buildPhase = ''
    # Nothing to build, gems are already available
  '';
  
  checkPhase = ''
    export HOME=$TMPDIR
    ${gems}/bin/bundle exec rspec
  '';
  
  installPhase = ''
    mkdir -p $out
    cp -r . $out/
  '';
  
  doCheck = true;
}

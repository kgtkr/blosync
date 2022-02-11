{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in
      with pkgs; rec {
        packages = {
          sqldef = callPackage ./sqldef.nix { };
        };
        devShell = mkShell {
          packages = [
            (rust-bin.fromRustupToolchainFile ./rust-toolchain.toml)
            sqlx-cli
            cargo-make
            packages.sqldef
          ] ++ lib.optionals stdenv.isDarwin [
            libiconv
            darwin.apple_sdk.frameworks.SystemConfiguration
            darwin.apple_sdk.frameworks.CoreFoundation
            darwin.apple_sdk.frameworks.Security
          ] ++ lib.optionals stdenv.isLinux [
            openssl
          ];
        };
      }
    );
}

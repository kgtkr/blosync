{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgsArgs = {
          inherit system overlays;
        };
        pkgs = import nixpkgs pkgsArgs;
        darwinCompatiblePkgs = import nixpkgs (pkgsArgs // {
          system = if system == "aarch64-darwin" then "x86_64-darwin" else system;
        });
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
            darwinCompatiblePkgs.cargo-watch
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

{
  description = "Nix flake for zmk keyboard config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:

    flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlays = [
          (self: super: rec { })
        ];
        pkgs = import nixpkgs { inherit overlays system; };
        zmk-viewer = pkgs.buildGoModule rec {

          pname = "zmk-viewer";
          version = "1.5.0";

          src = pkgs.fetchFromGitHub {
            owner = "MrMarble";
            repo = "zmk-viewer";
            rev = "v${version}";
            hash = "sha256-gyu0bf5XUaBWxtpoLeFIbPGqPPD2bJjEeyjfLdFy0hA=";
          };

          vendorHash = "sha256-G0p0VYCHpQE/htq452bWUZbFCxAkvwk76paiG+i72cg=";

          meta = with pkgs.lib; {
            description = "ZMK keymap visualization";
            homepage = "https://github.com/MrMarble/zmk-viewer";
            license = licenses.mit;
          };
        };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            just
            zmk-viewer
          ];

          shellHook = ''
            echo "Ready to build firmware"
          '';
        };
      }
    );
}

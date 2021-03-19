{
  pkgs ? import <nixpkgs> {}
}:

{
  default = import ./default.nix { inherit pkgs; };
  # Doesn't cross-compile for now...
  #cross-aarch64 = import ./default.nix { pkgs = pkgs.pkgsCross.aarch64-multiplatform; };
}

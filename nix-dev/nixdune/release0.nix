let
  pkgs = import <nixpkgs> { };
in
{
  mysimple = pkgs.callPackage ./mysimple.nix { };
}

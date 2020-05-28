
let
  overlay = self: super: {
    ocamlPackages = super.ocamlPackages.overrideScope' (self: super: {
      ocaml = super.ocaml.override { flambdaSupport = true; };
    });
  };
  pkgs = import <nixpkgs> {
    overlays = [ overlay ];
  };
in
{
  mysimple = pkgs.callPackage ./mysimple.nix { };
}

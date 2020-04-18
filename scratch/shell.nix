let
  pkgs = import <nixpkgs> {};
in
pkgs.mkShell {
  buildInputs = with pkgs.ocamlPackages; [
    ocaml
    utop
  ];
  propagatedBuildInputs = with pkgs.ocamlPackages; [
    batteries
    base
    core
    findlib
    merlin
    utop
  ];
}

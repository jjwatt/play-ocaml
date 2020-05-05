let
  pkgs = import <nixpkgs> {};
in
pkgs.mkShell {
  propagatedBuildInputs = (with pkgs; [
  	smlnj
  ]) ++ (with pkgs.ocamlPackages; [
    batteries
    base
    ocaml
    findlib
    merlin
    ocp-indent
    utop
  ]);
}

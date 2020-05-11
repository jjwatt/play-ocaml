let
  pkgs = import <nixpkgs> {};
in
pkgs.mkShell {
  propagatedBuildInputs = (with pkgs; [
  	smlnj
  ]) ++ (with pkgs.ocamlPackages; [
    base
    core
    ocaml
    findlib
    merlin
    ocp-indent
    utop
  ]);
}

let
  pkgs = import <nixpkgs> {};
in
pkgs.mkShell {
  buildInputs = with pkgs.ocamlPackages; [
    ocaml
  ];
  propagatedBuildInputs = (with pkgs; [
  	smlnj
  ]) ++ (with pkgs.ocamlPackages; [
    base
    core
    dune
    findlib
    merlin
    ocp-indent
    utop
  ]);
}

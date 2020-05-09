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
    core_bench
    dune
    findlib
    merlin
    ocp-indent
    qcheck
    qtest
    result
    # sequence
    utop
  ];
}

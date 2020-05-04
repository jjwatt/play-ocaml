let
  pkgs = import <nixpkgs> {};
in
pkgs.mkShell {
  propagatedBuildInputs = with pkgs; [
  	smlnj
  ];
}

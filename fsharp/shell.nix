let
  pkgs = import <nixpkgs> {};
in
pkgs.mkShell {
  propagatedBuildInputs = with pkgs; [
	dotnetCorePackages.sdk_3_1
  	fsharp
  ];
}

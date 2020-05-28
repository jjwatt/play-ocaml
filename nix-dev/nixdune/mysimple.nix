{ ocamlPackages }:
ocamlPackages.buildDunePackage rec {
  pname = "a-simple-ocaml-project";
  version = "0.1.0";
  # minimumOcamlVersion = "4.09";

  src = ./.;
  buildInputs = with ocamlPackages; [ utop ];
  propogatedBuildInputs = with ocamlPackages;
    [ base cohttp-lwt core findlib dune ];
}

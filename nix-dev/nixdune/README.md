# Let's try a slightly different strategy with Nix

Here, I want to try a project in the style of "haskell-nix", 
where I specify a release.nix, projectname.nix with an actual
mkDerivation, etc. And, we should specify dune and ocaml
as dependencies (possibly opam, too, but that might be tougher).

And, we'd pin the nixpkgs like haskell-nix does. And, we'd
specify the dependencies in the nix files, but also let dune
find them so that during development we can build with dune.


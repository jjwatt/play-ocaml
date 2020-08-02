# play-ocaml

My sandbox for (S)ML, Ocaml and ReasonML.

Any of my code is covered by the GPL3 in LICENSE.

Any submodule is covered by whatever LICENSE is in their repo.

## Nix

I have most projects here working with nix and nixpkgs, using shell.nix and,
optionally, direnv and lorri. This is working out well for me right now with
direnv-mode in emacs.

### OPAM in Nix

opam and Nix don't play too well together. Until recently, I couldn't seem to
get opam to work at all. Nix *does* have great ocaml support and has most stuff
in its ocamlPackages attrs, but not at the same versions and probably not
everything from opam. It's bothered me that I'm "stuck" on ocaml 4.09 on nix,
even if it's just theoretical and I haven't needed to upgrade or get stuff
that's in opam and not on Nix.

Being stubborn about it, I've tried `opam2nix` and it didn't seem to work.
Today, I found this blog post, though:

https://hardentoo.org/posts/2019-07-10-install-ocaml.html

Strangely enough, the commands under `Another try` seemed to work for me to
install stuff in opam under nix. I'll copy the commands here in case that page goes away.

```shell
nix-env -iA nixos.opam
nix-env -iA nixos.unzip
nix-shell -p ocaml --run 'opam init'
eval `opam config env`
nix-shell -p ocaml --run 'opam switch create 4.10.0'
eval `opam config env`
opam update
nix-shell -p hello --run 'opam install ocamlbuild'
```

I changed the commands to do the `opam switch create` and use `4.10.0` instead
of `4.07.0` In the blog post, the author does the "environemnt setup" before the
above commands, and they do the `switch create` there, too. For me, I did it
inside the call to `nix-shell -p ocaml` as above, and that seemed to work out
for me. I've even been able to fire up utop from the same terminal and checked
all my paths and they seem alright. I haven't yet done anything to integrate
this method with emacs, though. Oh, that reminds me--probably an important
point--I said `n` to any/all questions from `opam` about modifying my shell
profile! So, that means I would need to manually run `eval $(opam env)` which is
actually exactly what I want. Otherwise, things would be gnarly if/when I run
stuff in nix shells instead of relying on the opam stuff because it would always
put the opam stuff in my environment, but the nix shells are supposed to be
self-contained and reproducible, so I absolutely don't want the opam
environment/paths setup when I'm using shell.nix.

Again, I still haven't decided on or tried any creative ways to go back and
forth between them.

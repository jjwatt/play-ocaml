(dolist
    (var
     (car
      (read-from-string (shell-command-to-string "opam config env --sexp"))))
     (setenv (car var) (cadr var)))

(getenv "PATH")

(add-to-list 'exec-path "/home/wattenbarger/.opam/4.07.0/bin")

((nil .
      ((eval . (add-hook 'tuareg-mode-hook #'(lambda() (setq mode-name "🐫"))))))
 (tuareg-mode .
              ((merlin-command . "ocamlmerlin")
               ;;(utop-command . "utop -emacs -init ~/.ocamlinit")
               (eval . (prettify-symbols-mode)))))

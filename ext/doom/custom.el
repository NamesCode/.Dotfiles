(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("7e1843c2f0f4f65e75d05ed2d436d685fa9b56355f80c54294dc6448617f7061" "f0c554275d18038bbbf8708c55fb50ae001fa7aaff6d421a7e2bc6b8b5bc33e0" "319f25a1644bd1d95d6a7197f76fa5abe7ec595f58c769f263e514b75ec3316c" "8f4976a03c25fad5075d8dfea0cdbff53a39a30d8b5e61b34f26791d865906d7" "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" "104d4874a373bf08eaf371e948ae0d9152b4fd7fe53b7461c77b11d6c0e24a31" "e914ee9905f6deed7247d72fdb355bd3fa014bf83e8099e7a0afbcc0051efb82" "180641b59315dcbf610ac82acbd80eb878ed969ba57a371345b4c58cff35d309" default))
 '(ignored-local-variable-values
   '((eval when
      (and
       (buffer-file-name)
       (not
        (file-directory-p
         (buffer-file-name)))
       (string-match-p "^[^.]"
                       (buffer-file-name)))
      (unless
          (require 'package-recipe-mode nil t)
        (let
            ((load-path
              (cons "../package-build" load-path)))
          (require 'package-recipe-mode)))
      (unless
          (derived-mode-p 'emacs-lisp-mode)
        (emacs-lisp-mode))
      (package-build-minor-mode)
      (setq-local flycheck-checkers nil)
      (set
       (make-local-variable 'package-build-working-dir)
       (expand-file-name "../working/"))
      (set
       (make-local-variable 'package-build-archive-dir)
       (expand-file-name "../packages/"))
      (set
       (make-local-variable 'package-build-recipes-dir)
       default-directory)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

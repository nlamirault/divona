;;
;; Slime configuration
;;

(let ((filename "~/quicklisp/slime-helper.el"))
  (when (file-exists-p filename)
    (load (expand-file-name filename))))
(setq inferior-lisp-program "/usr/bin/sbcl")

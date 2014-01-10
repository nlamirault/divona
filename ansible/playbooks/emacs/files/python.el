;;
;; Python configuration
;;

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)

(elpy-enable)


(add-hook 'python-mode-hook (lambda () (setq fill-column 79)))
(add-hook 'write-file-hooks 'delete-trailing-whitespace)
(add-hook 'python-mode-hook
	  (lambda ()
	    (unless (eq buffer-file-name nil) (flymake-mode 1))
	    (local-set-key [f2] 'flymake-goto-prev-error)
	    (local-set-key [f3] 'flymake-goto-next-error)))
;; (add-hook 'python-mode-hook
;; 	  (lambda ()
;; 	    (local-set-key (kbd "C-c t") 'tox-current-test)
;; 	    (local-set-key (kbd "C-c c") 'tox-current-class)))

(define-key python-mode-map (kbd "C-c t") 'tox-current-test)
(define-key python-mode-map (kbd "C-c c") 'tox-current-class)

;; enable pep8
;; sudo pip install pep8
(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
	   (local-file (file-relative-name
			temp-file
			(file-name-directory buffer-file-name))))
      (list "pep8" (list "--repeat" local-file))))

  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.py\\'" flymake-pylint-init)))

(defun my-flymake-show-help ()
  (when (get-char-property (point) 'flymake-overlay)
    (let ((help (get-char-property (point) 'help-echo)))
      (if help (message "%s" help)))))

(add-hook 'post-command-hook 'my-flymake-show-help)

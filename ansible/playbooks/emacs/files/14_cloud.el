;; Cloud configuration
;;
;; Copyright (c) Nicolas Lamirault <nicolas.lamirault@gmail.com>
;;

;;; Code:

;; Puppet files
(autoload 'puppet-mode "puppet-mode" "Major mode for editing Puppet config" t)
(setq auto-mode-alist  (cons '(".pp$" . puppet-mode) auto-mode-alist))

;; Vagrant files
(add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode))

;; Docker files
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile" . dockerfile-mode))

;;
;; MBS - Global configuration
;; Copyright (c) Nicolas Lamirault <nicolas.lamirault@orange.com>
;;

(autoload 'puppet-mode "puppet-mode" "Major mode for editing Puppet config" t)
(setq auto-mode-alist  (cons '(".pp$" . puppet-mode) auto-mode-alist))

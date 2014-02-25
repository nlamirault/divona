;;
;; Setup Emacs configuration
;; Copyright (c) Nicolas Lamirault <nicolas.lamirault@gmail.com>
;;


(setq home-dir (concat (expand-file-name "~") "/"))

(load "server")
(unless (server-running-p)
    (server-start))

(require 'ido)
(ido-mode t)

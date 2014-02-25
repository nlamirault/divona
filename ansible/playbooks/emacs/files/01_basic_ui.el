;;
;; Emacs basic UI
;; Copyright (c) Nicolas Lamirault <nicolas.lamirault@gmail.com>

(setq-default fill-column 120)

(global-linum-mode t)
(setq column-number-mode t)

(require 'tool-bar)
(tool-bar-mode nil)

; show the current line and column numbers in the stats bar as well
(line-number-mode t)
(column-number-mode t)
(blink-cursor-mode nil)

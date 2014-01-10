;; Emacs for Nicolas Lamirault
;; (c) Nicolas Lamirault <nicolas.lamirault@gmail.com>
;;

(setq user-full-name "Nicolas Lamirault")
(setq user-mail-address "nicolas.lamirault@gmail.com")

;; Terminal
;; ---------


(require 'multi-term)
(setq multi-term-program "/bin/bash")
(global-set-key "\C-xt"
		(lambda () (interactive)
		  (unless (multi-term-dedicated-exist-p)
		    (multi-term-dedicated-open))
		  (multi-term-dedicated-select)))

;; Functions
;; -----------

(global-set-key "\C-cg"
		(defun my:google-query (keywords)
		  (interactive
		   (list
		    (if (use-region-p)
			(buffer-substring (region-beginning) (region-end))
		      (read-string "Search Google for: " (thing-at-point 'word)))))
		  (browse-url
		   (concat "http://www.google.com/search?q="
			   (replace-regexp-in-string
			    "[[:space:]]+"
			    "+"
			    keywords)))))


(global-set-key "\C-cq"
		(defun my:quit-emacs ()
		  (interactive)
		  (if (yes-or-no-p "Quit emacs? ")
		      (save-buffers-kill-emacs))))

;; Google
;; ---------




;; Twitter
;; ----------
(require 'twittering-mode)
(setq twittering-use-master-password t)
(setq twittering-icon-mode t)
(setq twittering-timer-interval 300)
(setq twittering-url-show-status nil)
(add-hook 'twittering-new-tweets-hook
	  (lambda ()
	    (let ((n twittering-new-tweets-count))
	      (start-process "twittering-notify" nil "notify-send"
			     "-i" "/usr/share/pixmaps/gnome-emacs.png"
			     "New tweets"
			     (format "You have %d new tweet%s"
				     n (if (> n 1) "s" ""))))))

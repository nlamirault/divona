;;
;; Emails configuration
;; Copyright (c) Nicolas Lamirault <nicolas.lamirault@gmail.com>
;;

(require 'offlineimap)
(require 'smtpmail)


;; ----------------------------------------------------------
;; MU4E

(require 'mu4e)
(require 'mu4e-maildirs-extension)
(mu4e-maildirs-extension)

;; default
;; (setq mu4e-maildir "~/Maildir")

;; don't save message to Sent Messages
;;(setq mu4e-sent-messages-behavior 'delete)

(setq mu4e-drafts-folder "/FT/Drafts")
(setq mu4e-trash-folder "/FT/Trash")
(setq mu4e-sent-folder "/FT/Sent")

(setq mu4e-maildir-shortcuts
      '(("/FT/INBOX.OrangeMBS" . ?m)
	("/FT/INBOX.Departements.Cloud" . ?c)
	("/FT/INBOX.Departements.Cloud.Cloud-Jira" . ?j)
	("/FT/INBOX.Departements.ST" . ?s)
	("/FT/INBOX.OpenSource" . ?g)
	("/FT/INBOX" . ?i)))

(add-to-list 'mu4e-bookmarks '("flag:attach"    "Messages with attachment"   ?a) t)
(add-to-list 'mu4e-bookmarks '("size:5M..500M"  "Big messages"               ?b) t)
(add-to-list 'mu4e-bookmarks '("flag:flagged"   "Flagged messages"           ?f) t)

(setq mu4e-headers-date-format "%Y-%m-%d %H:%M:%S"
      mu4e-headers-fields '((:date . 20)
			    (:flags . 5)
			    ;;(:mailing-list . 10)
			    (:from-or-to . 25)
			    (:subject . nil)))

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "offlineimap"
      mu4e-update-interval 300) ;; seconds

;; Try to display images in mu4e
(setq mu4e-view-show-images t
      mu4e-view-image-max-width 800)
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))
(setq mu4e-view-prefer-html t)

;;(setq mu4e-html2text-command "html2text -utf8 -width 80")
;; HTML reader
(setq mu4e-html-renderer 'w3m)
(setq mu4e-html2text-command "w3m -T text/html")

(setq mail-user-agent 'mu4e-user-agent)

;;(require 'mu4e-w3m)
;; actually use it
;;(setq mu4e-view-render-func 'mu4e-w3m-render-handler)

;; don't keep message buffers around
;;(setq message-kill-buffer-on-exit t)

(setq mu4e-attachment-dir  "~/Documents")

;; ----------------------------------------------------------
;; GNUS


;;(add-hook 'gnus-before-startup-hook 'offlineimap)


;; ----------------------------------------------------------
;; Personal informations
(setq user-mail-address "nicolas.lamirault@orange.com"
      user-full-name  "Nicolas Lamirault"
      message-signature (concat
			 "Nicolas Lamirault\n"
			 "Cloud Computing\n"
			 "Multimedia Customer Contact\n"))

;; ----------------------------------------------------------
;; SMTP

(require 'smtpmail)
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-stream-type 'starttls
      smtpmail-default-smtp-server "exch-ntr-smtp.si.francetelecom.fr"
      smtpmail-smtp-server "exch-ntr-smtp.si.francetelecom.fr"
      smtpmail-smtp-service 25
      smtpmail-auth-credentials "~/.netrc")



(provide 'mail)

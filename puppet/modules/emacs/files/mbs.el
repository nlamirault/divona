;;
;; Emacs configuration for Cloud MBS
;; (c) 2013 Nicolas Lamirault
;;



(autoload 'puppet-mode "puppet-mode" "Major mode for editing Puppet config" t)
(setq auto-mode-alist  (cons '(".pp$" . puppet-mode) auto-mode-alist))

(require 'sr-speedbar)
(global-set-key (kbd "s-s") 'sr-speedbar-toggle)

(add-hook 'find-file-hooks 'auto-insert)
(setq copyright-description
      "Cloud Team\nMultimedia Business Services\n22, 26 Quai de Bacalan, 33000 Bordeaux, FRANCE.\nAll rights reserved.")


;; And here comes The List
(setq auto-insert-alist
      '(
        ;; Python file
        (("\\.py*$" . "Python program")
         nil
         "#!/usr/bin/env python\n"
         "# -*- coding: utf-8 -*-\n"
         "# -*- Mode: Python; tab-width: 4 -*-\n#\n"
         "#\n# Copyright (c) Multimedia Business Services\n"
         "#\n# Author: Cloud MBS <cloud-admin.mbs@orange.com>\n#\n"
         "\"\"\"\nSynopsys here ...\n\nDescription here ...\n\n\"\"\"\n"
        "__author__ = \"" (user-full-name) " <" user-mail-address ">\"\n"
        "__version__ = \"version here ...\"\n"
        "__date__ = \"" (current-time-string) "\"\n"
        "__credits__ = \"\"\"\nCopyright (C) " (substring (current-time-string) -4) " "
        copyright-description "\n\"\"\"\n\n\n\n\n"
        "if __name__ == \"__main__\":\n\tmain()\n")
        ;; Shell
        (("\\.sh*$" . "Shell unix")
         nil
         "#!/bin/bash\n
# Title           : program name
# Description     : The description
# Date            : " (current-time-string) "\n
# Version         : 0.0.0
# Copyright       : Copyright (c)" (substring (current-time-string) -4)
"\n" copyright-description "
# ------------------------------------------------------")
  ))




(provide 'mbs)
;; mbs.el ends here

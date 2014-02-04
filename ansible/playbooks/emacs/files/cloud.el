;; Cloud configuration
;;
;; Copyright (c) Nicolas Lamirault <nicolas.lamirault@gmail.com>
;;
;; This file is not part of GNU Emacs.
;;

;;; License:

;; Licensed under the Apache License, Version 2.0 (the "License");
;; you may not use this file except in compliance with the License.
;; You may obtain a copy of the License at
;;
;;    http://www.apache.org/licenses/LICENSE-2.0
;;
;; Unless required by applicable law or agreed to in writing, software
;; distributed under the License is distributed on an "AS IS" BASIS,
;; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
;; See the License for the specific language governing permissions and
;; limitations under the License.
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

;; -*- mode: elisp -*-

;; Bootstrap's bootstraps
;;;; bootstrap's bootstraps

(package-initialize)
(require 'package)
(setq package-archives
      
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/")
	("elpy" . "http://jorgenschaefer.github.io/packages/")))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; custom shit should go somewhere else:
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; load my files
(load-file "~/.emacs.d/org-protocol-capture-html.el")
(load-file "~/.emacs.d/src/keychain-environment.el")
(load-file "~/.emacs.d/jlj-generic.el")
(load-file "~/.emacs.d/jlj-golang.el")
(load-file "~/.emacs.d/jlj-org.el")
(load-file "~/.emacs.d/jlj-python.el")
(load-file "~/.emacs.d/jlj-rust.el")
;; (load-file "~/.emacs.d/jlj-social.el")

;; load keychain (if it exists)
(when (eq system-type 'gnu/linux)
  (keychain-refresh-environment)
  )
(put 'upcase-region 'disabled nil)

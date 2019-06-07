;; -*- mode: elisp -*-

;; Bootstrap's bootstraps
;;;; bootstrap's bootstraps

(setq user-init-file "~/Documents/projects/agares/applicationConfiguration/.emacs/init.el")
(package-initialize)
(require 'package)
(setq package-archives
      '(("melpa" . "http://melpa.milkbox.net/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/")
	("elpy" . "http://jorgenschaefer.github.io/packages/")))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))


(org-babel-load-file (expand-file-name "~/Documents/projects/agares/applicationConfiguration/.emacs/jlj-init.org"))

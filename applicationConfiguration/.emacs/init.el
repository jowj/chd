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

;; load my files
(load-file "~/Documents/projects/agares/applicationConfiguration/.emacs/jlj-generic.el")
(load-file "~/Documents/projects/agares/applicationConfiguration/.emacs/jlj-golang.el")
(load-file "~/Documents/projects/agares/applicationConfiguration/.emacs/jlj-org.el")
(load-file "~/Documents/projects/agares/applicationConfiguration/.emacs/jlj-python.el")
(load-file "~/Documents/projects/agares/applicationConfiguration/.emacs/jlj-rust.el")
(load-file "~/Documents/projects/agares/applicationConfiguration/.emacs/jlj-social.el")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(epg-gpg-program "/usr/local/bin/gpg")
 '(global-hl-line-mode t)
 '(package-selected-packages
   (quote
    (lsp-ui lsp-mode jedi znc yaml-mode which-key use-package twittering-mode try smex racer python-mode pylint py-autopep8 powershell pdf-tools outline-magic org2blog multiple-cursors magit helm flycheck-rust eyebrowse exec-path-from-shell emojify elpy ein doom-themes dockerfile-mode docker csharp-mode ansible anaconda-mode ace-window)))
 '(znc-servers
   (\`
    (("bouncer.awful.club" 5000 t
      ((freenode "blindidiotgod/freenode"
		 (\, znc-password))
       (OFTC "blindidiotgod/OFTC"
	     (\, znc-password))))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

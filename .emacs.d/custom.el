;;; custom.el --- save custom noise to a separate file -*- lexical-binding: t -*-
;;; Commentary:

;; this file is messy by default, because its just a bucket

;;; Code:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(epg-gpg-program "/usr/local/bin/gpg")
 '(global-hl-line-mode t)
 '(package-selected-packages
   '(dash-functional region-bindings-mode jinja2-mode dockerfile-mode sudo-edit modus-themes org-caldav json-mode pdf-tools org-special-block-extras neotree sr-speedbar lsp-python-ms fira-code-mode yasnippet org-pdftools phps-mode projectile webfeeder znc pinboard yaml-mode which-key web-mode virtualenvwrapper use-package twittering-mode try smex racer powershell poetry pipenv ox-reveal outline-magic org-pdfview org-bullets ob-restclient multiple-cursors magit lua-mode lsp-ui iedit helm flycheck-rust exec-path-from-shell eglot edit-indirect company-lsp ansible ace-window)))
 '(znc-servers
   `(("bouncer.awful.club" 5000 t
      ((freenode "blindidiotgod/freenode" ,znc-password)
       (OFTC "blindidiotgod/OFTC" ,znc-password)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; custom.el ends here

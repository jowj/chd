;;; custom.el --- save custom noise to a separate file -*- lexical-binding: t -*-
;;; Commentary:

;; this file is messy by default, because its just a bucket

;;; Code:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("21e3d55141186651571241c2ba3c665979d1e886f53b2e52411e9e96659132d4" "69f7e8101867cfac410e88140f8c51b4433b93680901bb0b52014144366a08c8" default))
 '(epg-gpg-program "/usr/local/bin/gpg")
 '(global-hl-line-mode t)
 '(org-agenda-files
   '("/home/josiah/dhd/org/documentation.org" "/home/josiah/dhd/org/finances.org" "/home/josiah/dhd/org/jlj-template.org" "/home/josiah/dhd/org/personal.org" "/home/josiah/dhd/org/webwiki.org" "/home/josiah/dhd/org/work.org"))
 '(package-selected-packages
   '(py-isort terraform-mode mu4e org-trello python-black rust-mode company lsp-mode nix-mode markdown-mode flycheck s lsp-pyright ido-vertical-mode dash-functional region-bindings-mode jinja2-mode dockerfile-mode sudo-edit org-caldav json-mode pdf-tools org-special-block-extras neotree sr-speedbar lsp-python-ms yasnippet org-pdftools phps-mode projectile webfeeder znc pinboard yaml-mode which-key web-mode virtualenvwrapper use-package twittering-mode try smex racer powershell poetry pipenv ox-reveal outline-magic org-pdfview org-bullets ob-restclient multiple-cursors magit lua-mode lsp-ui iedit helm flycheck-rust exec-path-from-shell eglot edit-indirect company-lsp ansible ace-window))
 '(request-backend 'url-retrieve))
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

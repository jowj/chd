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
 '(org-agenda-files
   '("/home/josiah/dhd/org/big-bend-notes.org" "/home/josiah/dhd/org/documentation.org" "/home/josiah/dhd/org/finances.org" "/home/josiah/dhd/org/fitness.org" "/home/josiah/dhd/org/housing.org" "/home/josiah/dhd/org/hoyden.org" "/home/josiah/dhd/org/jlj-template.org" "/home/josiah/dhd/org/pagedout.org" "/home/josiah/dhd/org/pagedout2.org" "/home/josiah/dhd/org/personal.org" "/home/josiah/dhd/org/refile-beorg.org" "/home/josiah/dhd/org/someday.org" "/home/josiah/dhd/org/stjohns-trello.org" "/home/josiah/dhd/org/stjohns.org" "/home/josiah/dhd/org/webwiki.org" "/home/josiah/dhd/org/work.org"))
 '(org-trello-current-prefix-keybinding "C-c o" nil (org-trello))
 '(org-trello-files '("~/dhd/org/stjohns-trello.org") nil (org-trello))
 '(package-selected-packages
   '(mu4e org-trello python-black rust-mode company lsp-mode nix-mode markdown-mode flycheck s lsp-pyright ido-vertical-mode dash-functional region-bindings-mode jinja2-mode dockerfile-mode sudo-edit modus-themes org-caldav json-mode pdf-tools org-special-block-extras neotree sr-speedbar lsp-python-ms fira-code-mode yasnippet org-pdftools phps-mode projectile webfeeder znc pinboard yaml-mode which-key web-mode virtualenvwrapper use-package twittering-mode try smex racer powershell poetry pipenv ox-reveal outline-magic org-pdfview org-bullets ob-restclient multiple-cursors magit lua-mode lsp-ui iedit helm flycheck-rust exec-path-from-shell eglot edit-indirect company-lsp ansible ace-window))
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

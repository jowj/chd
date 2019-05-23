;; -*- mode: elisp -*-

;;;; packages
;;list package targets
(setq package-archives
      '(("melpa" . "http://melpa.milkbox.net/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/")
	("elpy" . "http://jorgenschaefer.github.io/packages/")))

;;Refresh package contents
(unless package-archive-contents
  (package-refresh-contents))


(defvar jlj-Packages
  '(doom-themes
    outline-magic
    multiple-cursors
    rust-mode
    cargo
    flycheck-rust
    racer
    helm
    eyebrowse
    ;;company-mode
    org2blog
    pylint
    python-mode
    markdown-mode
    powershell
    csharp-mode
    ein
    elpy
    flycheck
    znc
    twittering-mode
    pdf-tools
    magit
    exec-path-from-shell
    py-autopep8))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
jlj-Packages)

;;;;gpg shit
(setf epa-pinentry-mode 'loopback)
(setq auth-sources `("~/Documents/projects/agares/applicationConfiguration/.emacs/jlj-secrets.gpg"))

(load "~/Documents/projects/agares/applicationConfiguration/.emacs/jlj-misc.el")
(load "~/Documents/projects/agares/applicationConfiguration/.emacs/jlj-helm.el")
(load "~/Documents/projects/agares/applicationConfiguration/.emacs/jlj-org.el")
(load "~/Documents/projects/agares/applicationConfiguration/.emacs/jlj-python.el")
(load "~/Documents/projects/agares/applicationConfiguration/.emacs/jlj-rust.el")
(load "~/Documents/projects/agares/applicationConfiguration/.emacs/jlj-erc.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (manoj-dark)))
 '(custom-safe-themes
   (quote
    ("356e5cbe0874b444263f3e1f9fffd4ae4c82c1b07fe085ba26e2a6d332db34dd" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(org-capture-templates
   (quote
    (("c" "generic \"to do\" capture template" entry
      (file "~/Nextcloud/Documents/org/refile-beorg.org")
      "" :prepend t))))
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-docview org-gnus org-habit org-info org-irc org-mhe org-rmail org-w3m)))
 '(package-selected-packages
   (quote
    (twittering-mode znc eyebrowse helm racer flycheck-rust rust-mode color-theme-sanityinc-tomorrow org2blog multiple-cursors flymake-python-pyflakes pdf-tools weechat jedi python-mode pylint py-autopep8 powershell outline-magic markdown-mode magit flycheck exec-path-from-shell elpygen elpy ein doom-themes csharp-mode)))
 '(znc-servers
   (\`
    (("bouncer.awful.club" 5000 t
      ((freenode "blindidiotgod/freenode"
		 (\, znc-password))
       (OFTC "blindidiotgod/OFTC"
	     (\, znc-password))))))))

;;;; run emacs as server (connect to it with `emacsclient`)
(server-start)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:inherit outline-1 :height 1.3))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.2))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.1))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.1))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.1)))))


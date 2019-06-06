;; -*- mode: elisp -*-

;; Set global vars


(setq inhibit-splash-screen t)       ; Disable the splash screen (to enable it agin, replace the t with 0)
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode)); show line numbers; use this instead of linum if you can because FUCK linum sucks

(global-visual-line-mode t)          ; turn on word-wrap globally (probably a mistake, but wanted for org-mode)
(menu-bar-mode -1)                   ; disable visual menu on emacs
(tool-bar-mode -1)
(setq indent-tabs-mode nil)          ; always use spaces, not tabs, when indenting
(setq case-fold-search t)            ; ignore case when searching

(setq require-final-newline t)

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta) ; deal with mac command key problems:
  ;; Make emacs use a different default than the OS
  ;; only really useful on work computers, but there we go.
  (setq browse-url-browser-function #'browse-url-generic
	browse-url-generic-program "open"
	browse-url-generic-args '("-a" "Firefox")))

(if (eq system-type 'windows-nt)
    (message "i am windows and suck") ; deal with mac command key problems
  (exec-path-from-shell-copy-env "PATH"))

(setq backup-directory-alist `(("." . "~/Nextcloud/Documents/org/.saves"))) ; deal with bullshit files in every dir.
(set-frame-font "Consolas 12")                                  ; set default font,  versions of emacs may require set-default-font

(setq user-init-file "~/Documents/projects/agares/applicationConfiguration/.emacs/init.el") ;set default init file to agares
(find-file "~/Nextcloud/Documents/org/personal.org")                           ;open primary org file on launch
(transient-mark-mode 1)                                            ; Enable transient mark mode

;; custom emacsland functions
(defun find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-other-window user-init-file))
(global-set-key (kbd "C-c J") 'find-user-init-file)

;; Custom frame management chords
(global-set-key (kbd "C-x O") 'other-frame)
(global-set-key (kbd "C-x T") 'make-frame-command)
(global-set-key (kbd "C-x W") 'delete-frame)

;; more gpg shit
(setf epa-pinentry-mode 'loopback)
(setq auth-sources `("~/Documents/projects/agares/applicationConfiguration/.emacs/jlj-secrets.gpg"))

;;;; packages
;;list package targets
(setq package-archives
      '(("melpa" . "http://melpa.milkbox.net/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/")
	("elpy" . "http://jorgenschaefer.github.io/packages/")))

;;Refresh package contents
(unless package-archive-contents
  (package-refresh-contents))


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package smex
  :ensure t
  :config
  (progn
    (defadvice smex (around space-inserts-hyphen activate compile)
      (let ((ido-cannot-complete-command 
	     `(lambda ()
		(interactive)
		(if (string= " " (this-command-keys))
		    (insert ?-)
		  (funcall ,ido-cannot-complete-command)))))
	ad-do-it))

    (global-set-key (kbd "M-x") 'smex)
    (global-set-key (kbd "M-X") 'smex-major-mode-commands)
    ;; This is your old M-x.
    (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)))

(use-package org
  :ensure t
  :config
  (progn
    ;;Org mode configuration
    (require 'org)                                       ; Enable Org mode
    (setq ispell-program-name "/usr/local/bin/ispell")   ; set flyspell's spellchecker
    (add-hook 'org-mode-hook 'turn-on-flyspell)          ; enable flyspell-mode in all org-mode enabled files
    (setq org-src-fontify-natively t
	  org-src-window-setup 'current-window
	  org-src-strip-leading-and-trailing-blank-lines t
	  org-src-preserve-indentation t
	  org-src-tab-acts-natively t
	  x-selection-timeout 10 ;; this fixes a freeze when org-capture is called. lol.
	  org-edit-src-content-indentation 0)

    (add-hook 'org-agenda-mode-hook
	      (lambda ()
		(visual-line-mode -1)
		(toggle-truncate-lines 1)))
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((python . t)
       (matlab . t)))

    ;; org-agenda configs
    (setq org-habit-show-habits-only-for-today nil)
    (setq org-agenda-repeating-timestamp-show-all nil)
    (setq org-deadline-warning-days 1)
    (setq org-global-properties
	  '(("Effort_ALL". "0 0:10 0:30 1:00 2:00 3:00 4:00")))
    (setq org-columns-default-format
	  '(("%25ITEM %TODO %3PRIORITY %TAGS")))

;;;; custom org mode hotkeys 
    (global-set-key "\C-cl" 'org-store-link)
    (global-set-key "\C-ca" 'org-agenda)
    (global-set-key "\C-cc" 'org-capture)
    (global-set-key "\C-cb" 'org-iswitchb)

;;;; search across agenda files when refiling:
    (setq org-refile-targets '((nil :maxlevel . 9)
			       (org-agenda-files :maxlevel . 9)))
    (setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
    (setq org-refile-use-outline-path t)                  ; Show full paths for refiling
    (setq org-agenda-files '("~/Nextcloud/Documents/org/"))           ; add files to agenda:


    (setq org-directory "~/Nextcloud/Documents/org/")                 ; define generic org capture shit
    (setq org-default-notes-file (concat org-directory "/refile-beorg.org"))))

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package ace-window
  :ensure t
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)))

(use-package outline-magic
  :ensure t)

(use-package multiple-cursors
  :ensure t
  :config
  (progn
    (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
    (global-set-key (kbd "C->") 'mc/mark-next-like-this)
    (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
    (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)))

(use-package rust-mode
  :ensure t
  :config
  (progn
    (add-hook 'rust-mode-hook 'cargo-minor-mode)
    (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
    (add-hook 'rust-mode-hook
	      (lambda ()
		(local-set-key (kbd "C-c <tab>") #'rust-format-buffer)))

    (setq racer-cmd "~/.cargo/bin/racer") ;; Rustup binaries PATH
    (setq racer-rust-src-path "~/gitshit/rust/src") ;; Rust source code PATH

    (add-hook 'rust-mode-hook #'racer-mode)
    (add-hook 'racer-mode-hook #'eldoc-mode)
    (add-hook 'racer-mode-hook #'company-mode)))

(use-package flycheck-rust
  :ensure t)

(use-package racer
  :ensure t)

(use-package helm
  :ensure t
  :config
  (progn
    (defun helm-surfraw-duck (x)
      "Search duckduckgo in default browser"
      (interactive "sSEARCH:")
      (helm-surfraw x "duckduckgo" ))
    (global-set-key (kbd "C-c s") 'helm-surfraw-duck)))

(use-package eyebrowse
  :ensure t)
(use-package pylint
  :ensure t)

(use-package python-mode
  :ensure t)

(use-package markdown-mode
  :ensure t)

(use-package powershell
  :ensure t)

(use-package ein
  :ensure t)

(use-package elpy
  :ensure t
  :config
  (progn
    (require 'elpy)
    (when (require 'flycheck nil t)
      (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
      (add-hook 'elpy-mode-hook 'flycheck-mode))
    (elpy-enable)
    (setq python-shell-interpreter "python3"
	  python-shell-interpreter-args "-i")))

(use-package flycheck
  :ensure t)

(use-package znc
  :ensure t
  :config
  (progn
    (require 'epa)
    ;; handle annoying gpg shit.
    (defun lookup-password (host user port)
      "Lookup encrypted password given HOST, USER and PORT for service."
      (require 'auth-source)
      (funcall (plist-get
		(car (auth-source-search
		      :host host
		      :user user
		      :type 'netrc
		      :port port))
		:secret)))

    (setq znc-password(lookup-password "bouncer.awful.club" "blindidiotgod/OFTC" 5000))

    ;; by default, erc alerts you on any activity. I only want to hear
    ;; about mentions of nick or keyword
    (custom-set-variables
     '(znc-servers
       `(("bouncer.awful.club" 5000 t
	  ((freenode "blindidiotgod/freenode" ,znc-password)
	   (OFTC "blindidiotgod/OFTC" ,znc-password))))))
    (setq erc-current-nick-highlight-type 'all)
    (setq erc-keywords '("security"))
    (setq erc-track-exclude-types '("JOIN" "PART" "NICK" "MODE" "QUIT"))
    (setq erc-track-use-faces t)
    (setq erc-track-faces-priority-list
	  '(erc-current-nick-face erc-keyword-face))
    (setq erc-track-priority-faces-only 'all)
    (setq erc-hide-list '("PART" "QUIT" "JOIN"))
    (setq erc-join-buffer 'bury)))

(use-package twittering-mode
  :ensure t
  :config
  (progn
    (setq twittering-icon-mode t)
    (setq twittering-reverse-mode t)
    (setq twittering-enable-unread-status-notifier t)
    (with-eval-after-load "twittering-mode" (define-key twittering-mode-map (kbd "C-c C-o") `twittering-view-user-page))))

(use-package pdf-tools
  :ensure t)

(use-package magit
  :ensure t)

(use-package exec-path-from-shell
  :ensure t)

(use-package py-autopep8
  :ensure t
  :config
  (progn
    (require 'py-autopep8)
    (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)))
  
;;;;gpg shit


;(load "~/Documents/projects/agares/applicationConfiguration/.emacs/jlj-misc.el")
;(load "~/Documents/projects/agares/applicationConfiguration/.emacs/jlj-helm.el")
;(load "~/Documents/projects/agares/applicationConfiguration/.emacs/jlj-org.el")
;(load "~/Documents/projects/agares/applicationConfiguration/.emacs/jlj-python.el")
;(load "~/Documents/projects/agares/applicationConfiguration/.emacs/jlj-rust.el")
;(load "~/Documents/projects/agares/applicationConfiguration/.emacs/jlj-erc.el")

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
    (ace-window which-key try use-package dockerfile-mode ansible yaml-mode smex twittering-mode znc eyebrowse helm racer flycheck-rust rust-mode color-theme-sanityinc-tomorrow org2blog multiple-cursors flymake-python-pyflakes pdf-tools weechat jedi python-mode pylint py-autopep8 powershell outline-magic markdown-mode magit flycheck exec-path-from-shell elpygen elpy ein doom-themes csharp-mode)))
 '(znc-servers
   (\`
    (("bouncer.awful.club" 5000 t
      ((freenode "blindidiotgod/freenode"
                 (\, znc-password))
       (OFTC "blindidiotgod/OFTC"
             (\, znc-password))))))))

;;;; run emacs as server (connect to it with `emacsclient`)
(server-start)


;; set some more keybindings
(global-set-key "\M-`" 'other-frame) ; mimic the way macosx switches between windows of the same application

;; look at https://www.emacswiki.org/emacs/Desktop
(require 'desktop)
(desktop-save-mode 1)
(defun jlj-desktop-save ()
  (interactive)
  ;; Don't call desktop-save-in-desktop-dir, as it prints a message.
  (if (eq (desktop-owner) (emacs-pid))
      (desktop-save desktop-dirname)))
(add-hook 'auto-save-hook 'jlj-desktop-save)

;; always create two brackets
(electric-pair-mode 1)
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

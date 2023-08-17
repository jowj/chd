;;; jlj-generic.el --- generic changes that don't fit in a general category go here -*- lexical-binding: t -*-
;;; Commentary:

;; this file is messy by default, because its just a bucket
;; i.e. "this doesn't have a real category, so lets put it here."

;;; Code:
(global-visual-line-mode t)          ; turn on word-wrap globally
(setq case-fold-search t)            ; ignore case when searching
(fset 'yes-or-no-p 'y-or-n-p)        ; make it easier to answer qs.

;; Preserve contents of system clipboard
(setq save-interprogram-paste-before-kill t)

;; Remove the FUCKING frustrating C-z mnimize. Change to undo.
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-w") 'backward-kill-word)

;; Use C-w to delete a word backwards
;; with region bind mode,though, i can do that while retaining kill region usage!
(use-package region-bindings-mode
  :ensure t
  :config
  (region-bindings-mode-enable))

(global-set-key (kbd "C-w") 'backward-kill-word)
(define-key region-bindings-mode-map (kbd "C-w") 'kill-region)

(show-paren-mode 1)
(setq show-paren-delay 0)

;; set default font for macos
(when (eq system-type 'darwin)
  (use-package fira-code-mode
    :custom (fira-code-mode-disabled-ligatures '("[]" "#{" "#(" "#_" "#_(" "x")) ;; List of ligatures to turn off
    :config (global-fira-code-mode)) ;; Enables fira-code-mode globally
  (set-frame-font "fira code 12")
  (add-to-list 'default-frame-alist '(font . "fira code 12" ))
  (set-face-attribute 'default t :font "fira code 12" ))
(transient-mark-mode 1)              ; Enable transient mark mode (highlights)

(global-hl-line-mode t)              ; highlights the line you're on

(setq indent-tabs-mode nil)                          ; always use spaces when indenting
(setq require-final-newline t)
(setq backup-directory-alist `(("." . "~/dhd/org/.saves")))
(find-file "~/dhd/org/personal.org") ;open primary org file on launch
(electric-pair-mode 1)                               ; create paired brackets.

;; themes
;; experiemtning with the modus themes that will be native come emacs 28
;; they are more acciessble for r/g color blind stuff
;; (load-theme 'manoj-dark) loads my favorite default theme
(use-package modus-themes
  :ensure
  :init
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-slanted-constructs t
        modus-themes-bold-constructs t
	modus-themes-paren-match 'intense-bold)

  ;; Load the theme files before enabling a theme
  (modus-themes-load-themes)
  :config
  ;; Load the theme of your choice:
  (modus-themes-load-vivendi)  ;; (modus-themes-load-operandi)
  :bind ("<f5>" . modus-themes-toggle))


(use-package yasnippet
  :ensure t
  :config
  (yas-minor-mode-on)
  (yas-global-mode 1)
  (add-hook 'python-mode-hook '(lambda () (set (make-local-variable 'yas-indent-line) 'fixed))))



;; lets you find all instance of string @ point with C-;
(use-package iedit
  :ensure t)

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  ;; Make emacs use a different default than the OS
  ;; only really useful on work computers, but there we go.
  (setq browse-url-browser-function #'browse-url-generic
	browse-url-generic-program "open"
	browse-url-generic-args '("-a" "Firefox")))

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-copy-env "PATH"))

;; (if (string-equal "darwin" (symbol-name system-type))
;;    (setenv "PATH" (concat "/usr/local/bin:/usr/local/sbin:" (getenv "PATH"))))

(defun find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-other-window user-init-file))
(global-set-key (kbd "C-c J") 'find-user-init-file)

(setq user-home-file "~/dhd/org/personal.org")
(defun find-user-home-file ()
  "Edit the `user-home-file' in this window."
  (interactive)
  (find-file user-home-file))
(global-set-key (kbd "C-c C-j h") 'find-user-home-file)

;; Custom frame management chords
(global-set-key (kbd "C-x O") 'other-frame)
(global-set-key (kbd "C-x T") 'make-frame-command)
(global-set-key (kbd "C-x W") 'delete-frame)
(global-set-key "\M-`" 'other-frame) ; mimic the way macosx switches

;; experiment with mouse bindings
(global-set-key [mouse-8] 'yank)

(use-package helm
  :ensure t
  :config
  (progn
    (helm-mode 1)
    (define-key global-map [remap find-file] 'helm-find-files)
    (define-key global-map [remap occur] 'helm-occur)
    (define-key global-map [remap list-buffers] 'helm-buffers-list)
    (define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
    (define-key global-map [remap execute-extended-command] 'helm-M-x)
    (define-key global-map [remap apropos-command] 'helm-apropos)
    (unless (boundp 'completion-in-region-function)
      (define-key lisp-interaction-mode-map [remap completion-at-point] 'helm-lisp-completion-at-point)
      (define-key emacs-lisp-mode-map       [remap completion-at-point] 'helm-lisp-completion-at-point))
    (defun helm-surfraw-duck (x)
      "Search duckduckgo in default browser"
      (interactive "sSEARCH:")
      (helm-surfraw x "duckduckgo" ))
    (global-set-key (kbd "C-c s") 'helm-surfraw-duck)))

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


;; I don't remember what this does or why i have it
;; an emacs story
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

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

(use-package markdown-mode
  :ensure t)

(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install))

(use-package magit
  :ensure t)

(setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
(setq org-reveal-mathjax t)

(use-package ox-reveal
  :ensure t)

(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (setq web-mode-engines-alist
	'(("django"    . "\\.html\\'")))
  (setq web-mode-ac-sources-alist
	'(("css" . (ac-source-css-property))
	  ("html" . (ac-source-words-in-buffer ac-source-abbrev))))

  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-auto-quoting t)) ; this fixes the quote problem I mentioned


(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-register-project-type 'python '("pyproject.toml")
				    :test "python -m unittest -v"
				    :test-prefix "test_"))

(use-package powershell
  :ensure t)

(use-package ansible
  :ensure t)

(use-package terraform-mode
  :ensure t
  :custom (terraform-indent-level 4)
  :config
  (defun my-terraform-mode-init ()
    ;; if you want to use outline-minor-mode
    ;; (outline-minor-mode 1)
    )

  (add-hook 'terraform-mode-hook 'my-terraform-mode-init))

(use-package yaml-mode
  :ensure t)

(use-package lua-mode
  :ensure t
  :config
      (autoload 'lua-mode "lua-mode" "Lua editing mode." t)
      (add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
      (add-to-list 'interpreter-mode-alist '("lua" . lua-mode)))

(use-package json-mode
  :ensure t)

(use-package nix-mode
  :ensure t
  :mode "\\.nix\\'")

(use-package neotree
  :ensure t
  :config
  (progn
    (global-set-key [f8] 'neotree-toggle)))

(use-package sudo-edit
  :ensure t)

(use-package dockerfile-mode
  :ensure t)

;; add weird mu4e path to emacs
;; THIS IS A HARD CODED NIX DERIV rather than something better. be careful.
;; I expect this to break a decent amount
(when (string= (system-name) "hoyden")
  (add-to-list 'load-path "~/.emacs.d/src/mu4e")
  (require 'mu4e)
  (require 'mu4e-view-gnus) ; this is required on nixos for some reason; maybe in other places? if you don't, you can't view messages
  (setq mail-user-agent 'mu4e-user-agent)
  ;; use 'fancy' non-ascii characters in various places in mu4e
  (setq mu4e-use-fancy-chars t)
  ;; attempt to show images when viewing messages
  (setq mu4e-view-show-images t))


(defun magit-add-current-buffer ()
  "Adds (with force) the file from the current buffer to the git repo"
  (interactive)
  (shell-command (concat "git add -f "
			 (shell-quote-argument buffer-file-name))))


(server-start)

;;; jlj-generic.el ends here

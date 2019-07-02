(setq inhibit-splash-screen t)       ; Disable the splash screen
;; (when (version<= "26.0.50" emacs-version )
;;   (global-display-line-numbers-mode)); show line numbers; use this instead of linum if you can

(global-visual-line-mode t)          ; turn on word-wrap globally
(menu-bar-mode -1)                   ; disable visual menu on emacs
(tool-bar-mode -1)                   ; disable toolbar

(setq case-fold-search t)            ; ignore case when searching
(fset 'yes-or-no-p 'y-or-n-p)        ; make it easier to answer qs.
(set-frame-font "Consolas 12")       ; set default font
(transient-mark-mode 1)              ; Enable transient mark mode (highlights)
(load-theme 'manoj-dark)             ; loads my favorite default theme
(global-hl-line-mode t)              ; highlights the line you're on

(setq indent-tabs-mode nil)                          ; always use spaces when indenting
(setq require-final-newline t)
(setq backup-directory-alist `(("." . "~/Nextcloud/Documents/org/.saves")))
(find-file "~/Nextcloud/Documents/org/personal.org") ;open primary org file on launch
(electric-pair-mode 1)                               ; create paired brackets.

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

(if (eq system-type 'windows-nt)
    (message "i am windows and suck") ; deal with mac command key problems
  (exec-path-from-shell-copy-env "PATH"))

;; (if (string-equal "darwin" (symbol-name system-type))
;;    (setenv "PATH" (concat "/usr/local/bin:/usr/local/sbin:" (getenv "PATH"))))

(defun find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-other-window user-init-file))
(global-set-key (kbd "C-c J") 'find-user-init-file)

(setq user-home-file "~/Nextcloud/Documents/org/personal.org")
(defun find-user-home-file ()
  "Edit the `user-home-file' in this window"
  (interactive)
  (find-file user-home-file))
(global-set-key (kbd "C-c C-j h") 'find-user-home-file)

;; Custom frame management chords
(global-set-key (kbd "C-x O") 'other-frame)
(global-set-key (kbd "C-x T") 'make-frame-command)
(global-set-key (kbd "C-x W") 'delete-frame)
(global-set-key "\M-`" 'other-frame) ; mimic the way macosx switches

(use-package helm
  :ensure t
  :config
  (progn
    (defun helm-surfraw-duck (x)
      "Search duckduckgo in default browser"
      (interactive "sSEARCH:")
      (helm-surfraw x "duckduckgo" ))
    (global-set-key (kbd "C-c s") 'helm-surfraw-duck)))

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

(use-package org-pdfview
  :ensure t)

(use-package magit
  :ensure t)

(require 'desktop)
(desktop-save-mode 1)
(defun jlj-desktop-save ()
  (interactive)
  ;; Don't call desktop-save-in-desktop-dir, as it prints a message.
  (if (eq (desktop-owner) (emacs-pid))
      (desktop-save desktop-dirname)))
(add-hook 'auto-save-hook 'jlj-desktop-save)


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

(use-package powershell
  :ensure t)

(server-start)

;; -*- mode: elisp -*-

;; setup basic defaults for social emacs config
;;;; Bootstrap's bootstraps
;;;;;; bootstrap's bootstraps

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
(load-file "~/.emacs.d/src/keychain-environment.el")
(load-file "~/.emacs.d/jlj-social.el")

;; load keychain (if it exists)
(when (eq system-type 'gnu/linux)
  (keychain-refresh-environment)
  )


(setq inhibit-splash-screen t)       ; Disable the splash screen
;; (when (version<= "26.0.50" emacs-version )
;;   (global-display-line-numbers-mode)); show line numbers; use this instead of linum if you can

;; (global-visual-line-mode t)          ; turn on word-wrap globally
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

(setq user-init-file "~/.emacs.d/init-mail.el")

(defun find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-other-window user-init-file))
(global-set-key (kbd "C-c J") 'find-user-init-file)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(pinboard yaml-mode which-key web-mode virtualenvwrapper use-package twittering-mode try smex racer powershell poetry pipenv ox-reveal outline-magic org-pdfview org-bullets ob-restclient multiple-cursors magit lua-mode lsp-ui iedit helm flycheck-rust exec-path-from-shell eglot edit-indirect company-lsp ansible ace-window)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

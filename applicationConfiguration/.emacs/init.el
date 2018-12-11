;; -*- mode: elisp -*-

;; Set global vars
(setq inhibit-splash-screen t)       ; Disable the splash screen (to enable it agin, replace the t with 0)
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode)); show line numbers; use this instead of linum if you can because FUCK linum sucks

(global-visual-line-mode t)          ; turn on word-wrap globally (probably a mistake, but wanted for org-mode)
(menu-bar-mode -1)                   ; disable visual menu on emacs
(setq indent-tabs-mode nil)          ; always use spaces, not tabs, when indenting
(setq case-fold-search t)            ; ignore case when searching

; require final newlines in files when they are saved
(setq require-final-newline t)

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)) ; deal with mac command key problems:

(setq backup-directory-alist `(("." . "~/Dropbox/org/.saves"))) ; deal with bullshit files in every dir.
(set-frame-font "Consolas 12")                                  ; set default font,  versions of emacs may require set-default-font

(setq user-init-file "~/Documents/projects/agares/applicationConfiguration/.emacs/init.el") ;set default init file to agares
(find-file "~/Dropbox/org/personal.org")                           ;open primary org file on launch
(transient-mark-mode 1)                                            ; Enable transient mark mode

;; custom emacsland functions
(defun find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-other-window user-init-file))
(global-set-key (kbd "C-c I") 'find-user-init-file)

;;Org mode configuration
(require 'org)                                       ; Enable Org mode
(setq ispell-program-name "/usr/local/bin/ispell")   ; set flyspell's spellchecker
(add-hook 'org-mode-hook 'turn-on-flyspell)          ; enable flyspell-mode in all org-mode enabled files

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
(setq org-agenda-files '("~/Dropbox/org/"))           ; add files to agenda:


(setq org-directory "~/Dropbox/org/")                 ; define generic org capture shit
(setq org-default-notes-file (concat org-directory "/refile-beorg.org"))

;; packages

;;;;list package targets
(setq package-archives
      '(("melpa" . "http://melpa.milkbox.net/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/")
	("elpy" . "http://jorgenschaefer.github.io/packages/")))
;;;;Refresh package contents
(unless package-archive-contents
  (package-refresh-contents))

(defvar myPackages
  '(doom-themes
    outline-magic
    pylint
    python-mode
    markdown-mode
    powershell
    csharp-mode
    ein
    elpy
    flycheck
    magit
    exec-path-from-shell
    py-autopep8))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; load custom themes

;;;; doom theme bullshit
  (require 'doom-themes)

  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled

  ;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each
  ;; theme may have their own settings.
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   '("~/Dropbox/org/work.org" "~/Dropbox/org/refile-beorg.org" "~/Dropbox/org/personal.org" "~/Dropbox/org/someday.org"))
 '(org-capture-templates
   '(("c" "generic \"to do\" capture template" entry
      (file "~/Dropbox/org/refile-beorg.org")
      "" :immediate-finish t)))
 '(package-selected-packages
   '(weechat jedi python-mode pylint py-autopep8 powershell outline-magic markdown-mode magit flycheck exec-path-from-shell elpygen elpy ein doom-themes csharp-mode)))


;; run emacs as server (connect to it with `emacsclient`)

;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)
(setq python-shell-interpreter "python3"
      python-shell-interpreter-args "-i")

;; use flycheck not flymake with elpy
(require 'elpy)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; shell confs
(exec-path-from-shell-copy-env "PATH") ; copy PATH from shell

(server-start)

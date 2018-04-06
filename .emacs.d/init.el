;; -*- mode: elisp -*-
;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)


;; open primary org file on launch
(find-file "~/Dropbox/org/personal.org") 
;; Enable transient mark mode
(transient-mark-mode 1)

;;;;Org mode configuration
;; Enable Org mode
(require 'org)
;; Make Org mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen

;; packages
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))

;; load custom themes
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (flatui)))
 '(custom-safe-themes
   (quote
    ("15348febfa2266c4def59a08ef2846f6032c0797f001d7b9148f30ace0d08bcf" default)))
 '(package-selected-packages (quote (markdown-mode flatui-theme powershell))))
 '(org-agenda-files
   (quote
    ("~/Dropbox/org/work.org" "~/Dropbox/org/refile-beorg.org" "~/Dropbox/org/personal.org")))
 '(org-capture-templates
   (quote
    (("c" "generic \"to do\" capture template" entry
      (file "~/Dropbox/org/refile-beorg.org")
      "" :immediate-finish t))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; custom org mode hotkeys 
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

;; search across agenda files when refiling:
(setq org-refile-targets '((nil :maxlevel . 9)
                                (org-agenda-files :maxlevel . 9)))
(setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
(setq org-refile-use-outline-path t)                  ; Show full paths for refiling

;; add files to agenda:
(setq org-agenda-files '("~/Dropbox/org/"))

;; define generic org capture shit
(setq org-directory "~/Dropbox/org/")
(setq org-default-notes-file (concat org-directory "/refile-beorg.org"))
(define-key global-map "\C-cc" 'org-capture)

;; tell emacs to stop writing bullshit in all my folders
;; and just put all backups in a single folder
;; technically i'm doing this in a dumb way, but for now it should be fine.
(setq backup-directory-alist `(("." . "~/Dropbox/org/.saves")))

;; set default font
(set-default-font "Consolas 12")

;; turn on word-wrap globally (probably a mistake, but wanted for org-mode)
(global-visual-line-mode t)

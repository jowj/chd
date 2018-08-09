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

(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.3))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.2))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.1))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.1))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.1))))
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

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  ;;(add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; load custom themes
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(flatui))
 '(custom-safe-themes
   '("15348febfa2266c4def59a08ef2846f6032c0797f001d7b9148f30ace0d08bcf" default))
 '(package-selected-packages
   '(doom-themes outline-magic pylint python-mode markdown-mode powershell csharp-mode)))
 '(org-agenda-files
   (quote
    ("~/Dropbox/org/work.org" "~/Dropbox/org/refile-beorg.org" "~/Dropbox/org/personal.org")))
 '(org-capture-templates
   (quote
    (("c" "generic \"to do\" capture template" entry
      (file "~/Dropbox/org/refile-beorg.org")
      "" :immediate-finish t))))

;; trialing a new thing here; sometimes not all my packages actually get set up.
(unless package--initialized (package-initialize t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; tell emacs to stop writing bullshit in all my folders
;; and just put all backups in a single folder
;; technically i'm doing this in a dumb way, but for now it should be fine.
(setq backup-directory-alist `(("." . "~/Dropbox/org/.saves")))

;; set default font
;; some versions of emacs may require set-default-font.
(set-frame-font "Consolas 12")

;; turn on word-wrap globally (probably a mistake, but wanted for org-mode)
(global-visual-line-mode t)

;; run emacs as server (connect to it with `emacsclient`)
(server-start)

;; set default init file so it stops fucking trying to write to bullshit files
(setq user-init-file "~/Documents/projects/agares/.emacs/init.el")

;; deal with mac command key problems:
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta))

;; custom emacsland functions
(defun find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-other-window user-init-file))
(global-set-key (kbd "C-c I") 'find-user-init-file)



;;Org mode configuration

(require 'org)                                       ; Enable Org mode
(setq ispell-program-name "/usr/local/bin/ispell")   ; set flyspell's spellchecker
(add-hook 'org-mode-hook 'turn-on-flyspell)          ; enable flyspell-mode in all org-mode enabled files
(setq org-src-fontify-natively t
    org-src-window-setup 'current-window
    org-src-strip-leading-and-trailing-blank-lines t
    org-src-preserve-indentation t
    org-src-tab-acts-natively t
    setq x-selection-timeout 10 ;; this fixes a freeze when org-capture is called. lol.
    org-edit-src-content-indentation 0)

(add-hook 'org-agenda-mode-hook
          (lambda ()
            (visual-line-mode -1)
            (toggle-truncate-lines 1)))

;; org-agenda configs
(setq org-habit-show-habits-only-for-today nil)
(setq org-agenda-repeating-timestamp-show-all nil)
(setq org-deadline-warning-days 1)
(setq org-global-properties
      '(("Effort_ALL". "0 0:10 0:30 1:00 2:00 3:00 4:00")))
(setq org-columns-default-format
      '(("%25ITEM %TODO %3PRIORITY %TAGS")))

(setq org2blog/wp-blog-alist
      '(("wordpress"
         :url "https://web1/xmlrpc.php"
         :username "josiah"
         :default-title "published from org"
         :default-categories ("org2blog" "emacs" "homelab")
         :tags-as-categories nil)))

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
(setq org-agenda-files '("~/Nextcloud/Documents/org/"))           ; add files to agenda:


(setq org-directory "~/Nextcloud/Documents/org/")                 ; define generic org capture shit
(setq org-default-notes-file (concat org-directory "/refile-beorg.org"))

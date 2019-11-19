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
       (matlab . t)
       (restclient . t)))

    

    (setq org-babel-python-command "/usr/local/bin/python3")
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



;; Set up bullets
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package ob-restclient
  :ensure t
  :after org)

;; configure the org protocol
(org-load-modules-maybe t)
(require 'org-protocol)
(require 'org-protocol-capture-html)
(setq org-protocol-default-template-key "w")

(setq org-capture-templates
       `(("w" "Web site" entry (file+olp "~/Nextcloud/Documents/org/refile-beorg.org" "Web")
	"* %c :website:\n%U %?%:initial")
       ("x" "web snippets with selection" entry (file "~/Nextcloud/Documents/org/refile-beorg.org")
         "* %^{Title}\n\n  Source: %u, %c\n\n  %i" :empty-lines 1)
        ;; ... more templates here ...
	("c" "Context-include Todo" entry (file "~/Nextcloud/Documents/org/refile-beorg.org")
	   "* TODO %?\n%U \n '%a'" :empty-lines 1 :prepend t)
	  ("t" "Todo" entry (file "~/Nextcloud/Documents/org/refile-beorg.org")
	   "* TODO %?\n%U" :empty-lines 1 :prepend t)))

;;; jlj-org.el --- Customize my org setup -*- lexical-binding: t -*-
;;; Commentary:
;; Anything that customizes org-mode goes here.
;; this could probably be cleaned up more but its fine for now.
;;; Code:
;; Initialise installed packages

(use-package org
  :ensure t
  :config
  (progn
    ;;Org mode configuration
    (require 'ox)
    (require 'org)                                       ; Enable Org mode
    (setq ispell-program-name "/run/current-system/sw/bin/ispell")   ; set flyspell's spellchecker
    (add-hook 'org-mode-hook 'turn-on-flyspell)          ; enable flyspell-mode in all org-mode enabled files
    (setq org-src-fontify-natively t
	  org-src-window-setup 'current-window
	  org-export-in-background t
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
       (restclient . t)
       (shell . t)))

    ;; log state changes to a drawer
    (setq org-log-into-drawer t)
    (setq org-log-done 'time)

    ;; org-agenda configs
    (setq org-habit-show-habits-only-for-today nil)
    (setq org-agenda-repeating-timestamp-show-all nil)
    (setq org-deadline-warning-days 1)
    (setq org-global-properties
	  '(("Effort_ALL". "0 0:10 0:30 1:00 2:00 3:00 4:00")))
    (setq org-columns-default-format
	  '(("%25ITEM %TODO %3PRIORITY %TAGS")))
    ;; have to add _archive or beorg throws a fit!!! it doesn't work on tags the dumby!
    (setq org-archive-location "~/dhd/org/archive.org_archive::* From %s")


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
    (setq org-agenda-files '("~/dhd/org/"))           ; add files to agenda
    (find-file-noselect "~/Documents/projects/molly/data/matrix-refile.org")
    (setq org-agenda-files (list "~/dhd/org"
				 "~/Documents/projects/molly/data/matrix-refile.org"))
    (with-current-buffer "matrix-refile.org" (auto-revert-mode))



    (setq org-directory "~/dhd/org/")                 ; define generic org capture shit
    (setq org-default-notes-file (concat org-directory "/refile-beorg.org"))))

;; setup special block extras!
(use-package org-special-block-extras
  :ensure t
  :hook (org-mode . org-special-block-extras-mode)
  :custom
    ;; The places where I keep my ‘#+documentation’
    (org-special-block-extras--docs-libraries
     '("~/dhd/org/documentation.org"))
    ;; Disable the in-Emacs fancy-links feature?
    ;; (org-special-block-extras-fancy-links nil)
    ;; Details heading “flash pink” whenever the user hovers over them?
    (org-html-head-extra (concat org-html-head-extra "<style>  summary:hover {background:pink;} </style>"))
    ;; The message prefixing a ‘tweet:url’ badge
    (org-special-block-extras-link-twitter-excitement
     "This looks super neat (•̀ᴗ•́)و:")
  :config
  ;; Use short names like ‘defblock’ instead of the fully qualified name
  ;; ‘org-special-block-extras-defblock’
  (org-special-block-extras-short-names))

;; Set up bullets
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package ob-restclient
  :ensure t
  :after org)

(use-package org-trello
  :ensure t
  :after org
  :config
  (custom-set-variables '(org-trello-files '("~/dhd/org/stjohns-trello.org"))))

;; configure the org protocol
(org-load-modules-maybe t)
(require 'org-protocol)
;; (require 'org-protocol-capture-html)
(setq org-protocol-default-template-key "w")

(setq org-capture-templates
       `(("w" "Web site" entry (file+olp "~/dhd/org/webwiki.org" "links" "unsorted")
	  "* %c :website:\n%U %?%:initial")
	 ;; ... more templates here ...
	 ("b" "Book - capture a book you've read" entry (file+olp "~/dhd/org/webwiki.org" "books")
	  "* %^{TITLE} \n  :PROPERTIES:\n:AUTHOR: %^{AUTHOR}\n:GENRE: %^{GENRE}\n:FINISHED: %U \n:END:\n " :empty-lines 1 :prepend t)
	 ("v" "TV - capture a TV show you've finished. Include season in title like (s01)." entry (file+olp "~/dhd/org/webwiki.org" "tv")
	  "* %^{TITLE} \n  :PROPERTIES:\n:GENRE: %^{GENRE}\n:FINISHED: %U \n:END:\n " :empty-lines 1 :prepend t)
	 ("m" "Movies - capture a movie you've finished" entry (file+olp "~/dhd/org/webwiki.org" "movies")
	  "* %^{TITLE} \n  :PROPERTIES:\n:GENRE: %^{GENRE}\n:FINISHED: %U \n:END:\n " :empty-lines 1 :prepend t)
	 ("g" "Game - capture a game you've finished" entry (file+olp "~/dhd/org/webwiki.org" "games")
	  "* %^{TITLE} \n  :PROPERTIES:\n:PLATFORM: %^{PLATFORM}\n:TAGS: %^{TAGS}\n:MULTIPLAYER: %^{MULTIPLAYER}\n:FINISHED: %U \n:END:\n " :empty-lines 1 :prepend t)	 
	 ("c" "Context-include Todo" entry (file "~/dhd/org/refile-beorg.org")
	  "* TODO %?\n%U \n '%a'" :empty-lines 1 :prepend t)
	 ("q" "quotes" entry (file+olp "~/dhd/org/webwiki.org" "quotes")
	  "* %?\n%U \n " :empty-lines 1 :prepend t)
	 ("t" "Todo" entry (file "~/dhd/org/refile-beorg.org")
	  "* TODO %?\n%U" :empty-lines 1 :prepend t)))

;; configure org exporters
(require 'ox-md)
;; org prettifiers
(setq org-agenda-format-date (lambda (date) (concat "\n"
						    (make-string (window-width) 9472)
						    "\n"
						    (org-agenda-format-date-aligned date))))

;; org mode hack for screenshots; see org mode hacks page.
(defun my-org-screenshot ()
  "Take a screenshot and save a file.
The file is saved into a time stamped unique-named file in the same directory as the buffer.
Then insert a link to this file.reference: https://orgmode.org/worg/org-hacks.html
dependency: this relies on imagemagick"
  (interactive)
  (setq filename
        (concat
         (make-temp-name
          (concat "pictures"
		  (buffer-file-name)
                  "_"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (if (eq system-type 'darwin)
      (shell-command (format "screencapture -i %s" filename))
    (call-process "import" nil nil nil filename))
  (insert (concat "[[" filename "]]"))
  (org-display-inline-images))

(if (eq system-type 'darwin)
    (global-set-key (kbd "C-c C-M-4") 'my-org-screenshot)
  (global-set-key (kbd "C-c C-4") 'my-org-screenshot))


;; force source blocks to respect the proper indentation.
(setq org-src-preserve-indentation nil
      org-edit-src-content-indentation 0)

;; calender integration

(require 'epa)
(when (eq system-type 'darwin)
  (setf epa-pinentry-mode 'loopback))
(setq auth-sources '("~/.emacs.d/jlj-secrets2.gpg"))
(setq auth-source-debug t)

(use-package org-caldav
  :ensure t
  :config
  (setq org-caldav-sync-direction 'cal->org)
  (setq org-caldav-url "https://caldav.fastmail.com/dav/calendars/user/me@jowj.net/")
  (setq org-caldav-calendars
	'((:calendar-id "654a6e55-b777-4603-b009-0058d35aa5ca"
			:inbox "~/dhd/org/fromworkcal.org")))
  (setq org-icalendar-timezone "America/Chicago"))


;;; jlj-org.el ends here

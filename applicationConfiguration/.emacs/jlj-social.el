;; This is such a pain in the dick. Its really nice to be able to chat within emacs
;; - but i think i regret not using weechat 

;; The bit about ~;(setf epa-pinentry-mode 'loopback)~ is important:
;; - uncomment if you want to only use emacs to input/manage the gpg key
;; - comment out if you want gpg to be handled through seahorse/gnome keyring.

;; (when (eq system-type 'darwin)
;;   (setf epa-pinentry-mode 'loopback))
;; (use-package znc
;;   :ensure t
;;   :config
;;   (progn
;;     (custom-set-variables '(epg-gpg-program  "/usr/local/bin/gpg"))
;;     (setq auth-sources `("~/Documents/projects/agares/applicationConfiguration/.emacs/jlj-secrets.gpg"))

;;     (require 'epa)

;;     ;; handle annoying gpg shit.
;;     (defun lookup-password (host user port)
;;       "Lookup encrypted password given HOST, USER and PORT for service."
;;       (require 'auth-source)
;;       (funcall (plist-get
;; 		(car (auth-source-search
;; 		      :host host
;; 		      :user user
;; 		      :type 'netrc
;; 		      :port port))
;; 		:secret)))

;;     (setq znc-password(lookup-password "bouncer.awful.club" "blindidiotgod/OFTC" 5000))

;;     ;; by default, erc alerts you on any activity. I only want to hear
;;     ;; about mentions of nick or keyword
;;     (custom-set-variables
;;      '(znc-servers
;;        `(("bouncer.awful.club" 5000 t
;; 	  ((freenode "blindidiotgod/freenode" ,znc-password)
;; 	   (OFTC "blindidiotgod/OFTC" ,znc-password))))))
;;      (setq erc-current-nick-highlight-type 'all)
;;      (setq erc-keywords '("security"))
;;      (setq erc-track-exclude-types '("JOIN" "PART" "NICK" "MODE" "QUIT"))
;;      (setq erc-track-use-faces t)
;;      (setq erc-track-faces-priority-list
;; 	   '(erc-current-nick-face erc-keyword-face))
;;      (setq erc-track-priority-faces-only 'all)
;;      (setq erc-hide-list '("PART" "QUIT" "JOIN"))
;;      (setq erc-join-buffer 'bury)))


;; the only thing that isn't pretty much stock is
;; - i rebound C-c C-o to open links, so it would mimic org-mode's layout.

(use-package twittering-mode
  :ensure t
  :config
  (progn
    (setq twittering-icon-mode t)
    (setq twittering-reverse-mode t)
    (setq twittering-enable-unread-status-notifier t)
    (with-eval-after-load "twittering-mode" (define-key twittering-mode-map (kbd "C-c C-o") `twittering-view-user-page))))
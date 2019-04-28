;;;; example 'join these servers' commands.

(require 'epa)


;; handle annoying gpg shit.
(defun lookup-password (host user port)
  "Lookup encrypted password given HOST, USER and PORT for service."
  (require 'auth-source)
  (funcall (plist-get
            (car (auth-source-search
		  :host host
		  :user user
		  :type 'netrc
		  :port port))
            :secret)))

(setq znc-password(lookup-password "bouncer.awful.club" "blindidiotgod/OFTC" 5000))

;; by default, erc alerts you on any activity. I only want to hear
;; about mentions of nick or keyword
(require 'znc)
(custom-set-variables
 '(znc-servers
   `(("bouncer.awful.club" 5000 t
      ((freenode "blindidiotgod/freenode" ,znc-password)
       (OFTC "blindidiotgod/OFTC" ,znc-password))))))
(setq erc-current-nick-highlight-type 'all)
(setq erc-keywords '("security"))
(setq erc-track-exclude-types '("JOIN" "PART" "NICK" "MODE" "QUIT"))
(setq erc-track-use-faces t)
(setq erc-track-faces-priority-list
      '(erc-current-nick-face erc-keyword-face))
(setq erc-track-priority-faces-only 'all)
(setq erc-hide-list '("PART" "QUIT" "JOIN"))
(setq erc-join-buffer 'bury)

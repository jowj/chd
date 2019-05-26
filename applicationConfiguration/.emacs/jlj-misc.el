;;;; global settings, emacs-wide stuff

;; Set global vars
(setq inhibit-splash-screen t)       ; Disable the splash screen (to enable it agin, replace the t with 0)
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode)); show line numbers; use this instead of linum if you can because FUCK linum sucks

(global-visual-line-mode t)          ; turn on word-wrap globally (probably a mistake, but wanted for org-mode)
(menu-bar-mode -1)                   ; disable visual menu on emacs
(tool-bar-mode -1)
(setq indent-tabs-mode nil)          ; always use spaces, not tabs, when indenting
(setq case-fold-search t)            ; ignore case when searching

;; require final newlines in files when they are saved
(setq require-final-newline t)

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta) ; deal with mac command key problems:
  ;; Make emacs use a different default than the OS
  ;; only really useful on work computers, but there we go.
  (setq browse-url-browser-function #'browse-url-generic
	browse-url-generic-program "open"
	browse-url-generic-args '("-a" "Firefox")))

(if (eq system-type 'windows-nt)
    (message "i am windows and suck") ; deal with mac command key problems
  (exec-path-from-shell-copy-env "PATH"))

(setq backup-directory-alist `(("." . "~/Nextcloud/Documents/org/.saves"))) ; deal with bullshit files in every dir.
(set-frame-font "Consolas 12")                                  ; set default font,  versions of emacs may require set-default-font

(setq user-init-file "~/Documents/projects/agares/applicationConfiguration/.emacs/init.el") ;set default init file to agares
(find-file "~/Nextcloud/Documents/org/personal.org")                           ;open primary org file on launch
(transient-mark-mode 1)                                            ; Enable transient mark mode

;; custom emacsland functions
(defun find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-other-window user-init-file))
(global-set-key (kbd "C-c J") 'find-user-init-file)

;; Custom frame management chords
(global-set-key (kbd "C-x O") 'other-frame)
(global-set-key (kbd "C-x T") 'make-frame-command)
(global-set-key (kbd "C-x W") 'delete-frame)


;; eshell configuration
;; -------------------------------------
(setq eshell-prompt-function
  (lambda ()
    (concat (format-time-string "%H:%M:%S" (current-time))
      (if (= (user-uid) 0) " ☭  " " ǰ "))))

;; Multiple Cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; twittering-mode
(setq twittering-icon-mode t)
(setq twittering-reverse-mode t)
(setq twittering-enable-unread-status-notifier t)
(with-eval-after-load "twittering-mode" (define-key twittering-mode-map (kbd "C-c C-o") `twittering-view-user-page))

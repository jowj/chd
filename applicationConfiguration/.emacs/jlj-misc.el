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
  (setq mac-command-modifier 'meta)) ; deal with mac command key problems:

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
(global-set-key (kbd "C-c I") 'find-user-init-file)

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

;; shell confs
(exec-path-from-shell-copy-env "PATH") ; copy PATH from shell

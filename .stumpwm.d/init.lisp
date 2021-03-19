;; -*- lisp -*-
(in-package :stumpwm)

;; hide the idiot laptop window
(run-shell-command "xrandr --output HDMI-1 --mode 2560x1440 --pos 0x0 --rotate normal --primary --output DP-1 --off  --output DP-4 --off  --output DP-0 --off --output eDP-1 --off")

;; mode line
(stumpwm:set-fg-color "green")
(stumpwm:set-bg-color "black")

(setf *window-format* "%m%n%s%c")
(setf *screen-mode-line-format* (list "[^B%n^b] %W^>%d"))
;; enable-mode-line takes 3 args; screen, head, and state.
;; state is just "t" if you want it on, i guess. lol. surely that's implied!!! by the func name!!!
(stumpwm:enable-mode-line (stumpwm:current-screen)
                          (stumpwm:current-head)
			  t)

;; sane defaults, you morons

(setf *message-window-gravity* :bottom-right)
(setf *input-window-gravity* :center)
(setf *mouse-focus-policy* :click)
;set my prefix key to be reasonable
(set-prefix-key (kbd "C-M-S-s-SPC"))


;; group config
(grename "www")
(gnewbg "term")
(gnewbg "emc")
(gnewbg "mail")
(gnewbg "comms")

;; (defun jlj/rofi
;;     "just runs rofi for me :)"
;;     (run-shell-command "rofi -show combi"))

(defcommand jlj/rofi () ()
  "Start Emacs or switch to it, if it is already running."
  (run-shell-command "rofi -combi-modi window,drun,ssh -theme purple -font 'hack 10' -show combi"))

(define-key *root-map* (kbd "R") "restart-hard")
(define-key *top-map* (kbd "M-SPC") "jlj/rofi")

;; group management
;;;; note that this is still the hyper key, its just that shift + 1 = !, etc.
(define-key *top-map* (kbd "C-M-s-!") "gselect 1")
(define-key *top-map* (kbd "C-M-s-@") "gselect 2")
(define-key *top-map* (kbd "C-M-s-#") "gselect 3")
(define-key *top-map* (kbd "C-M-s-$") "gselect 4")
(define-key *top-map* (kbd "C-M-s-%") "gselect 5")

;; ok only one of these definitely did not work, the fucker
(define-key *top-map* (kbd "C-M-s-f") "fullscreen")
(define-key *top-map* (kbd "C-M-s-F") "fullscreen")

;; app menu keys
;;;; you defcommands as wrapper to running/raising/shelling out, so you can call it later.
(defcommand firefox () ()
  "Start Firefox or switch to it, if it is already running."
  (run-or-raise "firefox" '(:class "Firefox")))

(defcommand mail () ()
  "Start fastmail or switch to it, if it is already running."
  (run-or-raise "fastmail" '(:class "Fastmail")))

(defcommand terminal () ()
  "Start gnome-terminal or switch to it, if it is already running."
  (run-or-raise "gnome-terminal" '(:class "Terminal")))

(defcommand element () ()
  "Start gnome-terminal or switch to it, if it is already running."
  (run-or-raise "element-desktop" '(:class "Element")))

(define-key *root-map* (kbd "f") "firefox")
(define-key *root-map* (kbd "m") "mail")
(define-key *root-map* (kbd "t") "terminal")
(define-key *root-map* (kbd "r") "element")


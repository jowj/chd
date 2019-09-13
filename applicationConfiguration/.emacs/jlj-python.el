;; pylint is required (pip install pylint)
;; pep8 (pip install pep8)
;; don't use python-mode because JESUS. CHRIST. it throws everything off.
;; using jedi requires virtualenv to be installed
;; pipenv is mostly acceptable but i could not make a full IDE experience happen

;; (use-package pylint
;;   :ensure t)


;; (setq python-shell-interpreter "/usr/local/bin/python3"
;;       python-shell-interpreter-args "-i")

;; (use-package py-autopep8
;;   :ensure t
;;   :config
;;   (progn
;;     (add-hook 'python-mode-hook 'py-autopep8-enable-on-save)))

;; (use-package jedi
;;   :ensure t
;;   :init
;;   (add-hook 'python-mode-hook 'jedi:setup)
;;   (add-hook 'python-mode-hook 'jedi:ac-setup))

(use-package pipenv
  :ensure t)

(use-package eglot
  :ensure t
  :config
    (add-hook 'python-mode-hook 'eglot-ensure))

;; (use-package pyvenv
;;   :ensure t)

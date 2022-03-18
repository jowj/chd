;;; jlj-python.el --- python customizations -*- lexical-binding: t -*-
;;; Commentary:

;; pylint is required (pip install pylint)
;; pep8 (pip install pep8)
;; don't use python-mode because JESUS.  CHRIST.  it throws everything off.
;; using jedi requires virtualenv to be installed
;; pipenv is mostly acceptable but i could not make a full IDE experience happen

;;; Code:
;; Initialise installed packages



(use-package pipenv
  :ensure t)

(use-package poetry
 :ensure t)

(use-package flycheck
  :ensure t)

; helps with LSP, generally.
(yas-global-mode 1)

; Let's set up company! perhaps not necessary but this is what i like to use
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))

(use-package project :ensure t)

(use-package eglot
  :ensure t
  :config
  (add-hook 'python-mode-hook 'eglot-ensure))

;; (use-package pyvenv
;;   :ensure t)
(use-package virtualenvwrapper
  :ensure t
  :config
  (venv-initialize-interactive-shells) ;; if you want interactive shell support
  (venv-initialize-eshell) ;; if you want eshell support
  (setq venv-location "~/.local/share/virtualenvs/"))

;;; jlj-python.el ends here

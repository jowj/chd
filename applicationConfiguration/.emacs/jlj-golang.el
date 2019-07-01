;; this is an intermediary golang config. my goals are to:
;; - have gofmt run on save
;; - have good syntax highlighting
;; - compile, test, run gocode through emacs:

(use-package go-eldoc
  :ensure)

(use-package gotest
  :ensure)

(use-package company-go
  :ensure)

(use-package go-guru
  :ensure)

(use-package go-mode
  :init
  :ensure t
  :config
  (add-hook 'before-save-hook #'gofmt-before-save)

  ;; stolen from luipan.pl/dotemacs/
  (defun jlj-go-mode-hook ()
    (go-eldoc-setup)
    (set (make-local-variable 'company-backends) '(company-go))
    (company-mode)
    ;; Customize compile command to run go build

    (let ((goimports (executable-find "goimports")))
      (when goimports
	(setq gofmt-command goimports)))
    
    (smartparens-mode 1)
    (flycheck-mode 1)
    (setq imenu-generic-expression
          '(("type" "^type *\\([^ \t\n\r\f]*\\)" 1)
            ("func" "^func *\\(.*\\) {" 1))))

    (setq compile-command "echo Building... && go build -v && go test -v && go vet")
  (add-hook 'go-mode-hook 'jlj-go-mode-hook))

(with-eval-after-load "go-mode" (define-key go-mode-map (kbd "C-c C-c") 'compile))

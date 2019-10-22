(use-package eglot
  :ensure t
  :config
  (add-hook 'go-mode-hook 'eglot-ensure)
  (local-set-key "\C-x\C-m" 'compile)
  (setq compile-command "go test -v && go vet && golint"))

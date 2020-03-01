(use-package lsp-mode
  :ensure t
  :config
  (add-hook 'go-mode-hook 'lsp-ensure)
  (local-set-key "\C-x\C-m" 'compile)
  (setq compile-command "go test -v && go vet && golint"))

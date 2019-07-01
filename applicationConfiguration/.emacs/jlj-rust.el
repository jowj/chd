(use-package rust-mode
  :ensure t
  :config
  (progn
    (add-hook 'rust-mode-hook 'cargo-minor-mode)
    (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
    (add-hook 'rust-mode-hook
	      (lambda ()
		(local-set-key (kbd "C-c <tab>") #'rust-format-buffer)))

    (setq racer-cmd "~/.cargo/bin/racer") ;; Rustup binaries PATH
    (setq racer-rust-src-path "~/gitshit/rust/src") ;; Rust source code PATH

    (add-hook 'rust-mode-hook #'racer-mode)
    (add-hook 'racer-mode-hook #'eldoc-mode)
    (add-hook 'racer-mode-hook #'company-mode)))

(use-package flycheck-rust
  :ensure t)

(use-package racer
  :ensure t)

(defun helm-surfraw-duck (x)
  "Search duckduckgo in default browser"
  (interactive "sSEARCH:")
  (helm-surfraw x "duckduckgo" ))
(global-set-key (kbd "C-c s") 'helm-surfraw-duck)


(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(setq doc-view-ghostscript-program "C:/Program Files/gs/gs9.27/bin/gswin64c.exe")
(setq lsp-java-server-install-dir "C:/Users/gvgam/dev/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/")
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (java-snippets flycheck lsp-ui company-lsp yasnippet lsp-java latex-preview-pane cyberpunk-theme evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(require 'evil)
(require 'yasnippet)
(require 'flycheck)
(require 'flymake)
(yas-global-mode 1)
(evil-mode 1)
(load-theme 'cyberpunk t)

(latex-preview-pane-enable)
(require 'company-lsp)
(require 'lsp-java)
(require 'lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)
(add-hook 'java-mode-hook #'lsp)
(add-hook 'lsp-mode-hook 'flycheck-mode)
(setq lsp-ui-flycheck-enable t)
(setq lsp-ui-sideline-show-hover t)
(add-hook 'java-mode-hook #'lsp-ui-sideline-mode)
(add-hook 'java-mode-hook #'yas-minor-mode)


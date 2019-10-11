(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(setq is-windows (or (string= "windows-nt" system-type)
			  (string= "msdos" system-type)))
(setq is-linux (or (string= "gnu/linux" system-type)))

(setq is-mac (or (string= "darwin" system-type)))
(setq frame-resize-pixelwise t)
(windmove-default-keybindings)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-hl-line-mode)
(electric-pair-mode 1)
(setq inhibit-startup-screen t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("1a094b79734450a146b0c43afb6c669045d7a8a5c28bc0210aba28d36f85d86f" "f6f5d5adce1f9a764855c9730e4c3ef3f90357313c1cae29e7c191ba1026bc15" default)))
 '(package-selected-packages
   (quote
    (ac-emacs-eclim auto-complete company-emacs-eclim eclim no-littering treemacs-evil treemacs color-theme-modern base16-theme java-snippets flycheck lsp-ui company-lsp yasnippet lsp-java latex-preview-pane cyberpunk-theme evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(setq no-littering-etc-directory
      (expand-file-name "config/" user-emacs-directory))
(setq no-littering-var-directory
      (expand-file-name "data/" user-emacs-directory))
(require 'no-littering)
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

;;OS Specific config
(when is-windows
    (setq doc-view-ghostscript-program "C:/Program Files/gs/gs9.27/bin/gswin64c.exe")
    (setq lsp-java-server-install-dir "C:/Users/gvgam/dev/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/"))
(when is-mac
    (setq doc-view-ghostscript-program "/usr/local/bin/gsc")
    (setq lsp-java-server-install-dir "~/dev/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/")
    (setq mac-command-modifier 'meta))
(require 'evil)
(require 'yasnippet)
(require 'flycheck)
(require 'flymake)
(require 'company-lsp)
(require 'treemacs)
(yas-global-mode 1)
(evil-mode 1)
;;(load-theme 'cyberpunk t)
(load-theme 'calm-forest)

;;LaTeX
(latex-preview-pane-enable)

;;Java
(defun my-eclim-fix-relative-path (path)
  (replace-regexp-in-string "^.*src/" "src/" path))
(advice-add 'eclim--project-current-file :filter-return #'my-eclim-fix-relative-path)
(require 'eclim)
(setq eclimd-autostart t)
(add-hook 'java-mode-hook (lambda() (eclim-mode t)))
(require 'company-emacs-eclim)
(company-emacs-eclim-setup)
(global-company-mode t)
;;(require 'lsp-java)
(require 'lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)
;;(add-hook 'java-mode-hook #'lsp)
(add-hook 'lsp-mode-hook 'flycheck-mode)
(setq lsp-ui-flycheck-enable t)
(setq lsp-ui-sideline-show-hover t)
(add-hook 'java-mode-hook #'lsp-ui-sideline-mode)
(add-hook 'java-mode-hook #'yas-minor-mode)


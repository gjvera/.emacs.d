(require 'package)
(package-initialize)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'load-path "~/.emacs.d/custom-plugins/")
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
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(evil-commentary-mode)
(require 'evil-surround)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8e04544d71b7de9289a258b5ae555226308384cb2444b5e9166ec9e2173520bc" "b393166cc4672666d671a77058da6f3e74a8e56ca6764316f588ff91dbeba54d" "1a094b79734450a146b0c43afb6c669045d7a8a5c28bc0210aba28d36f85d86f" "f6f5d5adce1f9a764855c9730e4c3ef3f90357313c1cae29e7c191ba1026bc15" default)))
 '(line-number-mode t)
 '(package-selected-packages
   (quote
    (powerline-evil magit json-mode helm gnu-elpa-keyring-update typescript-mode evil-surround evil-commentary ac-emacs-eclim auto-complete company-emacs-eclim eclim no-littering treemacs-evil treemacs color-theme-modern base16-theme java-snippets flycheck lsp-ui company-lsp yasnippet lsp-java latex-preview-pane cyberpunk-theme evil))))
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
    (setq mac-command-modifier 'meta)
    (add-to-list 'default-frame-alist '(ns-appearance . dark))
    (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t)))
(require 'evil)
(require 'yasnippet)
(require 'flycheck)
(require 'flymake)
(require 'company-lsp)
(require 'treemacs)
(require 'cl)
(require 'powerline)
(require 'evil-leader)
(yas-global-mode 1)
(global-evil-leader-mode)
(evil-mode 1)
(global-evil-surround-mode 1)
(evil-leader/set-leader"<SPC>")
(evil-leader/set-key
 "e" 'find-file
 "b" 'switch-to-buffer
 "k" 'kill-buffer
 "tr" 'treemacs-refresh)

(setq custom-theme-directory "~/.emacs.d/custom-plugins")
(load-theme 'synthwave)

;;LaTeX
(latex-preview-pane-enable)
(lsp-register-client
 (make-lsp-client :new-connection (lsp-stdio-connection "digestif")
                  :major-modes '(latex-mode plain-tex-mode)
                  :server-id 'digestif))
(add-to-list 'lsp-language-id-configuration '(latex-mode . "latex"))
(add-to-list 'lsp-language-id-configuration '(plain-tex-mode . "plaintex"))
(add-to-list 'company-lsp-filter-candidates '(digestif . nil))

;;Typescript/Javascript
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
(add-hook 'js-mode-hook #'lsp)
(add-hook 'typescript-mode-hook #'lsp)
(add-hook 'lsp-mode-hook 'flycheck-mode)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)
(add-hook 'lsp-mode-hook #'lsp-ui-sideline-mode)

;;Java
(defun my-eclim-fix-relative-path (path)
  (replace-regexp-in-string "^.*src/" "src/" path))
(advice-add 'eclim--project-current-file :filter-return #'my-eclim-fix-relative-path)
(require 'eclim)
(setq eclimd-autostart t)
(add-hook 'java-mode-hook (lambda() (eclim-mode t)))
(require 'company-emacs-eclim)
(require 'google-java-format)
(company-emacs-eclim-setup)
(global-company-mode t)
(require 'flycheck-eclim)
(require 'lsp-ui)
(add-hook 'java-mode-hook 'lsp-ui-mode)
(add-hook 'java-mode-hook 'flycheck-mode)
(setq lsp-ui-flycheck-enable t)
(setq lsp-ui-sideline-show-hover t)
(add-hook 'java-mode-hook #'lsp-ui-sideline-mode)
(add-hook 'java-mode-hook #'yas-minor-mode)

;;XML
(add-hook 'nXML-mode-hook #'lsp)

(defadvice switch-to-buffer (before save-buffer-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice other-window (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-up (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-down (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-left (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-right (before other-window-now activate)
  (when buffer-file-name (save-buffer)))

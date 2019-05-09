;;; package --- Summary
;;; Commentary:
;;; Code:
(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

;; Hide toolbar and menubar
(tool-bar-mode -1)
(menu-bar-mode -1)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(use-package markdown-mode
  :ensure t)

(use-package helm
  :ensure t
  :config (helm-mode 1))
(require 'helm-config)

(use-package smooth-scrolling
  :ensure t)

(use-package solarized-theme
  :ensure t
  :config (load-theme 'solarized-light t))

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(use-package evil
  :ensure t
  :config (evil-mode t))

(use-package autopair
  :ensure t)

(use-package auto-complete
  :ensure t
  :config (setq ac-dwim t)
  (ac-config-default)
  (setq ac-sources '(ac-source-yasnippet
		     ac-source-abbrev
		     ac-source-words-in-same-mode-buffers)))

(use-package powerline
  :ensure t
  :init (powerline-default-theme))

(use-package flycheck
  :ensure t
  :config (global-flycheck-mode 1))

(use-package elpy
  :ensure t
  :init (elpy-enable)
  :config (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(use-package py-autopep8
  :ensure t
  :config (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save))

(require 'ido)
(use-package ido
  :ensure t
  :config (setq ido-enable-flex-matching t)
  (ido-mode 1))

(use-package smex
  :ensure t
  :config (setq smex-save-file (expand-file-name ".smex-items" user-emacs-directory))
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands))

(use-package reftex
  :ensure t
  :config (setq reftex-toc-split-windows-horizontally 1)
  (setq reftex-toc-keep-other-windows 1))

(use-package auctex
  :defer t
  :ensure t
  :config (setq reftex-plug-into-AUCTeX t))

(use-package auctex-latexmk
  :ensure t
  :init
  (with-eval-after-load 'tex
    (auctex-latexmk-setup))
  :config
  (setq TeX-command-default "LatexMk"))

(require 'yasnippet)
(use-package yasnippet                  ; Snippets
  :ensure t
  :config (yas-reload-all)
  (yas-global-mode))

(use-package yasnippet-snippets         ; Collection of snippets
  :ensure t)

(use-package org
  :ensure t
  :bind (("C-c l" . org-store-link)
	 ("C-c a" . org-agenda))
  :config (setq org-log-done t))

(use-package flymd
  :ensure t)

;; Tree like file menu (toggle with f8)
(use-package neotree
  :ensure t
  :config (global-set-key [f8] 'neotree-toggle)
  (setq neo-smart-open t)
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

;; Beautiful icons for the neotree package
;; Run: M-x all-the-icons-install-fonts
(use-package all-the-icons
  :ensure t)

(use-package flyspell
  :ensure t
  :commands flyspell-mode
  :init (progn
	  (setq ispell-program-name "aspell")
	  (setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_GB")))
  :config (flyspell-mode)
  (setq flyspell-issue-message-flag nil)
  (add-hook 'org-mode-hook 'flyspell-buffer)
  (add-hook 'markdown-mode-hook 'flyspell-buffer)
  (add-hook 'LaTeX-mode-hook 'flyspell-buffer)
  (add-hook 'python-mode-hook 'flyspell-prog-mode))

(setq org-agenda-files (list "~/Documents/Dropbox/org/schedule.org"))

(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t
        auto-package-update-interval 4)
  (auto-package-update-maybe))

;; Enable clipboard integration
(delete-selection-mode t)
(transient-mark-mode t)
(setq select-enable-clipboard t)
(setq select-enable-primary t)

;; Indicate empty lines
(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

;; Set tab width
(setq tab-width 4
      indent-tabs-mode nil)

;; Hide the splash screen
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)

;; Auto-indent
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Remember position
(save-place-mode 1)

;; Remember history
(savehist-mode 1)

;; Show matching bracket
(show-paren-mode 1)

;; Display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;; Show line numbers
(global-linum-mode)

(setq initial-scratch-message "")         ; Make *scratch* buffer blank
(setq-default frame-title-format '("%b")) ; Make window title the buffer name
(fset 'yes-or-no-p 'y-or-n-p)             ; y-or-n-p makes answering questions faster

(require 'undo-tree)
(use-package undo-tree                    ; Enable undo-tree, sane undo/redo behavior
  :ensure t
  :config (global-undo-tree-mode))

;; Some settings from the better defaults package
(setq save-interprogram-paste-before-kill t
      mouse-yank-at-point t ; paste at point instead of cursor position
      require-final-newline t
      load-prefer-newer t)

(provide 'emacs)
;;; .emacs ends here

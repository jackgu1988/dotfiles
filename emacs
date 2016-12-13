(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(yas-global-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auctex-latexmk-inherit-TeX-PDF-mode (quote T))
 '(custom-enabled-themes (quote (dracula)))
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "eb0a314ac9f75a2bf6ed53563b5d28b563eeba938f8433f6d1db781a47da1366" default)))
 '(package-selected-packages
   (quote
    (sr-speedbar auctex-latexmk neotree smart-mode-line twittering-mode pdf-tools latex-preview-pane auto-complete-auctex auto-complete auctex yasnippet dracula-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; smart-mode-line config
(setq sml/theme 'dark)
(sml/setup)

;; Neotree config
(global-set-key [f8] 'neotree-toggle)

;; line numbers
(global-linum-mode t)

;; don't show welcome screen
(setq inhibit-startup-screen t)

;; LaTeX preview pane by default
(latex-preview-pane-enable)
(pdf-tools-install)

(require 'auctex-latexmk)
(auctex-latexmk-setup)
(setq auctex-latexmk-inherit-TeX-PDF-mode t)

(add-hook 'LaTeX-mode-hook (lambda ()
			     (TeX-global-PDF-mode t)
			     (setq TeX-master (guess-TeX-master (buffer-file-name)))
			     ))

;; Format code with F9
(defun indent-buffer ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))
(global-set-key [f9] 'indent-buffer)

(defun guess-TeX-master (filename)
  "Guess the master file for FILENAME from currently open .tex files."
  (let ((candidate nil)
	(filename (file-name-nondirectory filename)))
    (save-excursion
      (dolist (buffer (buffer-list))
	(with-current-buffer buffer
	  (let ((name (buffer-name))
		(file buffer-file-name))
	    (if (and file (string-match "\\.tex$" file))
		(progn
		  (goto-char (point-min))
		  (if (re-search-forward (concat "\\\\input{" filename "}") nil t)
		      (setq candidate file))
		  (if (re-search-forward (concat "\\\\include{" (file-name-sans-extension filename) "}") nil t)
		      (setq candidate file))))))))
    (if candidate
	(message "TeX master document: %s" (file-name-nondirectory candidate)))
    candidate))

;; Remember history
(savehist-mode 1)
(setq savehist-additional-variables '(kill-ring search-ring regexp-search-ring))

;; Remember position
(save-place-mode 1)

;; Twitter
(setq twittering-icon-mode t)
(setq twittering-use-master-password t)

;; Cursor
(setq-default cursor-type 'bar)

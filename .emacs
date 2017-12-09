;; start server if not running
(require 'server)
(unless (server-running-p)
  (server-start))

;; MELPA support
(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; ADDED by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)


(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;; yasnippet
(add-to-list 'load-path
	     "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;; Add company-irony to company-backends
(eval-after-load 'company
    '(add-to-list 'company-backends 'company-irony))

;; Set font size (it's 1/10 pt)
;(set-face-attribute 'default nil :height 300)

;; Disable menu bar
;; (menu-bar-mode -1)

;; Show line numbers
(global-linum-mode t)

;; set tab-width
(setq-default tab-width 4)

;;;;;;;;;;;;;;;;;;;;;
;; --- PACKAGES ;;;;;
;;;;;;;;;;;;;;;;;;;;;
;; Deft
(require 'deft)
;; 
(setq deft-recursive t)
(setq deft-directory "/mnt/internal/Data/PersonalFolder/Documents/Notes/DeftNotes/")
(setq deft-use-filename-as-title t)
(setq deft-use-filter-string-for-filename t)

;; Auto complete
(ac-config-default)

;; Auto pair mode
(electric-pair-mode)

;; Apply the linux style for parenthesis instead of default gnu style
(setq c-default-style "linux"
                c-basic-offset 4)  

;; dumb-jump
(dumb-jump-mode)

;; enable company mode[B]
(add-hook 'after-init-hook 'global-company-mode)


;; irony-mode for c/c++ smart autocompletion
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;;;;;;;;;;;;;;;;;;;;;;;;;
;; PERSONAL FUNCTIONS AND KEY BINDINGS;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;; To copy the whole line into the buffer
(defun copy-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank))
(global-set-key (kbd "C-M-k") 'copy-line)

;; Modified keybindings; C-k kill the whole line instead of from cursor position to end of line
(global-set-key (kbd "C-k") 'kill-whole-line)

;; To quickly switch between myfile.cc and myfile.h with C-c o. Note the use of the c-mode-common-hook, so it will work for both C and C++.
;; Actually defined directly under 'c-mode-common-hook variable
;;(add-hook 'c-mode-common-hook '(lambda() (local-set-key (kbd "C-c o") 'ff-find-other-file)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; OPTIONS SAVED USING EMACS SAVE OPTIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-mode-common-hook
   (quote
	(ac-cc-mode-setup
	 (lambda nil
	   (local-set-key
		(kbd "C-c o")
		(quote ff-find-other-file))))))
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "46e88f221595fe2091fe695410df6d1bcad7166557810817319cb40018c1e626" default)))
 '(font-use-system-font f)
 '(package-selected-packages
   (quote
	(pdf-tools yasnippet-snippets yasnippet company-irony irony dumb-jump whole-line-or-region spacemacs-theme ##)))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Droid Sans Mono" :foundry "1ASC" :slant normal :weight normal :height 171 :width normal)))))


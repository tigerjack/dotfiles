;; add MELPA support
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; ADDED by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "46e88f221595fe2091fe695410df6d1bcad7166557810817319cb40018c1e626" default)))
 '(font-use-system-font t)
 '(package-selected-packages (quote (whole-line-or-region spacemacs-theme ##))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") 

;; Set font size (it's 1/10 pt)
(set-face-attribute 'default nil :height 200)

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

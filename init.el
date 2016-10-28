; copied from
; https://sam217pa.github.io/2016/09/02/how-to-build-your-own-spacemacs/
(setq delete-old-versions -1 )		; delete excess backup versions silently
(setq version-control t )		; use version control
(setq vc-make-backup-files t )		; make backups file even when in version controlled dir
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")) ) ; which directory to put backups file
(setq vc-follow-symlinks t )				       ; don't ask for confirmation when opening symlinked file
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)) ) ;transform backups file name
(setq inhibit-startup-screen t )	; inhibit useless and old-school startup screen
(setq ring-bell-function 'ignore )	; silent bell when you make a mistake
(setq coding-system-for-read 'utf-8 )	; use utf-8 by default
(setq coding-system-for-write 'utf-8 )
(setq sentence-end-double-space nil)	; sentence SHOULD end with only a point.
(setq default-fill-column 80)		; toggle wrapping text at the 80th character
(setq select-enable-clipboard nil)
; (setq initial-scratch-message "Welcome in Emacs") ; print a default message in the empty scratch buffer opened at startup

(setq undo-tree-history-directory-alist '(((expand-file-name "." . "~/.emacs.d/undo"))))

(xterm-mouse-mode)

(require 'package)

(setq package-enable-at-startup nil) ; tells emacs not to load any packages before starting up
;; the following lines tell emacs where on the internet to look up
;; for new packages.
(setq package-archives '(("org"       . "http://orgmode.org/elpa/")
                         ("gnu"       . "http://elpa.gnu.org/packages/")
                         ("melpa"     . "https://melpa.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package) ; unless it is already installed
  (package-refresh-contents) ; updage packages archive
  (package-install 'use-package)) ; and install the most recent version of use-package

(require 'use-package) ; guess what this one does too ?

(use-package general
  :ensure t
  :config
  (general-define-key "C-'" 'avy-goto-word-1)
  )

(use-package avy
  :ensure t
  :commands (avy-goto-word-1)
  )


(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (fset 'evil-visual-update-x-selection 'ignore)
  (define-key evil-normal-state-map "Y" 'copy-to-end-of-line)
  )

(use-package evil-nerd-commenter
  :ensure t
  :config
  ;; recreate tcomment plugin behavior: gc<motion> to comment/uncomment stuff
  ;; http://www.vim.org/scripts/script.php?script_id=1173
  (define-key evil-normal-state-map "gc" 'evilnc-comment-operator)
  )

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode 1)
  )

(require 'ido)
(ido-mode 1)
(add-to-list 'evil-emacs-state-modes 'ido-everywhere)
(setq ido-use-filename-at-point 'guess)


;; (use-package projectile
;;   :ensure t
;;   :init
;;   (add-to-list 'evil-emacs-state-modes 'projectile-mode)
;;   )

;; Some more doc about evil: http://blog.aaronbieber.com/2016/01/23/living-in-evil.html
;; and the repo with all the details: https://github.com/aaronbieber/dotfiles/tree/master/configs/emacs.d

;; bunch of evil mode mappings:
;; https://github.com/mbriggs/.emacs.d-oldv2/blob/master/init/init-keymaps.el


;; gigantic list of packages
;; https://github.com/emacs-tw/awesome-emacs

;; (use-package simpleclip
;;   :ensure t
;;   :config
;;   (simpleclip-mode 1)
;;   )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (general use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("gnu" . "https://elpa.gnu.org/packages/") t)
(package-initialize)

(defvar my-packages '(;; Standard Packages
                      better-defaults
                      projectile
                      helm-projectile
                      undo-tree
                      key-chord
                      evil-terminal-cursor-changer
                      use-package
                      company
                      rainbow-delimiters
                      avy
                      spaceline
                      exec-path-from-shell
                      flycheck
                      flycheck-pos-tip
                      powerline
                      helm
                      helm-ag
                      winum
                      dumb-jump
                      yasnippet
                      yasnippet-snippets
                      

                      ;; Theme
                      gruvbox-theme
                      material-theme

                      ;; Version Control
                      magit
                      evil-magit

                      ;; lisp
                      lispy

                      ;; Clojure
                      clojure-mode
                      cider
                      clj-refactor
                      flycheck-clj-kondo
                      helm-cider

                      ;; Golang
                      go-mode
                      go-eldoc

                      ;; Common Lisp
		      slime
		      ))

(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))


;;;;;;;;;;;;;;;;;;;;;;;; Standard Setup ;;;;;;;;;;;;;;;;;;;;;;;;
(require 'better-defaults)
(add-to-list 'load-path "~/.emacs.dOLD/lisp")
(add-to-list 'load-path "~/.emacs.dOLD/lisp/airline-themes")
(add-to-list 'load-path "~/.emacs.dOLD/evil")
(require 'evil)
(require 'evil-leader)

(desktop-save-mode 1)
(global-linum-mode t)
(global-hl-line-mode 1)
(dumb-jump-mode)

;;;;; jk esc
(require 'key-chord)
(key-chord-mode 1)
(key-chord-define evil-insert-state-map  "jk" 'evil-normal-state)

;;;;; Path
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;;;;; Shortcuts
; Setting up winum
(require 'winum)
(winum-mode)
(evil-leader/set-key
  "0" 'winum-select-window-0
  "1" 'winum-select-window-1
  "2" 'winum-select-window-2
  "3" 'winum-select-window-3
  "4" 'winum-select-window-4
  "5" 'winum-select-window-5
  "6" 'winum-select-window-6
  "7" 'winum-select-window-7
  "8" 'winum-select-window-8
  "9" 'winum-select-window-9)

(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
(evil-mode 1)
(evil-leader/set-key
  "o" 'helm-find-files
  "e" 'eval-expression
  "r" 'helm-M-x
  "jc" 'avy-goto-char
  "jj" 'avy-goto-word-1
  "g" 'helm-do-ag
  "ls" (lambda () (interactive) (split-window-below) (windmove-down) (window-resize nil -15) (term "/bin/bash"))
  "bs" 'helm-mini
  "bk" (lambda () (interactive) (kill-buffer))
  "kr" 'helm-show-kill-ring
  "fs" 'save-buffer
  "sh" 'split-window-below
  "sv" 'split-window-right
  "wh" 'windmove-left
  "wj" 'windmove-down
  "wk" 'windmove-up
  "wl" 'windmove-right
  "wc" 'delete-window
  "wm" 'delete-other-windows
  "ce" (lambda () (interactive) (find-file "~/.emacs.dOLD/init.el"))
  "cr" (lambda () (interactive) (load-file user-init-file)))


;;;;; Set cursor shape for evil modes
(unless (display-graphic-p)
      (use-package evil-terminal-cursor-changer
        :ensure t
        :init
        (setq evil-motion-state-cursor 'box)  ; █
        (setq evil-visual-state-cursor 'box)  ; █
        (setq evil-normal-state-cursor 'box)  ; █
        (setq evil-insert-state-cursor 'bar)  ; ⎸
        (setq evil-emacs-state-cursor  'hbar) ; _
        :config
        (etcc-on)
        ))

;;;;; Terminal Emulation Stuff
; -- Doesn't Work -- I'm disabling these keys so I can use the buildin behavior of C-r (fzf search history) when in term mode.
;(require 'term)
;(evil-define-key 'insert term-raw-map (kbd "C-r") nil)
;(evil-define-key 'insert term-mode-map (kbd "C-r") nil)
;(define-key term-raw-map (kbd "C-r") nil)
;(define-key term-mode-map (kbd "C-r") nil)
(global-unset-key (kbd "C-r"))
(define-key evil-insert-state-map (kbd "C-r") nil)



;;;;; Helm
(helm-mode 1)
(define-key helm-find-files-map (kbd "DEL") 'helm-find-files-up-one-level)
(define-key helm-find-files-map (kbd "<tab>") 'helm-ff-RET)
(define-key helm-read-file-map (kbd "DEL") 'helm-find-files-up-one-level)
(define-key helm-read-file-map (kbd "<tab>") 'helm-ff-RET)
(setq helm-mode-fuzzy-match t)
(setq helm-completion-in-region-fuzzy-match t)

;;;;; Company Mode
(global-company-mode)

;;;;; Rainbow Delimiters Mode
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
; I don't want the highlighting of matching parens cause I have rainbow delimiters
(show-paren-mode 0)

;;;;; Highlight Symbol
(require 'highlight-symbol)
(evil-leader/set-key "hs" 'highlight-symbol)

;;;;;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

(setq flycheck-check-syntax-automatically '(mode-enabled save))

(require 'flycheck-pos-tip)

(eval-after-load 'flycheck
  '(setq flycheck-display-errors-function #'flycheck-pos-tip-error-messages))

;;;;;;;;;;;;;;;;;;;;;;;; Theme Setup ;;;;;;;;;;;;;;;;;;;;;;;;

(load-theme 'material t)

;(require 'spaceline)
;(require 'spaceline-config)
;(spaceline-spacemacs-theme)
;(setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)

(require 'airline-themes)
(load-theme 'airline-doom-one t)

;;;;;;;;;;;;;;;;;;;;;;;; Clojure Setup ;;;;;;;;;;;;;;;;;;;;;;;;
(evil-leader/set-key-for-mode 'clojure-mode
  "mj" 'cider-jack-in
  "mq" 'cider-quit
  "mf" 'cider-format-buffer
  "ml" 'cider-load-buffer
  "mg" (lambda () (interactive) (cider-switch-to-repl-buffer t))
  "mcnc" 'cider-repl-set-ns
  "mcr" 'cider-ns-refresh
  "mtc" 'cider-test-run-test
  "mtn" 'cider-test-run-ns-tests
  "mta" 'cider-test-run-project-tests
  "muf" 'cljr-find-usages
  "mnf" 'dumb-jump-go
  "mnb" 'dumb-jump-back
  "mns" 'helm-imenu
  "mram" 'cljr-add-missing-libspec
  "mrap" 'cljr-add-project-dependency
  "mras" 'cljr-add-stubs
  "mrcv" 'clojure-convert-collection-to-vector
  "mrcm" 'clojure-convert-collection-to-map
  "mrcs" 'clojure-convert-collection-to-set
  "mrcl" 'clojure-convert-collection-to-list
  "mrcq" 'clojure-convert-collection-to-quoted-list
  "mrcn" 'cljr-clean-ns
  "mrcp" 'cljr-cycle-privacy
  "mrdk" 'cljr-destructure-keys
  "mrec" 'cljr-extract-constant
  "mred" 'cljr-extract-def
  "mref" 'cljr-extract-function
  "mrel" 'cljr-expand-let
  "mrfe" 'cljr-create-fn-from-example
  "mril" 'cljr-introduce-let
  "mris" 'cljr-inline-symbol
  "mrmf" 'cljr-move-form
  "mrml" 'cljr-move-to-let
  "mrpf" 'cljr-promote-function
  "mrrf" 'cljr-rename-file-or-dir
  "mrrl" 'cljr-remove-let
  "mrrs" 'cljr-rename-symbol
  "mrsp" 'cljr-sort-project-dependencies
  "mrsr" 'cljr-stop-referring
  "mrtf" 'clojure-thread-first-all
  "mrtl" 'clojure-thread-last-all
  "mrua" 'cljr-unwind-all)

(evil-leader/set-key-for-mode 'cider-repl-mode
  "mh" 'cider-repl-history)

(evil-leader/set-key-for-mode 'cider-repl-history-mode
  "mi" 'cider-repl-history-insert-and-quit)

(require 'clj-refactor)

(defun my-clojure-mode-hook ()
  (clj-refactor-mode 1)
  (yas-minor-mode 1))

(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)
(require 'flycheck-clj-kondo)

(helm-cider-mode 1)

(add-hook 'clojure-mode-hook (lambda () (lispy-mode 1)))


(setq cljr-warn-on-eval nil)


;;;;;;;;;;;;;;;;;;;;;;;; SBCL Setup ;;;;;;;;;;;;;;;;;;;;;;;;
(setq inferior-lisp-program "/usr/bin/sbcl")
(setq slime-contribs '(slime-fancy))

(add-hook 'lisp-mode-hook (lambda () (lispy-mode 1)))

;;;;;;;;;;;;;;;;;;;;;;;; Version Control ;;;;;;;;;;;;;;;;;;;;;;;;
(require 'magit)
(require 'evil-magit)

;;;;;;;;;;;;;;;;;;;;;;;; golang ;;;;;;;;;;;;;;;;;;;;;;;;
(require 'go-eldoc)
(add-hook 'go-mode-hook 'go-eldoc-setup)

(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)



;TODO
;workspaces

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a94f1a015878c5f00afab321e4fef124b2fc3b823c8ddd89d360d710fc2bddfc" "9b1c580339183a8661a84f5864a6c363260c80136bd20ac9f00d7e1d662e936a" "3eb93cd9a0da0f3e86b5d932ac0e3b5f0f50de7a0b805d4eb1f67782e9eb67a4" default)))
 '(org-agenda-files (quote ("~/Documents/org-test.org")))
 '(package-selected-packages
   (quote
    (undo-tree cider clojure-mode projectile better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

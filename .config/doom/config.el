;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
                                        ;(setq doom-theme 'doom-one)
(setq doom-theme 'doom-nord)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(add-hook! 'clojure-mode-hook
  (add-hook 'before-save-hook #'cider-format-buffer))

(map! (:localleader
       :map clojure-mode-map
       (:prefix ("s" . "slurp")
        :desc "Slurp Forward" "f" #'paredit-forward-slurp-sexp
        :desc "Slurp Backward" "b" #'paredit-backward-slurp-sexp)
       (:prefix ("b" . "barf")
        :desc "Barf Forward" "f" #'paredit-forward-barf-sexp
        :desc "Barf Backward" "b" #'paredit-backward-barf-sexp)
       (:prefix ("w" . "wrap")
        :desc "Wrap Curly" "{" #'paredit-wrap-curly
        :desc "Wrap Round" "(" #'paredit-wrap-round
        :desc "Wrap Square" "[" #'paredit-wrap-square
        :desc "Wrap Angled" "<" #'paredit-wrap-angled)
       (:prefix ("f" . "form")
        :desc "Format buffer" "f" #'cider-format-buffer
        :desc "Raise Form" "r" #'paredit-raise-sexp
        :desc "Splice Form" "s" #'paredit-splice-sexp
        :desc "Transpose Form" "t" #'transpose-sexps)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max) nil))

(add-hook! 'lisp-mode-hook
  (add-hook 'before-save-hook #'indent-buffer))

(add-hook! 'lisp-mode-hook #'paredit-mode)

(after! sly
  (set-lookup-handlers! 'lisp-mode
    :references #'sly-edit-uses)
  (map! (:localleader
         :map lisp-mode-map
         :desc "Compile and Load buffer and goto REPL" "l" (lambda ()
                                                             (interactive)
                                                             (progn (sly-compile-and-load-file)
                                                                    (windmove-down)
                                        ;(sly-mrepl #'switch-to-buffer) This changed the current buffer to be the repl (Which is different to interactive behaviour). Not sure how to replicate the interactive behaviour.
                                                                    ))
         (:prefix ("s" . "stickers + slurp")
          :desc "Slurp Forward" "f" #'paredit-forward-slurp-sexp
          :desc "Slurp Backward" "b" #'paredit-backward-slurp-sexp
          :desc "Toggle breaking stickers" "B" #'sly-stickers-toggle-break-on-stickers
          :desc "Fetch stickers"           "F" #'sly-stickers-fetch)
         (:prefix ("b" . "barf")
          :desc "Barf Forward" "f" #'paredit-forward-barf-sexp
          :desc "Barf Backward" "b" #'paredit-backward-barf-sexp)
         (:prefix ("w" . "wrap")
          :desc "Wrap Curly" "{" #'paredit-wrap-curly
          :desc "Wrap Round" "(" #'paredit-wrap-round
          :desc "Wrap Square" "[" #'paredit-wrap-square
          :desc "Wrap Angled" "<" #'paredit-wrap-angled)
         (:prefix ("f" . "form")
          :desc "Format buffer" "f" #'indent-buffer
          :desc "Raise Form" "r" #'paredit-raise-sexp
          :desc "Splice Form" "s" #'paredit-splice-sexp
          :desc "Transpose Form" "t" #'transpose-sexps))))

(setq org-agenda-files '("~/Documents/agenda"))
(setq org-log-done 'time)

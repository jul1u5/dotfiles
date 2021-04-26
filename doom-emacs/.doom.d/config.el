;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Julius Marozas"
      user-mail-address "marozas.julius@gmail.com")

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
(setq doom-font (font-spec :family "monospace" :size 14)
      doom-big-font (font-spec :family "monospace" :size 18))
;doom-variable-pitch-font (font-spec :family "Overpass" :size 18))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

(setq uniquify-buffer-name-style 'forward)

(setq projectile-project-search-path '("~/code"))

;; Switch to the new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

(setq company-idle-delay 0.2)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(set-file-template! "/shell\\.nix$" ':trigger "__shell.nix" :mode 'nix-mode)
(set-file-template! "/flake\\.nix$" ':trigger "__flake.nix" :mode 'nix-mode)

(add-to-list 'load-path "/run/current-system/sw/share/emacs/site-lisp/mu4e")

(after! mu4e
  (set-email-account! "Gmail"
                      '((mu4e-refile-folder     . "/gmail/gmail/Inbox")
                        (smtpmail-smtp-user     . user-mail-address)
                        t)))

(after! circe
  (set-irc-server! "chat.freenode.net"
                   `(:tls t
                     :port 6697
                     :nick "jul1u5"
                     :sasl-username ,(+pass-get-user   "irc/freenode.net")
                     :sasl-password (lambda (&rest _) (+pass-get-secret "irc/freenode.net"))
                     :channels ("#emacs" "#haskell" "#nixos" "#nix-community"))))

(after! ispell
  ;; Also make sure dictionary file is configured
  ;; in ~/.emacs.d/.local/etc/ispell/en.pws
  ;; Source: https://github.com/hlissner/doom-emacs/issues/4138#issuecomment-725187904
  (setq ispell-dictionary "en"))

(after! centaur-tabs
  (add-hook 'proof-goals-mode-hook #'centaur-tabs-local-mode)
  (add-hook 'proof-response-mode-hook #'centaur-tabs-local-mode)
  (add-hook 'special-mode-hook #'centaur-tabs-local-mode)
  (add-hook 'ispell-update-post-hook
            (lambda () (with-current-buffer ispell-choices-buffer
                         (centaur-tabs-local-mode)))))

(setq doom-themes-treemacs-theme 'doom-colors
      lsp-treemacs-sync-mode 1)

(after! lsp-treemacs
  (load-library "doom-themes-ext-treemacs"))

(after! org
  (setq org-log-done 'time
        org-log-into-drawer t
        org-agenda-start-with-log-mode t
        org-agenda-start-on-weekday 1)
  (add-hook 'org-mode-hook (lambda () (electric-indent-local-mode -1)))
  (set-popup-rule! "^\\*Org Agenda" :side 'bottom :size 0.40 :select t :ttl nil))

(after! calendar
  (setq calendar-week-start-day 1))

(after! nix-mode
  (setq nix-nixfmt-bin "nixpkgs-fmt"))

(after! lsp-mode
  (setq lsp-lens-enable t)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-rust-analyzer-import-merge-behaviour "last"))
  ;; (setq lsp-rust-racer-completion nil))

(after! lsp-haskell
  (setq lsp-log-io t)
  (setq lsp-haskell-formatting-provider "fourmolu"))
  ;; (add-to-list 'haskell-process-args-cabal-repl "-b pretty-simple"))

(after! lsp-julia
  (setq lsp-julia-package-dir nil)
  (setq lsp-julia-default-environment "~/.julia/environments/v1.5"))

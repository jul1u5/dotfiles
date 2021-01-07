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
(setq doom-font (font-spec :family "monospace" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


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

(setq display-line-numbers-type 'relative)

(setq doom-themes-treemacs-theme 'doom-colors)

(use-package! nix-mode
  :init
  (setq nix-nixfmt-bin "nixpkgs-fmt"))

;; (use-package! magit-delta
;;   :after magit
;;   :config
;;   (setq
;;     magit-delta-default-dark-theme "OneHalfDark"
;;     magit-delta-default-light-theme "OneHalfLight")
;;   (magit-delta-mode))

(use-package! org-super-agenda
  :init
  (setq org-super-agenda-groups '((:name "Today"
                                   :time-grid t
                                   :scheduled today)
                                  (:name "Due today"
                                   :deadline today)
                                  (:name "Important"
                                   :priority "A")
                                  (:name "Overdue"
                                   :deadline past)
                                  (:name "Due soon"
                                   :deadline future)
                                  (:name "Big outcomes"
                                   :tag "bo")))
  :config
  (org-super-agenda-mode))

(use-package! gnuplot
  :mode "\\.gp\\'")

(use-package! dhall-mode
  :mode "\\.dhall\\'")

(set-email-account! "Gmail"
                    '((mu4e-refile-folder     . "/gmail/gmail/Inbox")
                      (smtpmail-smtp-user     . "marozas.julius@gmail.com"))
                    t)

(after! circe
  (set-irc-server! "chat.freenode.net"
                   `(:tls t
                     :port 6697
                     :nick "jul1u5"
                     :sasl-username ,(+pass-get-user   "irc/freenode.net")
                     :sasl-password (lambda (&rest _) (+pass-get-secret "irc/freenode.net"))
                     :channels ("#emacs" "#nixos"))))

(use-package! lsp-mode
  :custom
  (lsp-lens-enable t)
  (lsp-headerline-breadcrumb-enable nil))

(use-package! lsp-haskell
  :ensure t
  :custom
  (lsp-haskell-formatting-provider "stylish-haskell")
  :config
  ;; Comment/uncomment this line to see interactions between lsp client/server.
  (setq lsp-log-io t))

(add-hook 'ispell-update-post-hook
          (lambda ()
            (with-current-buffer ispell-choices-buffer
              (centaur-tabs-local-mode))))

;; (use-package! grip-mode
;;   :custom
;;   (grip-preview-use-webkit t))

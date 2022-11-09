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
(setq doom-font         (font-spec :family "JetBrainsMono Nerd Font" :size 12)
      doom-unicode-font (font-spec :family "JuliaMono")
      use-default-font-for-symbols nil)
;; doom-big-font     (font-spec :family "JetBrainsMono Nerd Font" :size 18))

(add-to-list 'doom-emoji-fallback-font-families "Twitter Color Emoji")
;; (add-to-list 'doom-symbol-fallback-font-families "DejaVu Sans Mono")

;; (after! unicode-fonts
;;   (add-to-list 'unicode-fonts-fallback-font-list "DejaVu Sans Mono"))

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

;; Render buffer names of files with the same file names as
;;
;;   | a/file.txt | b/file.txt |
;;
;; instead of
;;
;;   | file.txt | file.txt<2> |
;;
;; See also: https://github.com/hlissner/doom-emacs/issues/6205
(after! persp-mode
  (setq-hook! 'persp-mode-hook uniquify-buffer-name-style 'forward))

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

(add-to-list '+format-on-save-enabled-modes 'racket-mode t)

(after! mu4e
  (set-email-account! "Gmail"
                      '((mu4e-refile-folder     . "/gmail/gmail/Inbox")
                        (smtpmail-smtp-user     . user-mail-address)
                        t)))

(after! circe
  (set-irc-server! "irc.libera.chat"
    `(:tls t
      :port 6697
      :nick "jul1u5"
      :sasl-username ,(+pass-get-user "irc/libera.chat")
      :sasl-password (lambda (&rest _) (+pass-get-secret "irc/libera.chat"))
      :channels ("#emacs" "#haskell"))))

(after! ispell
  ;; Also make sure dictionary file is configured
  ;; in ~/.emacs.d/.local/etc/ispell/en/.pws
  ;; Source: https://github.com/hlissner/doom-emacs/issues/4138#issuecomment-725187904
  (setq ispell-dictionary "en"))

(after! centaur-tabs
  (map! :n "g>" #'centaur-tabs-move-current-tab-to-right
        :n "g<" #'centaur-tabs-move-current-tab-to-left)
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
  (setq lsp-rust-analyzer-import-merge-behaviour "last")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.direnv\\'"))

(after! lsp-haskell
  (setq lsp-log-io t)
  (setq lsp-haskell-formatting-provider "fourmolu"))
  ;; (add-to-list 'haskell-process-args-cabal-repl "-b pretty-simple"))

(after! lsp-julia
  (setq lsp-julia-package-dir nil)
  (setq lsp-julia-default-environment "~/.julia/environments/v1.5"))


;; Experimental next/previous system for helpful buffers.
;; Taken from: https://github.com/Janfel/doom-emacs-config/blob/master/config.org#buffer-ring-system
(set-popup-rule! "^\\*helpful " :size 0.35 :ttl nil :select t :vslot 1)

(defvar *helpful-buffer-ring-size 5
  "How many buffers are stored for use with `*helpful-next'.")

(defvar *helpful--buffer-ring (make-ring *helpful-buffer-ring-size)
  "Ring that stores the current Helpful buffer history.")

(defun *helpful--buffer-index (&optional buffer)
  "If BUFFER is a Helpful buffer, return it’s index in the buffer ring."
  (let ((buf (or buffer (current-buffer))))
    (and (eq (buffer-local-value 'major-mode buf) 'helpful-mode)
         (seq-position (ring-elements *helpful--buffer-ring) buf #'eq))))

(defadvice! *helpful--new-buffer-a (help-buf)
  "Update the buffer ring according to the current buffer and HELP-BUF."
  :filter-return #'helpful--buffer
  (let ((buf-ring *helpful--buffer-ring))
    (let ((newer-buffers (or (*helpful--buffer-index) 0)))
      (dotimes (_ newer-buffers) (ring-remove buf-ring 0)))
    (when (/= (ring-size buf-ring) *helpful-buffer-ring-size)
      (ring-resize buf-ring *helpful-buffer-ring-size))
    (ring-insert buf-ring help-buf)))

(defun *helpful--next (&optional buffer)
  "Return the next live Helpful buffer relative to BUFFER."
  (let ((buf-ring *helpful--buffer-ring)
        (index (or (*helpful--buffer-index buffer) -1)))
    (cl-block nil
      (while (> index 0)
        (cl-decf index)
        (let ((buf (ring-ref buf-ring index)))
          (if (buffer-live-p buf) (cl-return buf)))
        (ring-remove buf-ring index)))))

(defun *helpful--previous (&optional buffer)
  "Return the previous live Helpful buffer relative to BUFFER."
  (let ((buf-ring *helpful--buffer-ring)
        (index (1+ (or (*helpful--buffer-index buffer) -1))))
    (cl-block nil
      (while (< index (ring-length buf-ring))
        (let ((buf (ring-ref buf-ring index)))
          (if (buffer-live-p buf) (cl-return buf)))
        (ring-remove buf-ring index)))))

(defun *helpful-next ()
  "Go to the next Helpful buffer."
  (interactive)
  (when-let (buf (*helpful--next))
    (funcall helpful-switch-buffer-function buf)))

(defun *helpful-previous ()
  "Go to the previous Helpful buffer."
  (interactive)
  (when-let (buf (*helpful--previous))
    (funcall helpful-switch-buffer-function buf)))

(after! helpful :map helpful-mode-map
      "<XF86Forward>" #'*helpful-next
      "<XF86Back>"    #'*helpful-previous
      "C-c C-f"       #'*helpful-next
      "C-c C-b"       #'*helpful-previous
      "M-n"           #'*helpful-next
      "M-p"           #'*helpful-previous
      :n ">"          #'*helpful-next
      :n "<"          #'*helpful-previous)

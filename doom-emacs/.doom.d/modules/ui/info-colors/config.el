;;; ui/info-colors/config.el -*- lexical-binding: t; -*-

(use-package! info-colors
  :commands (info-colors-fontify-node)
  :hook
  (Info-selection-hook . info-colors-fontify-node)
  (Info-mode-hook . mixed-pitch-mode))

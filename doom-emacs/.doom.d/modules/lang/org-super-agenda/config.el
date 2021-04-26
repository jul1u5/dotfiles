;;; org-super-agenda/config.el -*- lexical-binding: t; -*-

(use-package! org-super-agenda
  :after org-agenda
  :custom
  (org-super-agenda-groups '((:name "Today"
                              :time-grid t
                              :scheduled today
                              (:name "Due today"
                               :deadline today)
                              (:name "Important"
                               :priority "A")
                              (:name "Overdue"
                               :deadline past)
                              (:name "Due soon"
                               :deadline future)
                              (:name "Big outcomes"
                               :tag "bo"))))
  :config
  (org-super-agenda-mode))

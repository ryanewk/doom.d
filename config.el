;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;;

(setq doom-font (font-spec :family "Menlo" :size 13))

(defun rae-delete-frame()
  (interactive)
  (delete-frame)
  )

;; custom key bindings
(map! :leader
      (:prefix-map ("x" . "+extensions")
        :desc "Journal" "j" #'rae-org-journal
        :desc "Delete Frame" "0" #'rae-delete-frame)
      )

(after! org
  (add-to-list
   'auto-mode-alist '("\\.\\(org\\|org_archive\\|org\\.txt\\)$" . org-mode))
  (setq
   org-directory "~/org"
   org-agenda-file-regexp "\\`[^.].*\\.\\(org\\.txt\\|org\\)\\'")


  (setq org-todo-keywords
        '((sequence "TODO(t)" "PROJ(p)" "MEET(m)" "|" "DONE(d)")
          (sequence "[ ](T)" "[-](P)" "[?](M)" "|" "[X](D)")
          (sequence "NEXT(n)" "WAIT(w)" "HOLD(h)" "|" "ABRT(c)" "DEFR(f)"))
        )

  (setq
   org-agenda-skip-scheduled-if-done t
   org-agenda-skip-deadline-if-done t
   )
  )

(after! deft
  (setq deft-directory "~/org/notes")
  )

(setq open-junk-file-format "~/org/scratch")

;; org-journal
(setq org-journal-dir "~/org/journal"
      org-journal-file-format "%Y%m%d.txt")
(defun rae-org-journal()
  (interactive)
  (org-journal-new-entry nil)
  (delete-other-windows)
  )

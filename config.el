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

(setq open-junk-file-format "~/org/scratch")

;; org-journal
;;
(after! org-journal
  (setq org-journal-dir "~/org/notes"
        org-journal-date-prefix "#+TITLE: "
        org-journal-file-format "%Y-%m-%d.org"
        org-journal-date-format "%Y-%m-%d (%A, %B %d, %Y)"
        org-journal-cache-file (concat doom-cache-dir "org-journal")
        org-journal-file-pattern (org-journal-dir-and-format->regex
                                  org-journal-dir org-journal-file-format)))

(defun rae-org-journal()
  (interactive)
  (org-journal-new-entry nil)
  (delete-other-windows)
  )


;; https://github.com/hlissner/doom-emacs/issues/1652
(add-to-list '+format-on-save-enabled-modes 'go-mode t)
(add-hook! 'go-mode-hook
  (add-hook 'before-save-hook #'lsp-format-buffer nil 'local)
  (add-hook 'before-save-hook #'lsp-organize-imports nil 'local))

(use-package! org-roam
  :commands (org-roam-insert org-roam-find-file org-roam)
  :init
  (setq org-roam-directory "~/org/notes")
  (map! :leader
        :prefix "n"
        :desc "Org-Roam-Insert" "i" #'org-roam-insert
        :desc "Org-Roam-Find"   "/" #'org-roam-find-file
        :desc "Org-Roam-Buffer" "r" #'org-roam)
  :config
  (org-roam-mode +1))

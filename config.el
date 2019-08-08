;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;;

(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|org\\.txt\\)$" . org-mode))
(setq
 org-directory "~/org"
 org-agenda-file-regexp "\\`[^.].*\\.\\(org\\.txt\\|org\\)\\'")

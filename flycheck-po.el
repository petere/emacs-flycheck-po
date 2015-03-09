;;; flycheck-po.el --- Flycheck support for po-mode	-*- lexical-binding: t -*-

;; Copyright (C) 2015 Peter Eisentraut

;; Author: Peter Eisentraut <peter@eisentraut.org>
;; URL: https://github.com/petere/emacs-flycheck-po
;; Keywords: convenience languages tools
;; Version: 0

;;; Commentary:

;; This provides the `po-msgfmt' syntax checker, which runs `msgfmt
;; -c' over the file.  This is the same as what `po-validate' does,
;; but integrated with Flycheck.

;;; Code:

(require 'flycheck)

(flycheck-define-checker po-msgfmt
  "A checker for PO files using `msgfmt'."
  :command ("msgfmt" "-o" "/dev/null" "-c" "-v" source)
  :error-patterns ((error line-start (file-name) ":" line ":" (message) line-end))
  :modes po-mode)

;;;###autoload
(defun flycheck-po-setup ()
  "Set up `po-mode' in Flycheck."
  (interactive)
  ;; Flycheck skips a buffer if it is read-only, so cheat and unset
  ;; read-only.  Doesn't really make a difference.
  (add-hook 'po-mode-hook (lambda () (setq buffer-read-only nil)))
  (add-to-list 'flycheck-checkers 'po-msgfmt))

;;;###autoload
(eval-after-load 'flycheck #'flycheck-po-setup)

(provide 'flycheck-po)

;;; flycheck-po.el ends here

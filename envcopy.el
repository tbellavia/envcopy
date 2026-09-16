;;; envcopy.el -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2026 Tony B.
;;
;; Author: Tony B. <bbellavi@student.42.fr>
;; Maintainer: Tony B. <bbellavi@student.42.fr>
;; Created: September 15, 2026
;; Modified: September 15, 2026
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex text tools unix vc wp
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;
;;
;;; Code:

(defun envcopy--string-trim (s CHARS)
  "Return a trimmed string from both side"
  (string-trim-left (string-trim-right s CHARS) CHARS))

(defun envcopy-find-env-file ()
  (let ((root (locate-dominating-file default-directory ".env")))
    (when root
      (expand-file-name ".env" root))))

(defun envcopy-read-file-as-string (filepath)
  "Return file content as a string"
  (with-temp-buffer
    (insert-file-contents filepath)
    (buffer-string)))

(defun envcopy-get-key-value-from-env-file (filepath)
  "Return key-value pairs from an env file."
  (let ((regex "^[ \t]*\\([A-Za-z_][A-Za-z0-9_]*\\)[ \t]*=[ \t]*\\([^ \t\n\r]+\\)")
        pairs)
    (dolist (line (split-string (envcopy-read-file-as-string filepath) "\n"))
      (when (string-match regex line)
        (push (cons (match-string 1 line)
                    (envcopy--string-trim (match-string 2 line) "\""))
              pairs)))
    (nreverse pairs)))

(defun envcopy-get-variable ()
  "Search a variable in a .env file at the project root folder and copy it in the kill ring"
  (interactive)
  (if (null (envcopy-find-env-file))
    (message "No env file found")
    (let* ((env (envcopy-get-key-value-from-env-file (envcopy-find-env-file)))
           (key (completing-read "Variable: " (mapcar 'car env)))
           (value (alist-get key env nil nil 'string=)))
      (kill-new value)
      (message "Copied %s into clipboard" key))))



(provide 'envcopy)
;;; envcopy.el ends here

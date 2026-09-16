# envcopy

Copy variables from a `.env` file directly from Emacs.

## Usage

Run:

`M-x envcopy-get-variable``

Or bind it to a key:


``` emacs-lisp
(map! :leader
      "p e" #'envcopy-get-variable)
```

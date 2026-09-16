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

## Doom Emacs

### Install

``` emacs-lisp
; config.el

(require 'envcopy)
(map! :leader
      :desc "Copy env variable"
      "p e" #'envcopy-get-variable)
```

``` emacs-lisp
; packages.el
(package! envcopy
  :recipe (:host github
           :repo "tbellavia/envcopy"))
```

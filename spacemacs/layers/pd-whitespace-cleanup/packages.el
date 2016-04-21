;;; packages.el --- pd-whitespace-cleanup layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author:  <patrick@ArchMAS>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `pd-whitespace-cleanup-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `pd-whitespace-cleanup/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `pd-whitespace-cleanup/pre-init-PACKAGE' and/or
;;   `pd-whitespace-cleanup/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst pd-whitespace-cleanup-packages
  '(whitespace-cleanup-mode)
  "The list of Lisp packages required by the pd-whitespace-cleanup layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun pd-whitespace-cleanup/init-whitespace-cleanup-mode ()
    (use-package whitespace-cleanup-mode
      :commands (whitespace-cleanup-mode)
      :defer t
      :init
      (progn
        (add-hook 'prog-mode-hook #'whitespace-cleanup-mode)
        (spacemacs/set-leader-keys "ow" #'whitespace-cleanup)
        (spacemacs/set-leader-keys "oW" #'whitespace-cleanup-mode))
      :config
      (spacemacs|diminish whitespace-cleanup-mode "\u24E6c" "wc")))


;;; packages.el ends here

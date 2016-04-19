;;; packages.el --- pd-paredit layer packages file for Spacemacs.
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
;; added to `pd-paredit-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `pd-paredit/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `pd-paredit/pre-init-PACKAGE' and/or
;;   `pd-paredit/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst pd-paredit-packages
  '(
    paredit
    evil-paredit
    )
  "The list of Lisp packages required by the pd-paredit layer.

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

(defun pd-paredit/init-paredit ()
  (use-package paredit))

(defun pd-paredit/init-evil-paredit ()
  (use-package evil-paredit
    :config
    (progn
      (eval-after-load 'paredit
        '(add-hook 'paredit-mode-hook #'evil-paredit-mode))

      ;; Fix <delete> calling delete-char in insert mode
      (add-hook 'evil-paredit-mode-hook
                (lambda ()
                  (evil-define-key 'insert evil-paredit-mode-map
                    (kbd "<delete>") #'paredit-forward-delete)))

      ;; Override SLIME's DEL with paredit's
      (eval-after-load 'slime
        '(add-hook 'slime-repl-mode-hook
                   (lambda ()
                     (define-key slime-repl-mode-map
                       (read-kbd-macro paredit-backward-delete-key) nil)))))))

;;; packages.el ends here

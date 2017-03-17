;;; packages.el --- xkwu layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author:  <xkwu@DESKTOP-HNVE7S0>
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
;; added to `xkwu-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `xkwu/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `xkwu/pre-init-PACKAGE' and/or
;;   `xkwu/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst xkwu-packages
  '(org-jekyll)
  )
"The list of Lisp packages required by the xkwu layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. particularA list of the form (PACKAGE KEYS...), where PACKAGE is the
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
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format"
(defun xkwu/init-org-jekyll()
  (defun open-xkwu-layer-file()
    (interactive)
    (find-file "~/.spacemacs.d/xkwu/packages.el"))

  (global-set-key (kbd "<f3>") 'open-xkwu-layer-file)
  (add-hook 'org-mode-hook (lambda () (spacemacs/toggle-line-numbers-off)) 'append)
  (with-eval-after-load 'org
    (progn
      (setq  org-link-file-path-type  'relative)
      (setq org-startup-with-inline-images t) 
      (setq org-startup-indented t)
      (org-babel-do-load-languages
       (quote org-babel-load-languages)
       (quote ((emacs-lisp . t)
               (dot . t)
               (ditaa . t)
               )))
      (setq org-confirm-babel-evaluate nil)
      (setq org-ditaa-jar-path "~/.spacemacs.d/ditaa0_9.jar")
      (setq org-plantuml-jar-path "~/.spacemacs.d/plantuml.jar")

      (setq-default org-download-image-dir "~/blog/coldvmoon.github.io/images")
      (setq-default org-download-heading-lvl nil)
      (setq org-publish-project-alist
            '(

              ("org-blog"
               ;; Path to your org files.
               :base-directory "~/blog/coldvmoon.github.io/_drafts"
               :base-extension "org"

               ;; Path to your Jekyll project.
               :publishing-directory "~/blog/coldvmoon.github.io/_posts"
               :recursive t
               :publishing-function org-html-publish-to-html
               :with-toc nil
               :headline-levels 4 
               :auto-preamble nil
               :auto-sitemap nil
               :section-numbers t
               :table-of-contents nil		  
               :html-extension "html"
               :body-only t ;; Only export section between <body> </body>
               )


              ("org-static-blog"
               :base-directory "~/blog/coldvmoon.github.io/_drafts"
               :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php"
               :publishing-directory "~/blog/coldvmoon.github.io/images"
               :recursive t
               :publishing-function org-publish-attachment)

              ("blog" :components ("org-blog" "org-static-blog"))

              

              ))

      
      )
    )
  )
;;; packages.el ends here

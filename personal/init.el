;;Editor settings
(global-linum-mode 1)
(scroll-bar-mode 0)
(tool-bar-mode -1)
(menu-bar-mode -1)
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))
(setq-default indent-tabs-mode nil)
(set-default-font "Monaco 14")

(prelude-ensure-module-deps '(stylus-mode multiple-cursors
                                          js2-mode solarized-theme
                                          virtualenvwrapper
                                          monokai-theme
                                          ac-anaconda
                                          sphinx-doc))



;; magitshortcut
(global-set-key (kbd "C-x g") 'magit-status)

(global-set-key (kbd "C-x l") 'goto-line)

;;Toggle comment and uncomment
;; Original idea from  http://www.opensubscriber.com/message/emacs-devel@gnu.org/10971693.html
;; (defun toggle-comment-region (&optional arg)
;;   "Replacement for the comment-dwim command.
;;         If no region is selected and current line is not blank and we are not at the end of the line,
;;         then comment current line.
;;         Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
;;   (interactive "*P")
;;   (comment-normalize-vars)
;;   (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
;;       (comment-or-uncomment-region (line-beginning-position) (line-end-position))
;;     (comment-dwim arg)))
;; (global-unset-key (kbd "C-?"))
;; (global-set-key (kbd "C-?") 'toggle-comment-region)

(defun toggle-comment-region (&optional arg)
  "Replacement for the 'comment-dwim' command.
ARG: The number of comment character to use in the comment.
If no region is selected and current line is not blank and we are not
at the end of the line,then comment current line.
Replaces default behavior of 'comment-dwim', when it inserts
comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(global-unset-key (kbd "C-x /"))
(global-set-key (kbd "C-x /") 'toggle-comment-region)


;;TO STOP POP UPS
(setq pop-up-windows nil)
(setq use-dialog-box nil)

(add-hook 'after-init-hook 'after-init-hook-hook)


(defun after-init-hook-hook ()
  (load-theme 'monokai)
  (set-face-attribute 'region nil :background "#666")
  ;; (load-theme 'zenburn)
  ;; (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook 'anaconda-mode)
  ;; (setq jedi:complete-on-dot t)
)


(toggle-frame-fullscreen)

(require 'multiple-cursors)
;; (global-unset-key (kbd "M-<down-mouse-1>"))
;; (global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(auto-save-mode -1)
(add-to-list 'auto-mode-alist (cons (rx ".js" eos) 'js2-mode))

(setq flx-ido-threshold 1000)


;; OPEN NEW LINE
(defun open-next-line (arg)
  "Move to the next line and then opens a line.
    See also `newline-and-indent'."
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (next-line 1)
  (when newline-and-indent
    (indent-according-to-mode)))
(global-set-key (kbd "C-o") 'open-next-line)
;; Behave like vi's O command
(defun open-previous-line (arg)
  "Open a new line before the current one.
     See also `newline-and-indent'."
  (interactive "p")
  (beginning-of-line)
  (open-line arg)
  (when newline-and-indent
    (indent-according-to-mode)))
(global-set-key (kbd "M-o") 'open-previous-line)
(defvar newline-and-indent t
  "Modify the behavior of the open-*-line functions to cause them to
autoindent.")

(provide 'open-next-line)


(add-hook 'python-mode-hook (lambda ()
                              (require 'sphinx-doc)
                              (sphinx-doc-mode t)))
(global-set-key (kbd "C-x C-k") 'sphinx-doc)

(defun insert-ipdb()
  (interactive)
  (insert "import ipdb;ipdb.set_trace()"))
(global-unset-key (kbd "C-x ;"))
(global-set-key (kbd "C-x ;") 'insert-ipdb)

(defun insert-python-file-encoding()
  (interactive)
  (insert "# -*- coding: utf-8 -*-"))
(global-unset-key (kbd "C-x C-:"))
(global-set-key (kbd "C-x C-:") 'insert-python-file-encoding)

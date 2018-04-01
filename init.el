
(require 'package)
(package-initialize)

(set-foreground-color "white")
(set-background-color "black")
(set-cursor-color "red")
(setq ring-bell-function #'ignore)
(setq ido-enable-flex-matching t)
;(setq ido-everywhere t)
(ido-mode 1)

(setq emacs-ecb-home "~/.emacs.d/")


(load-file (concat emacs-ecb-home "custom-functions.el"))
(load-file (concat emacs-ecb-home "mouse.el"))
(load-file (concat emacs-ecb-home "keyboard.el"))
(load-file (concat emacs-ecb-home "tabbar.el"))
(load-file (concat emacs-ecb-home "ecb-support.el"))
(load-file (concat emacs-ecb-home "frame-support.el"))
(load-file (concat emacs-ecb-home "flymake-cursor.el"))
(load-file (concat emacs-ecb-home "erlang-support.el"))
(load-file (concat emacs-ecb-home "edts-support.el"))
(toggle-frame-maximized)
(require 'erlang-start)
;(cd "/Users/rvg/src/expend-http-security-acl-layer")
(cd (getenv "WORKROOT"))
(erlang-shell)

(setq-default default-directory (getenv "WORKROOT"))

(setq ecb-source-path
      (list
       (list (concat (getenv "WORKROOT") "/apps") "A")
       (list (concat (getenv "WORKROOT") "/stests") "S")
       (list (concat (getenv "WORKROOT") "") ".")
       )
)
(setq ecb-compilation-buffer-names (quote (
        ("*Calculator*") ("*vc*") ("*vc-diff*") ("\\*Apropos.*\\*" . t) ("*Occur*") ("*shell*") ("\\*[cC]ompilation.*\\*" . t)
        ("\\*i?grep.*\\*" . t) ("\\*Help.*\\*" . t) ("*Completions*") ("*Backtrace*") ("*Compile-log*") ("*bsh*") (" *Message-Log*")
        ; Erlang Buffers
        ("*erlang*") ("*edts*")
        ; Workspace Buffers
        ("*muddle_be*") )))

;(require 'edts-start)
;^^^^ ADD BACK IN WHEN SWITCHING to Expend
(ecb-activate)
(ecb-goto-window-compilation)
(setq-default indent-tabs-mode nil)



;*****************************************************************************************

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(buffers-tab-max-size 12)
 '(ecb-activation-selects-ecb-frame-if-already-active t)
 '(ecb-analyse-face (quote ecb-analyse-face))
 '(ecb-basic-buffer-sync nil)
 '(ecb-cache-directory-contents nil)
 '(ecb-compile-window-height 10)
 '(ecb-compile-window-temporally-enlarge (quote both))
 '(ecb-compile-window-width (quote edit-window))
 '(ecb-directory-face (quote ecb-directory-face))
 '(ecb-enlarged-compilation-window-max-height 0.8)
 '(ecb-fix-window-size (quote (("left5" . width))))
 '(ecb-history-make-buckets (quote never))
 '(ecb-kill-buffer-clears-history (quote auto))
 '(ecb-layout-name "left5")
 '(ecb-layout-window-sizes
   (quote
    (("left5"
      (ecb-directories-buffer-name 0.10833333333333334 . 0.336734693877551)
      (ecb-sources-buffer-name 0.10833333333333334 . 0.22448979591836735)
      (ecb-history-buffer-name 0.10833333333333334 . 0.42857142857142855)))))
 '(ecb-mouse-click-destination (quote last-point))
 '(ecb-options-version "2.50")
 '(ecb-other-window-behavior (quote only-edit))
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
 '(ecb-redraw-layout-quickly t)
 '(ecb-source-file-regexps
   (quote
    ((".*"
      ("\\(^\\(\\.\\|#\\)\\|\\(~$\\|\\.\\(elc\\|obj\\|o\\|beam\\|class\\|lib\\|dll\\|a\\|so\\|cache\\)$\\)\\)")
      ("^\\.\\(emacs\\|gnus\\)$")))))
 '(ecb-source-path (quote (("/Users/rvg/source/current/modules/" "M"))))
 '(ecb-split-edit-window-after-start nil)
 '(ecb-stealthy-tasks-delay 1)
 '(ecb-tip-of-the-day nil)
 '(ecb-tree-buffer-style (quote ascii-guides))
 '(ecb-tree-incremental-search (quote substring))
 '(ecb-vc-enable-support nil)
 '(ecb-vc-supported-backends
   (quote
    ((ecb-vc-dir-managed-by-SVN . ecb-vc-state)
     (ecb-vc-dir-managed-by-GIT . ecb-vc-state))))
 '(ecb-wget-setup (quote cons))
 '(ecb-window-sync nil)
 '(ecb-window-sync-delay nil)
 '(edts-inhibit-package-check t)
 '(gutter-buffers-tab-visible-p nil)
 '(inferior-erlang-display-buffer-any-frame (quote raise) t)
 '(mouse-drag-copy-region nil)
 '(mouse-yank-at-point t)
 '(scroll-step 1)
 '(speedbar-supported-extension-expressions
   (quote
    (".bnf" ".[ch]\\(\\+\\+\\|pp\\|c\\|h\\|xx\\)?" ".tex\\(i\\(nfo\\)?\\)?" ".el" ".emacs" ".l" ".lsp" ".p" ".java" ".f\\(90\\|77\\|or\\)?" ".ada" ".p[lm]" ".tcl" ".m" ".scm" ".pm" ".py" ".g" ".s?html" ".ma?k" "[Mm]akefile\\(\\.in\\)?" ".erl" ".hrl")))
 '(speedbar-use-images nil)
 '(tool-bar-mode nil)
 '(truncate-lines t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 105 :width normal :family "Monaco")))))

(put 'upcase-region 'disabled nil)

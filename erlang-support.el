;; EQC Emacs Mode -- Configuration Start
(message "running erlang-support.el")

(setq erlang-emacs-tools-path (shell-command-to-string (concat emacs-ecb-home "bin/emacs-mode-path")) )
(setq erlang-root-dir  (shell-command-to-string (concat emacs-ecb-home "bin/erlang-base-dir")))
(setq exec-path (cons (concat erlang-root-dir "/bin")  exec-path))
(setq erlang-compile-extra-opts (list 'debug_info))
(setq load-path (cons erlang-emacs-tools-path load-path))


(load-file (concat emacs-ecb-home "emacs-flymake/flymake.el"))
(require 'flymake)
(setq flymake-run-in-place nil)
(setq flymake-number-of-errors-to-display 4)
(setq flymake-log-level 255)



(add-to-list 'auto-mode-alist '("\\.erl?$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.hrl?$" . erlang-mode))

(require 'erlang-start)

;*****************************************************************************************
(defun my-erlang-font-lock-hook ()
  (font-lock-mode 3)
)

(defun my-erlang-keymap-hook ()
;  (print "running erlang-keymap-hook")
  (erlinit)
)


;*****************************************************************************************
;* Custom Functions
;*****************************************************************************************

(defun flymake-erlang-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
		     'flymake-create-temp-inplace))
	 (local-file (file-relative-name
		      temp-file
		      (file-name-directory buffer-file-name))))
	(list "~/.emacs.d/bin/eflymake" (list local-file))))	      

(add-to-list 'flymake-allowed-file-name-masks
            '("\\.erl\\'" flymake-erlang-init))
            
(defun my-erlang-mode-hook ()
;        (flymake-mode 1)
        )

(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)
 
; Simple filter to get rid of flymake error on file open                             
(defun nil-file-filter-hook ()
  (if (not (eq nil (buffer-file-name)))
    (flymake-find-file-hook) 
  )  
)            

;(add-hook 'find-file-hook 'nil-file-filter-hook)
(setq flymake-gui-warnings-enabled nil)

(defun erlinit ()
;  (print "erlinit")
  (setq comment-column 80)
  (setq auto-font-lock-mode 3)
  (setq erlang-indent-level 4)
  (setq erlang-electric-commands t)
  (setq comment-column 80)

)
    
     
(add-hook 'erlang-load-hook 
	(lambda ()
;         (esense-mode)
         (my-erlang-keymap-hook)
        )
)

(add-hook 'erlang-mode-hook 
	 (lambda () 
                    (print "erlang-mode-hook")
;                    (esense-mode)
                    (ecb-activate)
		    (pc-selection-mode)
                    (my-erlang-keymap-hook)
                    (my-erlang-font-lock-hook)
         )
)


;(defun erlang-save-compile ()
;  ('erlang-compile))

(defun erlang-save-compile ()
  (interactive)
  (setq bufferfile buffer-file-name) 
  (call-interactively 'save-buffer)
  (erlang-compile)
)


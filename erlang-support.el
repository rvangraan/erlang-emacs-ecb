;; EQC Emacs Mode -- Configuration Start
(message "running erlang-support.el")
(setq indent-tabs-mode nil)
(setq erlang-emacs-tools-path (shell-command-to-string (concat emacs-ecb-home "bin/emacs-mode-path")) )
(setq erlang-root-dir  (shell-command-to-string (concat emacs-ecb-home "bin/erlang-base-dir")))
(setq exec-path (cons (concat erlang-root-dir "/bin")  exec-path))
(setq erlang-compile-extra-opts (list 'debug_info))
(setq load-path (cons erlang-emacs-tools-path load-path))


;(require 'flymake-cursor)
;(require 'erlang-flymake)
; (setq flymake-run-in-place nil)
; (setq flymake-number-of-errors-to-display 4)
; (setq flymake-log-level 255)



; (erlang-flymake-only-on-save)

(add-to-list 'auto-mode-alist '("\\.erl?$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.hrl?$" . erlang-mode))



(defun configure-erlang-machine ()
  (interactive)
  (if (getenv "USE_REBAR_FOR_SHELL")
      (progn
        (message (format "USE_REBAR_FOR_SHELL specified, using rebar to start interactive shell" ))
        (setq inferior-erlang-machine "rebar3")
        (setq inferior-erlang-machine-options '("as" "interactive" "shell"))
        (setq inferior-erlang-shell-type nil))
    (progn
      (message "USE_REBAR_FOR_SHELL not specified, using built-in inferior-erlang")
      (setq inferior-erlang-machine-options '("-sname" "emacs"))
      (set-nodename-from-env)
      )
    )
  )





;*****************************************************************************************
(defun my-erlang-font-lock-hook ()
  (font-lock-mode 3)
)

(defun my-erlang-keymap-hook ()
;  (print "running erlang-keymap-hook")
;  (erlinit)
)


;*****************************************************************************************
;* Custom Functions
;*****************************************************************************************

;(defun flymake-erlang-init ();
;  (let* ((temp-file (flymake-init-create-temp-buffer-copy
;		     'flymake-create-temp-inplace))
;	 (local-file (file-relative-name
;		      temp-file
;		      (file-name-directory buffer-file-name))))
;	(list "~/.emacs.d/bin/eflymake" (list local-file))))

;(add-to-list 'flymake-allowed-file-name-masks
;            '("\\.erl\\'" flymake-erlang-init))

(defun my-erlang-mode-hook ()
        (flymake-mode 1)
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
  (setq comment-column 80)
  (setq auto-font-lock-mode 3)
  (setq erlang-indent-level 4)
  (setq erlang-electric-commands t)
)


(add-hook 'erlang-mode-hook
	 (lambda ()
                    (print "erlang-mode-hook")
;                    (esense-mode)
;                    (ecb-activate)
		                (pc-selection-mode)
                    (my-erlang-keymap-hook)
                    (my-erlang-font-lock-hook)
                    (erlinit)
         )
)



;(defun erlang-save-compile ()
;  ('erlang-compile))

(defun erlang-save-compile ()
  (interactive)
  (print "erlang-save-compile")

  (setq bufferfile buffer-file-name)
  (call-interactively 'save-buffer)
  (if (fboundp 'custom-erlang-compile-bufferfile)
      (custom-erlang-compile-bufferfile bufferfile)
    (erlang-compile))
)



(defun erlang-set-nodename (nodename)
  "Prompts for distributed Erlang node name"
  (interactive "sNext Erlang node name shall be: ")
  (require 'erlang)
  (require 'cl)
  (setnodename nodename))

(defun setnodename (nodename)
  (require 'erlang)
  (require 'cl)
  (let
      ((oldtail (member "-sname" inferior-erlang-machine-options)))
    (if oldtail
        (nsubstitute nodename
                     (cadr oldtail)
                     inferior-erlang-machine-options)
      (setq inferior-erlang-machine-options
            (cons "-sname"
                  (cons nodename
                        inferior-erlang-machine-options))))
    )
  )


(defun setvmoptions (vmoptions)
  (require 'erlang)
  (require 'cl)
  (setq inferior-erlang-machine-options
       (cons vmoptions
             inferior-erlang-machine-options)))

(defun set-nodename-from-env ()
  (interactive)
  (let
      ((env-nodename (getenv "INTERACTIVE_NODE_NAME")))
    (if (not (null env-nodename))
        (progn
          (print (format "setting Erlang Node Name to %s" env-nodename))
          (setnodename env-nodename)
          (setq erl-nodename-cache env-nodename)
          )
      (print "INTERACTIVE_NODE_NAME NOT SPECIFIED - nodename will be nonode")
    )  
  )
)


(configure-erlang-machine)

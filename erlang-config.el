(require 'ecb)

(defun get-base-directory () 
  (interactive)
;  (print (concat "Retrieving start directory")) 
  (setq erl-workspace (getenv "WORKSPACE"))   
  (if (eq nil erl-workspace)  
    (getenv "PWD")
    (if (eq (file-accessible-directory-p erl-workspace) nil)    
      (getenv "PWD")
      (erl-workspace)
    )
  )
)

(defun make-system-config-filename ()
;  (print (concat "Building system config file name"))
  (let (
        (nullbuffer (get-buffer "null.erl"))
        )
    (if (null nullbuffer)
        nil
      (let (
            (nulldirectory (file-name-directory (buffer-file-name nullbuffer)))
            )
;       (print (concat "nulldirectory: " nulldirectory))
        (concat nulldirectory "system.config")
        )
      )
    )
)


(defun read-system-nodename()
;  (print (concat "Configuring Nodename"))

  (let (
        (start-directory (get-start-directory))
        )
    (if (not (null start-directory))
        (let (
              (nodename-file (concat start-directory "nodename"))
              )
;         (print (concat "nodename-file = " nodename-file))
          (if (file-exists-p nodename-file)
              (ecb-file-content-as-string nodename-file)
            nil
            )
          )
      )
    )
)


(defun read-vm-options()

  (let (
        (start-directory (get-start-directory))
        )
    (if (not (null start-directory))
        (let (
              (vm-options-file (concat start-directory "vmoptions"))
              )
          (if (file-exists-p vm-options-file)
              (ecb-file-content-as-string vm-options-file)
            nil
            )
          )
      )
    )
)


(defun erlang-save-compile ()
  (interactive)
  (setq bufferfile buffer-file-name) 
  (call-interactively 'save-buffer)
  (select-frame compile-frame)
  (erlang-compile-bufferfile bufferfile)
;  (call-interactively 'other-window)
;  (switch-to-buffer-other-frame "*erlang*")
)


(defun erlang-compile-bufferfile (bufferfile)
  "Compile the file specified in the erlang buffer."
  ;; (interactive)
  (save-some-buffers)
  (or (inferior-erlang-running-p)
      (save-excursion
        (inferior-erlang)))
  (or (inferior-erlang-running-p)
      (error "Error starting inferior Erlang shell"))
  (let ((dir (file-name-directory bufferfile))
        ;;; (file (file-name-nondirectory (buffer-file-name)))
        (noext (substring bufferfile 0 -4))
        ;; Hopefully, noone else will ever use these...
        (tmpvar "Tmp7236")
        (tmpvar2 "Tmp8742")
        end)
    (inferior-erlang-display-buffer)
    ;;    (inferior-erlang-send-command "")
    ;;    (inferior-erlang-wait-prompt)
    (save-excursion
      (set-buffer inferior-erlang-buffer)
      (end-of-buffer)
      (setq start_point (point))
      )
    (setq end (inferior-erlang-send-command
               (if erlang-compile-use-outdir
                   (format "c(\"%s\",[{outdir,\"%s\"},debug_info])." noext dir)
                 (format
                  (concat
                   "f(%s), {ok, %s} = file:get_cwd(), "
                   "file:set_cwd(\"%s\"), "
                   "%s = c(\"%s\"), file:set_cwd(%s), f(%s), %s.")
                  tmpvar2 tmpvar
                  dir
                  tmpvar2 noext tmpvar tmpvar tmpvar2))
               nil))
    (inferior-erlang-wait-prompt)
    (save-excursion
      (set-buffer inferior-erlang-buffer)
      (if (re-search-backward ".erl.*syntax" start_point t)
	  (progn
	    (setq erlang-compile-success nil)
	    (message "Compilation failed"))
	(progn
	  (setq erlang-compile-success t)
	  (message "Compilation succeeded"))
	(setq compilation-error-list nil)
	(set-marker compilation-parsing-end end))
      (setq compilation-last-buffer inferior-erlang-buffer))))
  
(defun internal-run-current-test ()
  (let ((function_name (save-excursion
			 (and (erlang-beginning-of-clause)
			      (erlang-get-function-name))))
	(module_name (erlang-get-module-from-file-name)))
    (if (null function_name)
	(error "Can't find name of current Erlang function."))
    (setq last-erlang-send-string (format "testhelper:run(%s, %s)." module_name function_name))
    (erase-buffer-and-send-string last-erlang-send-string)))

(defun internal-run-previous-test ()
  (erase-buffer-and-send-string last-erlang-send-string))
  
(defun erase-buffer-and-send-string (erlang-send-string)
  ;; Possibly a preference to erase buffer? 
  (save-excursion
    (set-buffer inferior-erlang-buffer)
    (erase-buffer))
  (inferior-erlang-send-command last-erlang-send-string))

(defun check-compilation-and-call (run-function) 
  (interactive)
  (if (eq erlang-compile-success t)
      (funcall run-function)
    (message "Compilation failure detected")))

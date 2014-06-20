;******************************************************************************************
; Keyboard setup
;******************************************************************************************

(global-set-key (kbd "C-§")  (quote tree-buffer-show-node-menu-keyboard))
(global-set-key (kbd "M-3") #'(lambda()(interactive)(insert-hash-sign)))
;(global-set-key (kbd "ESC 1") (quote tree-buffer-show-node-menu-keyboard))
;(global-set-key (kbd "ESC 2") (quote mouse3-region-popup-menu))

(global-set-key [(control tab)] 'goto-compile-and-back)

(global-set-key [(control meta up)] 'tabbar-backward-group)
(global-set-key [(control meta down)] 'tabbar-forward-group)
(global-set-key [(control shift left)] 'tabbar-backward)
(global-set-key [(control shift right)] 'tabbar-forward)
(global-set-key [(control meta left)] 'tabbar-backward-tab)
(global-set-key [(control meta right)] 'tabbar-forward-tab)
;(global-set-key [(control meta left)] 'ecb-nav-goto-previous)
;(global-set-key [(control meta right)] 'ecb-nav-goto-next)

(global-set-key [delete] 'delete-char)   
;(global-set-key [(meta x)] 'kill-region)
;(global-set-key [(meta v)] 'yank)
;(global-set-key [(meta c)] 'kill-ring-save)
;(global-set-key [(meta z)] 'undo)

;(define-key global-map [?\C- ] 'invoke-esense-do-something)
(global-set-key [f3] 'ecb-toggle-ecb-windows)
(global-set-key [(control f3)] 'ecb-toggle-compile-window)
(global-set-key [(control f4)] 'kill-current-buffer)

;s-1 for normal emacs
(global-set-key (kbd "s-1") 'ecb-goto-window-directories)
(global-set-key (kbd "s-2") 'ecb-goto-window-sources)
(global-set-key (kbd "s-3") 'ecb-goto-window-history)
(global-set-key (kbd "s-4") 'ecb-goto-window-edit1)
(global-set-key (kbd "s-5") 'ecb-goto-window-edit2)
(global-set-key (kbd "s-0") 'ecb-goto-window-compilation)
(global-set-key (kbd "s-§") 'other-frame)
;(global-set-key (kbd "M-1") 'ecb-goto-window-directories) 
;(global-set-key (kbd "M-2") 'ecb-goto-window-sources) 
;(global-set-key (kbd "M-3") 'ecb-goto-window-history) 
;(global-set-key (kbd "M-4") 'ecb-goto-window-edit1) 
;(global-set-key (kbd "M-5") 'ecb-goto-window-edit2) 
;(global-set-key (kbd "M-0") 'ecb-goto-window-compilation) 

;(global-set-key [(control f8)] 'erlang-save-compile)
;(global-set-key [(control f9)] 'erlang-save-compile)
(global-set-key [(control f8)] 'select-minibuffer)
(global-set-key [(control f9)] 'save-buffer-always)
(global-set-key [(control f10)] 'erlang-next-error)

(global-set-key [f10] 'compile-and-run-current-test)
(global-set-key [f11] 'compile-current-buffer-and-run-previous-test)

(global-set-key [(control f11)] 'other-frame)
(global-set-key [f12] 'execute-extended-command)
(global-set-key [f13] 'execute-extended-command)
(global-set-key [f6] 'execute-extended-command)
(global-set-key [f19] 'remove-newlines-in-region)
(global-set-key [(meta X)] 'execute-extended-command)

(defun mac-toggle-max-window ()
  (interactive)
  (set-frame-parameter nil 'fullscreen 
                       (if (frame-parameter nil 'fullscreen)
                           (progn
                             (scroll-bar-mode 1) ;; turn on scrollbars when not in fullscreen mode
                             (set-frame-size-according-to-resolution)
                             nil)
                         (progn
                           (scroll-bar-mode -1) ;; turn off scrollbars when in fullscreen mode
                           'fullboth)))) 

(define-key global-map [(meta return)]
    'mac-toggle-max-window)



(defun save-buffer-always ()
  "Save the buffer even if it is not modified."
    (interactive)
    (set-buffer-modified-p t)
    (save-buffer))


(defun insert-hash-sign ()
  "Inserts a hash sign into the buffer"
    (insert "#"))
    

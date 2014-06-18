;*****************************************************************************************
;* RvG: Custom Functions
;*****************************************************************************************

(defun goto-compile-and-back ()
  (interactive)
  (if last-win-compile-window
    (progn
      (setq last-win-compile-window nil)
      (ecb-goto-window-edit-last)
      (ecb-redraw-layout)
    )
    (progn
      (setq last-win-compile-window t)
      (ecb-goto-window-compilation)
    )
  )
)


(defun kill-current-buffer ()
  (interactive)
  (kill-buffer nil)
)


(defun remove-newlines-in-region ()
  "Removes all newlines in the region."
  (interactive)
  (save-restriction
    (narrow-to-region (point) (mark))
    (goto-char (point-min))
    (while (search-forward "\n" nil t) (replace-match "" nil t))
    (goto-char (point-min))
    (while (search-forward "\t" nil t) (replace-match " " nil t))
    (goto-char (point-min))
    (while (search-forward "  " nil t) (replace-match " " nil t)))
  )


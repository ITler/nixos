(defvar bh/organization-task-id "d5e295c8-3bf5-41c3-949b-632204be7e92")
(setq org-startup-indented t)

	;; Custom Key Bindings
(map! "<f9> I" #'bh/punch-in)
(map! "<f9> O" #'bh/punch-out)
(map! "<f9> C" #'org-clock-goto)


(global-set-key (kbd "<f12>") 'org-agenda)
(global-set-key (kbd "<f5>") 'bh/org-todo)
(global-set-key (kbd "<S-f5>") 'bh/widen)
(global-set-key (kbd "<f7>") 'bh/set-truncate-lines)
(global-set-key (kbd "<f8>") 'org-cycle-agenda-files)
(global-set-key (kbd "<f9> <f9>") 'bh/show-org-agenda)
(global-set-key (kbd "<f9> b") 'bbdb)
(global-set-key (kbd "<f9> c") 'calendar)
(global-set-key (kbd "<f9> f") 'boxquote-insert-file)
(global-set-key (kbd "<f9> g") 'gnus)
(global-set-key (kbd "<f9> h") 'bh/hide-other)
(global-set-key (kbd "<f9> n") 'bh/toggle-next-task-display)

(global-set-key (kbd "<f9> O") 'bh/punch-out)

(global-set-key (kbd "<f9> o") 'bh/make-org-scratch)

(global-set-key (kbd "<f9> r") 'boxquote-region)
(global-set-key (kbd "<f9> s") 'bh/switch-to-scratch)

(global-set-key (kbd "<f9> t") 'bh/insert-inactive-timestamp)
(global-set-key (kbd "<f9> T") 'bh/toggle-insert-inactive-timestamp)

(global-set-key (kbd "<f9> v") 'visible-mode)
(global-set-key (kbd "<f9> l") 'org-toggle-link-display)
(global-set-key (kbd "<f9> SPC") 'bh/clock-in-last-task)
(global-set-key (kbd "C-<f9>") 'previous-buffer)
(global-set-key (kbd "M-<f9>") 'org-toggle-inline-images)
(global-set-key (kbd "C-x n r") 'narrow-to-region)
(global-set-key (kbd "C-<f10>") 'next-buffer)
(global-set-key (kbd "<f11>") 'org-clock-goto)
(global-set-key (kbd "C-<f11>") 'org-clock-in)
(global-set-key (kbd "C-s-<f12>") 'bh/save-then-publish)
(global-set-key (kbd "C-c c") 'org-capture)

(defun bh/hide-other ()
  (interactive)
  (save-excursion
	(org-back-to-heading 'invisible-ok)
	(hide-other)
	(org-cycle)
	(org-cycle)
	(org-cycle)))

(defun bh/set-truncate-lines ()
  "Toggle value of truncate-lines and refresh window display."
  (interactive)
  (setq truncate-lines (not truncate-lines))
  ;; now refresh window display (an idiom from simple.el):
  (save-excursion
	(set-window-start (selected-window)
					  (window-start (selected-window)))))

(defun bh/make-org-scratch ()
  (interactive)
  (find-file "/tmp/publish/scratch.org")
  (gnus-make-directory "/tmp/publish"))

(defun bh/switch-to-scratch ()
  (interactive)
	(switch-to-buffer "*scratch*"))

;; TODO keywords

(setq org-todo-keywords
	  (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
			  (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

(setq org-todo-keyword-faces
	  (quote (("TODO" :foreground "red" :weight bold)
			  ("NEXT" :foreground "blue" :weight bold)
			  ("DONE" :foreground "forest green" :weight bold)
			  ("WAITING" :foreground "orange" :weight bold)
			  ("HOLD" :foreground "magenta" :weight bold)
			  ("CANCELLED" :foreground "forest green" :weight bold)
			  ("MEETING" :foreground "forest green" :weight bold)
			  ("PHONE" :foreground "forest green" :weight bold))))

 ;; TODO state triggers

(setq org-todo-state-tags-triggers
	  (quote (("CANCELLED" ("CANCELLED" . t))
			  ("WAITING" ("WAITING" . t))
			  ("HOLD" ("WAITING") ("HOLD" . t))
			  ;; (done ("WAITING") ("HOLD"))
			  ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
			  ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
			  ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

;; CAPTURE

(setq org-default-notes-file "~/org/refile.org")

(setq org-capture-templates
		(quote (("t" "todo" entry (file "~/org/refile.org")
		;; (quote (("t" "todo" entry (file org-default-notes-file)
					"* TODO %?\n%U\n%a\n"
					))))

;; REFILING Tasks

; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
								 (org-agenda-files :maxlevel . 9))))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))
; Use the current window when visiting files and buffers with ido
(setq ido-default-file-method 'selected-window)
(setq ido-default-buffer-method 'selected-window)
; Use the current window for indirect buffer display
(setq org-indirect-buffer-display 'current-window)

;;;; Refile settings
; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)


;; AGENDA

;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)

;; Compact the block agenda view
(setq org-agenda-compact-blocks t)

;; Custom agenda command definitions
(setq org-agenda-custom-commands
	  (quote (("N" "Notes" tags "NOTE"
			   ((org-agenda-overriding-header "Notes")
				(org-tags-match-list-sublevels t)))
			  ("h" "Habits" tags-todo "STYLE=\"habit\""
			   ((org-agenda-overriding-header "Habits")
				(org-agenda-sorting-strategy
				 '(todo-state-down effort-up category-keep))))
			  (" " "Agenda"
			   ((agenda "" nil)
				(tags "REFILE"
					  ((org-agenda-overriding-header "Tasks to Refile")
					   (org-tags-match-list-sublevels nil)))
				(tags-todo "-CANCELLED/!"
						   ((org-agenda-overriding-header "Stuck Projects")
							(org-agenda-skip-function 'bh/skip-non-stuck-projects)
							(org-agenda-sorting-strategy
							 '(category-keep))))
				(tags-todo "-HOLD-CANCELLED/!"
						   ((org-agenda-overriding-header "Projects")
							(org-agenda-skip-function 'bh/skip-non-projects)
							(org-tags-match-list-sublevels 'indented)
							(org-agenda-sorting-strategy
							 '(category-keep))))
				(tags-todo "-CANCELLED/!NEXT"
						   ((org-agenda-overriding-header (concat "Project Next Tasks"
																  (if bh/hide-scheduled-and-waiting-next-tasks
																	  ""
																	" (including WAITING and SCHEDULED tasks)")))
							(org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
							(org-tags-match-list-sublevels t)
							(org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
							(org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
							(org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
							(org-agenda-sorting-strategy
							 '(todo-state-down effort-up category-keep))))
				(tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
						   ((org-agenda-overriding-header (concat "Project Subtasks"
																  (if bh/hide-scheduled-and-waiting-next-tasks
																	  ""
																	" (including WAITING and SCHEDULED tasks)")))
							(org-agenda-skip-function 'bh/skip-non-project-tasks)
							(org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
							(org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
							(org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
							(org-agenda-sorting-strategy
							 '(category-keep))))
				(tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
						   ((org-agenda-overriding-header (concat "Standalone Tasks"
																  (if bh/hide-scheduled-and-waiting-next-tasks
																	  ""
																	" (including WAITING and SCHEDULED tasks)")))
							(org-agenda-skip-function 'bh/skip-project-tasks)
							(org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
							(org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
							(org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
							(org-agenda-sorting-strategy
							 '(category-keep))))
				(tags-todo "-CANCELLED+WAITING|HOLD/!"
						   ((org-agenda-overriding-header (concat "Waiting and Postponed Tasks"
																  (if bh/hide-scheduled-and-waiting-next-tasks
																	  ""
																	" (including WAITING and SCHEDULED tasks)")))
							(org-agenda-skip-function 'bh/skip-non-tasks)
							(org-tags-match-list-sublevels nil)
							(org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
							(org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)))
				(tags "-REFILE/"
					  ((org-agenda-overriding-header "Tasks to Archive")
					   (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
					   (org-tags-match-list-sublevels nil))))
			   nil))))


;; CLOCKING
;; ;;
;; Resume clocking task when emacs is restarted
(org-clock-persistence-insinuate)
;;
;; Show lot of clocking history so it's easy to pick items off the C-F11 list
(setq org-clock-history-length 23)
;; Resume clocking task on clock-in if the clock is open
(setq org-clock-in-resume t)
;; Change tasks to NEXT when clocking in
(setq org-clock-in-switch-to-state 'bh/clock-in-to-next)
;; Separate drawers for clocking and logs
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
;; Save clock data and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist t)
;; Do not prompt to resume an active clock
(setq org-clock-persist-query-resume nil)
;; Enable auto clock resolution for finding open clocks
(setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
;; Include current clocking task in clock reports
(setq org-clock-report-include-clocking-task t)

(setq bh/keep-clock-running nil)

(defun bh/clock-in-to-next (kw)
  "Switch a task from TODO to NEXT when clocking in.
Skips capture tasks, projects, and subprojects.
Switch projects and subprojects from NEXT back to TODO"
  (when (not (and (boundp 'org-capture-mode) org-capture-mode))
	(cond
	 ((and (member (org-get-todo-state) (list "TODO"))
		   (bh/is-task-p))
	  "NEXT")
	 ((and (member (org-get-todo-state) (list "NEXT"))
		   (bh/is-project-p))
	  "TODO"))))

(defun bh/find-project-task ()
  "Move point to the parent (project) task if any"
  (save-restriction
	(widen)
	(let ((parent-task (save-excursion (org-back-to-heading 'invisible-ok) (point))))
	  (while (org-up-heading-safe)
		(when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
		  (setq parent-task (point))))
	  (goto-char parent-task)
	  parent-task)))

(defun bh/punch-in (arg)
  "Start continuous clocking and set the default task to the
selected task.  If no task is selected set the Organization task
as the default task."
  (interactive "p")
  (setq bh/keep-clock-running t)
  (if (equal major-mode 'org-agenda-mode)
	  ;;
	  ;; We're in the agenda
	  ;;
	  (let* ((marker (org-get-at-bol 'org-hd-marker))
			 (tags (org-with-point-at marker (org-get-tags-at))))
		(if (and (eq arg 4) tags)
			(org-agenda-clock-in '(16))
		  (bh/clock-in-organization-task-as-default)))
	;;
	;; We are not in the agenda
	;;
	(save-restriction
	  (widen)
	  ; Find the tags on the current task
	  (if (and (equal major-mode 'org-mode) (not (org-before-first-heading-p)) (eq arg 4))
		  (org-clock-in '(16))
		(bh/clock-in-organization-task-as-default)))))

(defun bh/punch-out ()
  (interactive)
  (setq bh/keep-clock-running nil)
  (when (org-clock-is-active)
	(org-clock-out))
  (org-agenda-remove-restriction-lock))

(defun bh/clock-in-default-task ()
  (save-excursion
	(org-with-point-at org-clock-default-task
	  (org-clock-in))))

(defun bh/clock-in-parent-task ()
  "Move point to the parent (project) task if any and clock in"
  (let ((parent-task))
	(save-excursion
	  (save-restriction
		(widen)
		(while (and (not parent-task) (org-up-heading-safe))
		  (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
			(setq parent-task (point))))
		(if parent-task
			(org-with-point-at parent-task
			  (org-clock-in))
		  (when bh/keep-clock-running
			(bh/clock-in-default-task)))))))

(defun bh/clock-in-organization-task-as-default ()
  (interactive)
  (org-with-point-at (org-id-find bh/organization-task-id 'marker)
	(org-clock-in '(16))))

(defun bh/clock-out-maybe ()
  (when (and bh/keep-clock-running
			 (not org-clock-clocking-in)
			 (marker-buffer org-clock-default-task)
			 (not org-clock-resolving-clocks-due-to-idleness))
	(bh/clock-in-parent-task)))

	(add-hook 'org-clock-out-hook 'bh/clock-out-maybe 'append)

(require 'org-id)
(defun bh/clock-in-task-by-id (id)
  "Clock in a task by id"
  (org-with-point-at (org-id-find id 'marker)
	(org-clock-in nil)))

(defun bh/clock-in-last-task (arg)
  "Clock in the interrupted task if there is one
Skip the default task and get the next one.
A prefix arg forces clock in of the default task."
  (interactive "p")
  (let ((clock-in-to-task
		 (cond
		  ((eq arg 4) org-clock-default-task)
		  ((and (org-clock-is-active)
				(equal org-clock-default-task (cadr org-clock-history)))
		   (caddr org-clock-history))
		  ((org-clock-is-active) (cadr org-clock-history))
		  ((equal org-clock-default-task (car org-clock-history)) (cadr org-clock-history))
		  (t (car org-clock-history)))))
	(widen)
	(org-with-point-at clock-in-to-task
	  (org-clock-in nil))))

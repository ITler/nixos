(map! "C-w" nil)
(map! :gm "C-w <left>" #'evil-window-left)
(map! :gm "C-w <right>" #'evil-window-right)
(map! :gm "C-w <up>" #'evil-window-up)
(map! :gm "C-w <down>" #'evil-window-down)

;; (map! "<spc> <spc>" nil)
;; (map! :gm "SPC SPC" nil)
;; (map! :gm "<SPC> <SPC>" nil)
;; (map! :gm "<SPC> <SPC>" #'counsel-M-x)
(map! :leader
    :desc "M-x" "SPC" #'counsel-M-x
	:desc "Find file in project" ":" #'+ivy/projectile-find-file)

;; doom/config.el
;; main configuration file
;; include theme, font, keybindings, etc


;; gpg data
(setq user-full-name "j.c Guerrero"
      user-mail-address "nrk@kubb.org")

;; font
(setq doom-font (font-spec :family "JetBrains Mono Nerd Font" :size 16 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "JetBrains Mono Nerd Font" :size 14))

;; theme
(setq doom-theme 'doom-one)

;; defaults
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)                 ;; relative numbers mode
(global-visual-line-mode t)                        ;; word wrap mode

;; keybindings
(map! :prefix "M-ç"
      :n "<tab>" #'centaur-tabs-forward            ;; switch to next tab
      :n "w" #'kill-this-buffer                    ;; kill current buffer
      :n "<return>" #'shell-command                ;; execute a shell command
      :n "+" #'text-scale-increase                 ;; increase font size
      :n "-" #'text-scale-decrease                 ;; decrease font size
      :n "<wheel-down>" #'text-scale-decrease      ;; increase font size (with mouse)
      :n "<wheel-up>" #'text-scale-increase        ;; decrease font size (with mouse)
      :n "c" #'comment-region                      ;; comment selected region
      :n "u" #'uncomment-region                    ;; uncommment selected region
      :n "z" #'+word-wrap-mode                     ;; toggle word wrap mode
)

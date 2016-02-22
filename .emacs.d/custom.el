; http://stackoverflow.com/questions/5052088/what-is-custom-set-variables-and-faces-in-my-emacs

;(custom-set-variables
;  '(package-archives 
;    (quote
;      (("marmalade" .  "http://marmalade-repo.org/packages/")
;       ("melpa-stable" .  "http://melpa-stable.milkbox.net/packages/") ))))


;(add-to-list 'package-archives '("marmalade" .  "http://marmalade-repo.org/packages/"))
;(add-to-list 'package-archives '("melpa-stable" .  "http://melpa-stable.milkbox.net/packages/") t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(ido-enable-flex-matching t)
 '(ido-mode (quote both) nil (ido)))
	
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-depth-1-face ((t (:foreground "dark orange" :weight bold))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "deep pink" :weight bold))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "chartreuse" :weight bold))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "deep sky blue" :weight bold))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "yellow" :weight bold))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "orchid" :weight bold))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "spring green" :weight bold))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "sienna1" :weight bold)))))

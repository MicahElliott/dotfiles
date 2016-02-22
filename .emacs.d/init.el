
; Kill splash/intro/welcome screen
(setq inhibit-startup-message t)

; https://github.com/nicferrier/elmarmalade/issues/55
(if (fboundp 'gnutls-available-p)
    (fmakunbound 'gnutls-available-p))
(setq tls-program '("gnutls-cli --tofu -p %p %h")
      imap-ssl-program '("gnutls-cli --tofu -p %p %s")
      smtpmail-stream-type 'starttls
      starttls-extra-arguments '("--tofu"))

; Custom: http://stackoverflow.com/questions/5052088/what-is-custom-set-variables-and-faces-in-my-emacs
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(require 'package)
;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

; http://www.emacswiki.org/emacs-test/ELPA
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ))
(package-initialize)

; Just setting font faces in .Xdefaults
;(unicode-fonts-setup)
;(set-frame-font "Essential PragmataPro")
;(add-to-list 'default-frame-alist `(font . "PragmataPro-9"))

; Avoid evil-mode warning about being redefined
; http://andrewjamesjohnson.com/suppressing-ad-handle-definition-warnings-in-emacs/
(setq ad-redefinition-action 'accept)

; https://github.com/technomancy/better-defaults/blob/master/better-defaults.el
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(require 'saveplace)
(setq-default save-place t)
(show-paren-mode 1)

;;; Helm (use ivy instead)
; https://github.com/emacs-helm/helm
;(require 'helm-config)
;(global-set-key (kbd "M-x") 'helm-M-x)

; Powerline broken; powerline-evil, too!
;(require 'powerline)
;(require 'powerline-evil)
;(powerline-evil-center-color-theme)
;(require 'smart-mode-line)
;(sml/setup)

;;; Crux: Collection of Ridulously Useful eXtensions
; https://github.com/bbatsov/crux
(unless (package-installed-p 'crux)
  (package-refresh-contents)
  (package-install 'crux))
(require 'crux)
(global-set-key [remap move-beginning-of-line] #'crux-move-beginning-of-line)
(global-set-key (kbd "C-c o") #'crux-open-with)
(global-set-key [(shift return)] #'crux-smart-open-line)
;(global-set-key (kbd "s-r") #'crux-recentf-ido-find-file)
;(global-set-key (kbd "C-<backspace>" #'crux-kill-line-backwards))
(global-set-key [remap kill-whole-line] #'crux-kill-whole-line)

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

; Just use F1 for help
(global-set-key (kbd "C-h") 'delete-backward-char)
(blink-cursor-mode 0)

(require 'linum-relative)
(linum-on)
(global-linum-mode t)
; Do absolute numbering, too!
; http://emacs.stackexchange.com/questions/19532/hybrid-line-number-mode-in-emacs
(setq linum-relative-current-symbol "")

(define-key global-map (kbd "RET") 'newline-and-indent)

;;; Avy: jump to char-based decision tree (cf. vim easymotion)
(global-set-key (kbd "C-:") 'avy-goto-char)
(global-set-key (kbd "C-'") 'avy-goto-char-2)
(global-set-key (kbd "M-g f") 'avy-goto-line)

;;; Expand Region
; https://github.com/magnars/expand-region.el
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;;; Smart-Scan: Jumps between other symbols found at point in Emacs
; https://github.com/mickeynp/smart-scan
(smartscan-mode 1)

;;; Rainbow
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
;(rainbow-delimiters-depth-2-face 'blue)

; line break at 78 chars
; http://help-gnu-emacs.gnu.narkive.com/IE5W5qTK/linebreak-after-78characters
(add-hook 'prog-mode-hook 'auto-fill-mode)
(global-set-key [f12] 'auto-fill-mode)

;(rainbow-delimiters-depth-1-face ((t (:foreground "green" :weight "bold"))))
;(rainbow-delimiters-depth-2-face ((t (:foreground "red"))))

;;; Markdown
(autoload 'markdown-mode "markdown-mode" "Markdown major mode" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

; http://msnyder.info/posts/2014/01/cus-edit-plus/
(setq backup-directory-alist '(("." . "~/.emacs.d/saves")))

;(winner-mode 1)

(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

; avoid the "GREP_OPTIONS is deprecated" warning
; https://github.com/simonbates/.emacs.d/commit/6c0972e69451d0132df8c203bd26775206a180c0
(require 'grep)
(grep-apply-setting 'grep-highlight-matches nil)

; https://github.com/edwtjo/evil-org-mode 
;(require 'evil-org)

; Should come before turning on evil mode
(require 'evil-leader)
(global-evil-leader-mode)
;(evil-leader/set-leader "<SPC>")
(evil-leader/set-leader ",")
(evil-leader/set-key  ; add more here!
  "e" 'find-file
  "b" 'switch-to-buffer
  "k" 'kill-buffer)

;(require 'evil)
;(evil-mode 1)

(setq c-basic-offset 2) ; indents 4 chars
(setq tab-width 2)          ; and 4 char wide for TAB
(setq indent-tabs-mode nil) ; And force use of spaces

(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)

; C-c p s/f/k (switch/files/killall)
(require 'projectile)
(projectile-global-mode)

; Auto-Complete (ac*)
(require 'auto-complete-config)
(ac-config-default)
(setq ac-show-menu-immediately-on-auto-complete t)

; Popwin: popup window mgr (built in; needed by guide-key)
; https://github.com/m2ym/popwin-el
(require 'popwin)
(popwin-mode 1)

;;; Guide Key: completable help menu
; https://github.com/kai2nenobu/guide-key
(require 'guide-key)
;(setq guide-key/guide-key-sequence '("C-x r" "C-x 4"))
(setq guide-key/guide-key-sequence t)
(guide-key-mode 1)  ; Enable guide-key-mode

;;; Company Mode (completion; maybe enable)
; http://company-mode.github.io/
; https://www.reddit.com/r/emacs/comments/22d7y6/autocomplete_or_companymode/
;(add-hook 'after-init-hook 'global-company-mode)

;; Color theme
;(load "~/.emacs.d/elpa/molokai-theme-20151016.845/molokai-theme.el")
;(color-theme-molokai)
;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;(load-theme 'zenburn t)
;(load-theme 'badwolf t)
;(load-theme 'leuven t)
;(load-theme 'leuven t)
;(load-theme 'ample t t)
;(load-theme 'ample-light t t)
;(enable-theme 'ample)
;(enable-theme 'ample-light)
(load-theme 'ample-zen t)

(setq multi-term-program "/usr/bin/zsh")
(require 'multi-term)

(require 'adoc-mode)
(add-to-list 'auto-mode-alist '("\\.asc$" . adoc-mode))
;(add-to-list 'auto-mode-alist (cons "\\.txt\\'" 'adoc-mode))

(add-hook 'adoc-mode-hook (lambda() (buffer-face-mode t)))

(global-set-key (kbd "M-;") 'comment-dwim-2)

; https://github.com/k1LoW/emacs-ansible
(add-hook 'yaml-mode-hook #'ansible-doc-mode)
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
(add-hook 'yaml-mode-hook '(lambda () (ansible 1)))

; WARNING: yas breaks ansi-term
; https://github.com/capitaomorte/yasnippet/issues/289
(require 'yasnippet)
(yas-global-mode 1)
(add-hook 'term-mode-hook (lambda () (yas-minor-mode -1)))

; http://stackoverflow.com/questions/6741014/getting-256-colors-in-emacs-shell
(setq tty-color-mode 256)

; https://www.emacswiki.org/emacs/AbbrevMode
(dolist (hook '(erc-mode-hook
		emacs-lisp-mode-hook
		text-mode-hook))
  (add-hook hook (lambda () (abbrev-mode 1))))
(setq-default abbrev-mode t)
(setq abbrev-file-name "~/.emacs.d/abbrev_defs")
(setq save-abbrevs t)

(add-hook 'yaml-mode-hook #'ansible-doc-mode)

; https://www.emacswiki.org/emacs/OrgJournal
(setq org-journal-dir "~/doc/journal/")
(require 'org-journal)

;;; IDo
; http://emacs.stackexchange.com/questions/728/how-do-i-switch-buffers-quickly
;(ido-mode 1)
;(setq ido-separator "\n")

;;; Ivy (part of swiper)
(ivy-mode 1)

;;; Paredit
; https://www.emacswiki.org/emacs-test/ParEdit
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)

;;; IBuffer
; https://www.emacswiki.org/emacs/IbufferMode
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)
(setq ibuffer-default-sorting-mode 'major-mode)

;;; FullFrame
; https://github.com/tomterl/fullframe
(require 'fullframe)
(fullframe magit-status magit-mode-quit-window)

(setq x-select-enable-clipboard t)

; Lispy (like paredit)
; WARNING: causes some problem where only scratch buffer is loaded!!
;(add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Custom Packages
; custom-installed packages into /lisp/
; http://ergoemacs.org/emacs/emacs_installing_packages.html
; https://www.emacswiki.org/emacs/LoadPath
(add-to-list 'load-path "~/.emacs.d/lisp/")
;(let ((default-directory  "~/.emacs.d/lisp/"))
  ;(normal-top-level-add-subdirs-to-load-path))

(require 'insert-time)
(setq insert-date-format "%Y-%m-%d")
(define-key global-map [(control c) (d)] 'insert-date)

					; Not great for presentations
; http://clandest.in/emacs.d/plain/outline-presentation.el
(require  'outline-presentation)

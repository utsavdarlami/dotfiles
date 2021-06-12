(setq inhibit-startup-message t)
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)

;; Font Configuration ----------------------------------------------------------

(set-face-attribute 'default nil :font "mononoki" :height 110)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "mononoki" :height 120 :weight 'regular)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "mononoki" :height 110 :weight 'regular)

;; theme
;; (load-theme 'atom-one-dark t)
  
;;; dark variants
;; Range:   233 (darkest) ~ 239 (lightest)
;; Default: 237
(load-theme 'gruvbox-dark-medium t)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)  ;; uncomment
(unless package-archive-contents
 (package-refresh-contents))
;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(column-number-mode)
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)
;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                vterm-mode-hook
		            treemacs-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package command-log-mode)

; undo and redo
(use-package undo-tree)
(global-undo-tree-mode t)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-n" . ivy-next-line)
         ("C-p" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package all-the-icons)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))


(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))
	 ;:config
	 ;(counsel-mode 1))
	 

;(global-set-key (kbd "C-M-j") 'counsel-switch-buffer)

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

; stream 3
(use-package general
  :config
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (rune/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-emacs-state-cursor '("#b7c63f" bar))        
  (setq evil-normal-state-cursor '("#3faec6" bar))       
  (setq evil-insert-state-cursor '("#3fabc6" bar))       
  (setq evil-undo-system 'undo-tree)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ; alternative C-x C-s
  (define-key evil-normal-state-map (kbd ",w") 'save-buffer)
  ; alternative C-w c
  (define-key evil-normal-state-map (kbd ",q") 'evil-window-delete) 
  
 ; (evil-normal-state-map C-r)
  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(rune/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/Desktop/Workspace")
    (setq projectile-project-search-path '("~/Desktop/Workspace" "~/Desktop/ML")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

; (use-package evil-magit
;  :after magit)

; /---------------------/
; /---------Org---------/
; /---------------------/
;; Org Mode Configuration ------------------------------------------------------

(defun efs/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))


(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "mononoki" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  ;(set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

(use-package org
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ⤵")
  (setq org-hide-emphasis-markers t)

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-agenda-files
	'("~/Documents/org-notes/Tasks.org"
	 ))
;; "~/Documents/org-notes/Goals.org"

  (setq org-format-latex-options
      '(:foreground default
        :background default
        :scale 3.0
        :html-foreground "Black"
        :html-background "Transparent"
        :html-scale 3.0
        :matchers ("begin" "$1" "$$" "\\(" "\\[")))


  (setq org-todo-keywords
    '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
      (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  (setq org-tag-alist
    '((:startgroup)
       ; Put mutually exclusive tags here
       (:endgroup)
       ("@errand" . ?E)
       ("@home" . ?H)
       ("@work" . ?W)
       ("agenda" . ?a)
       ("planning" . ?p)
       ("publish" . ?P)
       ("batch" . ?b)
       ("note" . ?n)
       ("idea" . ?i)))

  (setq org-refile-targets
    '(("Archive.org" :maxlevel . 1)
      ("Tasks.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  ;; Configure custom agenda views
  (setq org-agenda-custom-commands
   '(("d" "Dashboard"
     ((agenda "" ((org-deadline-warning-days 7)))
      (todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))
      (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

    ("n" "Next Tasks"
     ((todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))))

    ("W" "Work Tasks" tags-todo "+work-email")

    ;; Low-effort next actions
    ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
     ((org-agenda-overriding-header "Low Effort Tasks")
      (org-agenda-max-todos 20)
      (org-agenda-files org-agenda-files)))

    ("w" "Workflow Status"
     ((todo "WAIT"
            ((org-agenda-overriding-header "Waiting on External")
             (org-agenda-files org-agenda-files)))
      (todo "REVIEW"
            ((org-agenda-overriding-header "In Review")
             (org-agenda-files org-agenda-files)))
      (todo "PLAN"
            ((org-agenda-overriding-header "In Planning")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "BACKLOG"
            ((org-agenda-overriding-header "Project Backlog")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "READY"
            ((org-agenda-overriding-header "Ready for Work")
             (org-agenda-files org-agenda-files)))
      (todo "ACTIVE"
            ((org-agenda-overriding-header "Active Projects")
             (org-agenda-files org-agenda-files)))
      (todo "COMPLETED"
            ((org-agenda-overriding-header "Completed Projects")
             (org-agenda-files org-agenda-files)))
      (todo "CANC"
            ((org-agenda-overriding-header "Cancelled Projects")
             (org-agenda-files org-agenda-files)))))))

  (setq org-capture-templates
    `(("t" "Tasks / Projects")
      ("tt" "Task" entry (file+olp "~/Documents/org-notes/Tasks.org" "Inbox")
           "* TODO %?\n  %u\n  %a\n" :empty-lines 1)

      ("i" "Ideas")
      ("ii" "Idea" entry (file+olp "~/Documents/org-notes/Ideas.org" "Ideas")
           "* TODO %?\n  %u\n  %a\n" :empty-lines 1)

      ("j" "Journal Entries")
      ("jj" "Journal" entry
           (file+olp+datetree "~/Documents/org-notes/Journal.org")
           "\n* %<%i:%m %p> - Journal :Journal:\n\n%?\n\n"
           ;; ,(dw/read-file-as-string "~/notes/templates/daily.org")
           :clock-in :clock-resume
           :empty-lines 1)

      ("jm" "Meeting" entry
           (file+olp+datetree " ~/Documents/org-notes/Journal.org")
           "* %<%i:%m %p> - %a :meetings:\n\n%?\n\n"
           :clock-in :clock-resume
           :empty-lines 1)

      ("w" "Workflows")
      ("we" "Checking Email" entry (file+olp+datetree "~/Documents/org-notes/Journal.org")
           "* Checking Email :email:\n\n%?" :clock-in :clock-resume :empty-lines 1)
      ))

  (define-key global-map (kbd "C-c j")
    (lambda () (interactive) (org-capture nil)))
       

  (efs/org-font-setup))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
    (python . t)))

(setq org-confirm-babel-evaluate nil)

;; this is needed as of org 9.2
(require 'org-tempo)

(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
(add-to-list 'org-structure-template-alist '("py1" . "src python :results output"))

;; ----- 

(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; or 'c-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom)
  (lsp-ui-doc-max-height '10)
  (lsp-ui-doc-max-width '140))

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
   (progn
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package lsp-treemacs
  :after lsp)

(use-package treemacs-evil
  :after treemacs evil
  :ensure t)

(use-package treemacs-magit
  :after treemacs magit
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after treemacs persp-mode ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'perspectives))

(use-package lsp-ivy)

;; (smartparens-global-mode t)

(use-package company
  :after (:any lsp-mode org-mode org-roam-mode)
  :hook
  ((lsp-mode . company-mode)
   (org-mode . company-mode)
   (org-roam-mode . company-mode))
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 2)
  (company-idle-delay 0.25)
  (add-to-list 'company-backends 'company-capf)
  (setq completion-ignore-case t)
  )

(setq completion-ignore-case t)

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package evil-nerd-commenter)
(define-key evil-normal-state-map (kbd ", c SPC") 'evilnc-comment-or-uncomment-lines)


(use-package term
  :config
  (setq explicit-shell-file-name "zsh") ;; change this to zsh, etc
  ;;(setq explicit-zsh-args '())         ;; use 'explicit-<shell>-args for shell-specific args

  ;; match the default bash shell prompt.  update this if you have a custom prompt
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

(use-package vterm
  :commands vterm
  :config
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")  ;; set this to match your custom shell prompt
  (setq vterm-shell "zsh")                       ;; set this to customize the shell to launch
  (setq vterm-max-scrollback 10000))

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "l" 'dired-single-buffer))

(use-package dired-single)

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "H" 'dired-hide-dotfiles-mode))

;;(require 'evil-numbers)
;;(global-set-key (kbd "c-c +") 'evil-numbers/inc-at-pt)
;;(global-set-key (kbd "c-c -") 'evil-numbers/dec-at-pt)
;;(global-set-key (kbd "c-c c-+") 'evil-numbers/inc-at-pt-incremental)
;;(global-set-key (kbd "c-c c--") 'evil-numbers/dec-at-pt-incremental)


(use-package rustic
  :mode ("\\.rs\\'" . rustic-mode)
  :config
  (setq rustic-lsp-client 'lsp-mode
        rustic-lsp-server 'rust-analyzer
        rustic-analyzer-command '("~/.local/bin/rust-analyzer")))

(use-package lsp-python-ms
   :ensure t
   :init (setq lsp-python-ms-auto-install-server t)
   :hook (python-mode . (lambda ()
                           (require 'lsp-python-ms)
                           (lsp-deferred)))  ; or lsp-deferred
  :init
  (setq lsp-python-ms-executable (executable-find "python-language-server")))

(use-package python-mode
   :ensure nil 
   :hook (python-mode . lsp-deferred)
   :custom
   ;; NOTE: Set these if Python 3 is called "python3" on your system!
   (python-shell-interpreter "python3"))
;;   ;; (dap-python-executable "python3")
;;   ;; (dap-python-debugger 'debugpy)
;;   ;; :config
;;   ;; (require 'dap-python))
(require 'org-id)
(setq org-id-link-to-org-use-id t)

(use-package org-roam
      :ensure t
      :hook
      (after-init . org-roam-mode)
      :custom
      (org-roam-directory "~/Documents/org-notes/")
      :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n g" . org-roam-graph)
               ("C-c n b" . org-roam-switch-to-buffer))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))
              (("C-c n I" . org-roam-insert-immediate)))
      :config
      (setq org-roam-auto-replace-fuzzy-links nil)
      (setq org-roam-completion-everywhere t)
      (setq org-roam-prefer-id-links t)
      (setq org-roam-graph-exclude-matcher '("dailies" "daily"))
      (setq org-roam-capture-templates
        '(("d" "default" plain (function org-roam-capture--get-point)
	   "%?"
           :file-name "%(format-time-string \"%Y-%m-%d--%H-%M-%SZ--${slug}\" (current-time) t)" 
           :head "#+title: ${title} \n#+date: %(format-time-string \"%Y-%m-%d %H:%M\") \n#+roam_tags: no_tags \n#+hugo_tags: no_tags \n#+hugo_categories: uncategorized \n#+STARTUP: latexpreview \n#+STARTUP: content \n#+hugo_auto_set_lastmod: t \n#+hugo_section: posts/unpublished \n#+HUGO_BASE_DIR: ~/Documents/org_blog/ \n#+HUGO_DRAFT: true \n--- \n- References : \n\n- Questions : \n--- \n"
           :unnarrowed t)))
      )

(use-package ein)
(use-package evil-numbers)
(define-key evil-normal-state-map (kbd ", a") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd ", x") 'evil-numbers/dec-at-pt)

(set-frame-parameter (selected-frame) 'alpha '(98 . 96))

(use-package ox-hugo
  :ensure t
  :after ox)

(use-package ivy-posframe
  :ensure t
  :delight
  :config
  (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
  (ivy-posframe-mode 1))

(use-package org-download
  :after org
  :bind
  (:map org-mode-map
        (("s-Y" . org-download-screenshot)
         ("s-y" . org-download-yank))))

(use-package org-roam-server
  :ensure t
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 9080
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files nil
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20))


(require 'org-roam-protocol)

(use-package dashboard
  :ensure t
  :config
  (setq dashboard-banner-logo-title "Sh.........")
  (setq dashboard-startup-banner "~/.emacs.d/pc.png")
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-projects-backend 'projectile) 
  (setq dashboard-items '((recents  . 5)
                         (projects . 3)
                         (bookmarks . 5)
                         (agenda . 5)))
  (setq dashboard-footer-messages '("Happy learning!"))

  (dashboard-setup-startup-hook))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("845489fb9f7547e6348a80f942402fc7ac7c6854b0accabc49aeddd8cd4a2bd9" "171d1ae90e46978eb9c342be6658d937a83aaa45997b1d7af7657546cae5985b" "0466adb5554ea3055d0353d363832446cd8be7b799c39839f387abb631ea0995" "f302eb9c73ead648aecdc1236952b1ceb02a3e7fcd064073fb391c840ef84bca" "e6a2832325900ae153fd88db2111afac2e20e85278368f76f36da1f4d5a8151e" "7a7b1d475b42c1a0b61f3b1d1225dd249ffa1abb1b7f726aec59ac7ca3bf4dae" "1704976a1797342a1b4ea7a75bdbb3be1569f4619134341bd5a4c1cfb16abad4" "1a52e224f2e09af1084db19333eb817c23bceab5e742bf93caacbfea5de6b4f6" "6b1abd26f3e38be1823bd151a96117b288062c6cde5253823539c6926c3bb178" "4eb6fa2ee436e943b168a0cd8eab11afc0752aebb5d974bba2b2ddc8910fca8f" "6b5c518d1c250a8ce17463b7e435e9e20faa84f3f7defba8b579d4f5925f60c1" "83e0376b5df8d6a3fbdfffb9fb0e8cf41a11799d9471293a810deb7586c131e6" "7661b762556018a44a29477b84757994d8386d6edee909409fabe0631952dad9" "9687f29504a36c0b6b46cf654117f2f2ab3e73b909476ccb14cdde2bf990fa3e" "2146060448f4fe0838a378045a731e92275cdce1a1f45ddbf8696bb62da59dc5" "d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" default))
 '(exwm-floating-border-color "#504945")
 '(helm-minibuffer-history-key "M-p")
 '(highlight-tail-colors ((("#363627" "#363627") . 0) (("#323730" "#323730") . 20)))
 '(jdee-db-active-breakpoint-face-colors (cons "#0d1011" "#fabd2f"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#0d1011" "#b8bb26"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#0d1011" "#928374"))
 '(objed-cursor-color "#fb4934")
 '(org-agenda-files
   '("~/Documents/org-notes/2021-06-01--02-34-32Z--gan.org" "~/Documents/org-notes/2021-04-10--04-25-11Z--image_processing.org" "~/Documents/org-notes/2021-05-28--12-02-59Z--image_convolution.org" "~/Documents/org-notes/Tasks.org"))
 '(package-selected-packages
   '(seoul256-theme dired-sidebar gruvbox-theme dashboard which-key vterm visual-fill-column use-package undo-tree treemacs-persp treemacs-magit treemacs-evil rustic rust-mode rainbow-delimiters ox-hugo org-roam-server org-roam-bibtex org-download org-bullets one-themes memoize lsp-ui lsp-treemacs lsp-python-ms lsp-ivy ivy-rich ivy-posframe helpful general flycheck evil-numbers evil-nerd-commenter evil-magit evil-collection eterm-256color ein doom-themes doom-modeline dired-single dired-hide-dotfiles counsel-projectile company-box command-log-mode atom-one-dark-theme all-the-icons-dired))
 '(rustic-ansi-faces
   ["#282828" "#fb4934" "#b8bb26" "#fabd2f" "#83a598" "#cc241d" "#8ec07c" "#ebdbb2"])
 '(vc-annotate-background "#282828")
 '(vc-annotate-color-map
   (list
    (cons 20 "#b8bb26")
    (cons 40 "#cebb29")
    (cons 60 "#e3bc2c")
    (cons 80 "#fabd2f")
    (cons 100 "#fba827")
    (cons 120 "#fc9420")
    (cons 140 "#fe8019")
    (cons 160 "#ed611a")
    (cons 180 "#dc421b")
    (cons 200 "#cc241d")
    (cons 220 "#db3024")
    (cons 240 "#eb3c2c")
    (cons 260 "#fb4934")
    (cons 280 "#e05744")
    (cons 300 "#c66554")
    (cons 320 "#ac7464")
    (cons 340 "#7c6f64")
    (cons 360 "#7c6f64")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package pdf-tools
 :pin manual ;; manually update
 :config
 ;; initialise
 ;; (pdf-tools-install)
 ;; open pdfs scaled to fit page
 (setq-default pdf-view-display-size 'fit-page)
 ;; automatically annotate highlights
 (setq pdf-annot-activate-created-annotations t)
 ;; use normal isearch
 (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward))

(use-package dired-sidebar
  :ensure t
  :commands (dired-sidebar-toggle-sidebar))
;; inti.el ends here

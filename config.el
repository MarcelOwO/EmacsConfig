(setq user-full-name "MarcelOwO"
      user-mail-address "owo@marcel-sigl.dev")

(setq doom-theme 'doom-xcode)
(setq display-line-numbers-type t)
(setq org-directory "~/Notes/")

(setq fancy-splash-image
      (concat doom-private-dir "./images/owo.png"))

(add-hook! 'rust-mode-hook
  (setq lsp-rust-analyzer-cargo-watch-command "clippy"))




;; Format on save (separate hook)
(add-hook! 'rust-ts-mode-hook
  (add-hook 'before-save-hook #'eglot-format-buffer nil t))

(use-package! corfu
  :config
  (setq corfu-auto t
        corfu-auto-delay 0.2
        corfu-auto-prefix 1)
  (add-hook 'rust-ts-mode-hook #'corfu-mode))


(setq native-comp-async-report-warnings-errors nil)

(setq gc-cons-threshold 100000000)

(scroll-bar-mode -1)
(tool-bar-mode -1)


(setq-default ispell-program-name "aspell")  ; macOS friendly
(setq ispell-extra-args '("--sug-mode=ultra"))


(use-package! eglot
  :config
  (add-to-list 'eglot-server-programs
               '((rust-ts-mode rust-mode) . ("rust-analyzer"
                                             :initializationOptions (:check (:command "clippy")))))
  (setq eglot-events-buffer-size 0
        eglot-sync-request-timeout 10)
  (add-hook 'eglot-managed-mode-hook #'eglot-inlay-hints-mode)
  (add-hook 'rust-ts-mode-hook #'eglot-ensure))

(setq gcmh-high-cons-threshold (* 100 1024 1024))  ; 100MB

;;; ---------------------------------------------------------------------
;;; New — citar-org-roam glue
;;; ---------------------------------------------------------------------
(after! org-roam
  (setq org-roam-directory (concat org-directory "roam/")
        org-roam-completion-everywhere t))

(after! citar
  (setq citar-bibliography (list (concat org-directory "references.bib"))))
;; citar-org-roam-mode below takes over note-finding once active, so
;; citar-notes-paths isn't needed separately.

(use-package! citar-org-roam
  :after (citar org-roam)
  :config (citar-org-roam-mode))

;; 1. Set the font
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14))

;; 2. Use a simpler, more compatible bullet list
;; (Note: Some fonts don't support the full range of heavy unicode shapes)
(after! org-modern
  (setq org-modern-star '("*" "●" "○" "◆")))
;; 3. Force Org to use the primary font for these specific characters
;; This prevents the system from searching for "Symbola"
(set-fontset-font t 'unicode (font-spec :family "JetBrainsMono Nerd Font") nil 'prepend)

(after! org-tree-slide
  (define-key org-tree-slide-mode-map (kbd "<right>") #'org-tree-slide-move-next-tree)
  (define-key org-tree-slide-mode-map (kbd "<left>")  #'org-tree-slide-move-previous-tree))

(setq ispell-program-name "aspell"
      ispell-dictionary "en")

(use-package! quarto-mode
  :mode ("\\.qmd\\'" . poly-quarto-mode)
  :commands quarto-preview
  :init
  (setq quarto-preview-display-buffer t
        quarto-force-preview t)
  :config
  (map! :map poly-quarto-mode-map
        :localleader
        :prefix ("q" . "quarto")
        "p" #'quarto-preview))


(setq org-babel-python-command "python3")

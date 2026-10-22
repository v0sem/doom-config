;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Pablo Sanchez"
      user-mail-address "psr299@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;; Fonts: monospaced for code, variable-pitch for prose/org
(setq doom-font (font-spec :family "Iosevka Nerd Font Mono" :size 15)
      doom-variable-pitch-font (font-spec :family "Inter" :size 17)
      doom-unicode-font (font-spec :family "Iosevka Nerd Font Mono" :size 15))
(setq-default line-spacing 0.08)

;; Force line numbers to always inherit from fixed-pitch globally so they stay mono across capture sessions
(set-face-attribute 'line-number nil :inherit 'fixed-pitch)
(set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch)
(custom-set-faces!
  '(line-number :inherit fixed-pitch)
  '(line-number-current-line :inherit fixed-pitch))

;; Use variable-pitch-mode in Org (and visual-line for nicer wrapping)
(add-hook 'org-mode-hook #'variable-pitch-mode)
(add-hook 'org-mode-hook #'visual-line-mode)

(defun my/org-setup-line-numbers ()
  "Enable relative line numbers and remap line number faces to fixed-pitch."
  (display-line-numbers-mode 1)
  (setq-local display-line-numbers 'relative)
  (setq-local face-remapping-alist
              (append face-remapping-alist
                      '((line-number . fixed-pitch)
                        (line-number-current-line . fixed-pitch)))))

;; Keep org text variable-pitch but force the line numbers to be fixed-pitch
(add-hook 'org-mode-hook #'my/org-setup-line-numbers)
(add-hook 'org-capture-mode-hook #'my/org-setup-line-numbers)
;; Optional: make headings use variable-pitch but keep fixed-pitch for code blocks
(with-eval-after-load 'org
  (set-face-attribute 'org-document-title nil :font "Inter" :height 1.4)
  (set-face-attribute 'org-level-1 nil :font "Inter" :height 1.2)
  (set-face-attribute 'org-level-2 nil :font "Inter" :height 1.1))

;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-monokai-spectrum)
;; Specify both a dark and light theme, like so and Doom will choose which one
;; to load based on your system light/dark setting:
;;
;;   (setq doom-theme '(doom-one   . doom-one-light))   ; (DARK . LIGHT)
;;
;; If you want more pro-active theme switching based on OS light/dark mode, look
;; up the `auto-dark' package.

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; VARIABLES

(setq corfu-preview-current t) ;; Non inserting preview
;;
;; OTHER SETTINGS
;; Start fullscreen
(when (display-graphic-p)
  (add-to-list 'initial-frame-alist '(fullscreen . maximized))
  (add-to-list 'default-frame-alist '(fullscreen . maximized)))

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (when (display-graphic-p frame)
              (with-selected-frame frame
                (set-frame-parameter nil 'fullscreen 'maximized)))))

;; Spellcheck only on md or org
;; Use Flyspell for org & markdown only
(after! flyspell
  ;; prefer hunspell or aspell if available
  (setq ispell-program-name
        (cond
         ((executable-find "hunspell") "hunspell")
         ((executable-find "aspell")  "aspell")
         (t (or ispell-program-name "aspell")))) ;; fallback

  ;; Make sure flyspell uses the correct args for hunspell
  (when (string-equal ispell-program-name "hunspell")
    (setq ispell-really-hunspell t
          ispell-local-dictionary "en_US")))

;; Enable flyspell-mode only for writing modes
(add-hook 'org-mode-hook #'flyspell-mode)
(add-hook 'markdown-mode-hook #'flyspell-mode)

;; ORG

(after! org
  (setq org-todo-keywords
        '((sequence
           "TODO(t)"
           "STRT(s!)"
           "DELEG(g!)"
           "HOLD(h@)"
           "|"
           "DONE(d!)"
           "KILL(k@)"))
        org-capture-templates
        '(("w" "Work Task" entry
           (file+headline "~/org/todo.org" "Work Tasks")
           "* TODO [#B] %?\n:Created: %U\n"))))

;; Use Ruff's formatter for Python buffers.
(set-formatter! 'ruff
  '("ruff" "format" ("--stdin-filename=%s" (or buffer-file-name "stdin.py")) "-")
  :modes '(python-mode python-ts-mode))

;; ORG ROAM
;; org-roam base
(setq org-roam-directory (file-truename "~/org-roam"))
;; keep DB inside the directory so it syncs with git if you prefer (or set to ~/.local/share/org-roam)
(setq org-roam-db-location (expand-file-name "org-roam.db" org-roam-directory))

(setq org-roam-attachment-dir (expand-file-name "attachments/" org-roam-directory))
;; Enable autosync so org-roam picks up external changes
;; (function name depends on org-roam version)
(when (fboundp 'org-roam-db-autosync-enable)
  (org-roam-db-autosync-enable))
;; older versions:
;; (org-roam-db-autosync-mode)

;; Auto pull org-roam repo on start
(defun my/org-roam-git-pull-on-start ()
  "Pull changes in `org-roam-directory` on Emacs start."
  (when (and (executable-find "git")
             (bound-and-true-p org-roam-directory)
             (file-directory-p org-roam-directory)
             (file-directory-p (expand-file-name ".git" org-roam-directory)))
    (with-demoted-errors "Org-roam git pull error: %s"
      (let ((default-directory (file-name-as-directory (expand-file-name org-roam-directory))))
        (message "Pulling org-roam changes...")
        (call-process "git" nil nil nil "pull")
        (when (fboundp 'org-roam-db-sync)
          (org-roam-db-sync))))))

(add-hook 'emacs-startup-hook #'my/org-roam-git-pull-on-start)

;; Auto commit and push org-roam repo on exit
(defun my/org-roam-git-sync-on-exit ()
  "Commit and push changes in `org-roam-directory` on Emacs exit."
  (when (and (executable-find "git")
             (bound-and-true-p org-roam-directory)
             (file-directory-p org-roam-directory)
             (file-directory-p (expand-file-name ".git" org-roam-directory)))
    (with-demoted-errors "Org-roam git sync error: %s"
      (let ((default-directory (file-name-as-directory (expand-file-name org-roam-directory))))
        (unless (string-match-p "\\`[ \t\n\r]*\\'"
                                (shell-command-to-string "git status --porcelain"))
          (message "Committing org-roam changes...")
          (call-process "git" nil nil nil "add" "-A")
          (call-process "git" nil nil nil "commit" "-m"
                        (format "Auto-commit org-roam: %s"
                                (format-time-string "%Y-%m-%d %H:%M:%S"))))
        (message "Pushing org-roam changes...")
        (call-process "git" nil nil nil "push")))))

(add-hook 'kill-emacs-hook #'my/org-roam-git-sync-on-exit)

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)
              ("C-n" . 'copilot-next-completion)
              ("C-p" . 'copilot-previous-completion))

  :config
  (add-to-list 'copilot-indentation-alist '(prog-mode 4))
  (add-to-list 'copilot-indentation-alist '(org-mode 2))
  (add-to-list 'copilot-indentation-alist '(text-mode 2))
  (add-to-list 'copilot-indentation-alist '(clojure-mode 2))
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2)))

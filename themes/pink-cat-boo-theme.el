;;; themes/pink-cat-boo-theme.el -*- lexical-binding: t; -*-


;; If you are distributing this theme, please replace this comment
;; with the appropriate license attributing the original VS Code
;; theme author.

(deftheme pink-cat-boo "A nice dark theme.")


(let (
(color0 "#202330")
(color1 "#FFF0F5")
(color2 "#343744")
(color3 "#ffedf0")
(color4 "#472541")
(color5 "#393c49")
(color6 "#ffc8d3")
(color7 "#ffffff")
(color8 "#ffdce7")
(color9 "#fe7c8e")
(color10 "#6b6e7b")
(color11 "#A2C2EB")
(color12 "#6D7A72")
(color13 "#58B896")
(color14 "#ffc85b")
(color15 "#FF4791")
(color16 "#FAE8B6")
(color17 "#F5A6C6")
(color18 "#9b8c91")
(color19 "#2f323f")
(color20 "#2b2e3b")
(color21 "#fffbff"))


(custom-theme-set-faces
'pink-cat-boo


;; BASIC FACES
`(default ((t (:background ,color0 :foreground ,color1 ))))
`(hl-line ((t (:background ,color2 ))))
`(cursor ((t (:foreground ,color3 ))))
`(region ((t (:background ,color4 ))))
`(secondary-selection ((t (:background ,color5 ))))
`(fringe ((t (:background ,color0 ))))
`(mode-line-inactive ((t (:background ,color6 :foreground ,color7 ))))
`(mode-line ((t (:background ,color8 :foreground ,color7 ))))
`(minibuffer-prompt ((t (:foreground ,color9 ))))
`(vertical-border ((t (:foreground ,color10 ))))


;; FONT LOCK FACES
`(font-lock-builtin-face ((t (:foreground ,color11 :fontStyle :bold t ))))
`(font-lock-comment-face ((t (:foreground ,color12 :fontStyle :bold nil :italic nil :underline nil ))))
`(font-lock-constant-face ((t (:foreground ,color13 :fontStyle :bold nil :italic nil :underline nil ))))
`(font-lock-function-name-face ((t (:foreground ,color14 :fontStyle :bold nil :italic nil :underline nil ))))
`(font-lock-keyword-face ((t (:foreground ,color15 :fontStyle :bold nil :italic nil :underline nil ))))
`(font-lock-string-face ((t (:foreground ,color16 :fontStyle :bold nil :italic nil :underline nil ))))
`(font-lock-type-face ((t (:foreground ,color17 :fontStyle :underline t ))))


;; linum-mode
`(linum ((t (:foreground ,color18 ))))
`(linum-relative-current-face ((t (:foreground ,color18 ))))


;; display-line-number-mode
`(line-number ((t (:foreground ,color18 ))))
`(line-number-current-line ((t (:foreground ,color18 ))))


;; THIRD PARTY PACKAGE FACES


;; doom-modeline-mode
`(doom-modeline-bar ((t (:background ,color8 :foreground ,color7 ))))
`(doom-modeline-inactive-bar ((t (:background ,color6 :foreground ,color7 ))))


;; web-mode
`(web-mode-string-face ((t (:foreground ,color16 ))))
`(web-mode-html-tag-face ((t (:foreground ,color15 ))))
`(web-mode-html-tag-bracket-face ((t (:foreground ,color15 ))))
`(web-mode-html-attr-name-face ((t (:foreground ,color17 ))))


;; company-mode
`(company-tooltip ((t (:background ,color19 :foreground ,color7 ))))


;; org-mode
`(org-block ((t (:background ,color20 :foreground ,color21 ))))
`(org-block-begin-line ((t (:foreground ,color12 ))))))


(custom-theme-set-variables
  'pink-cat-boo
  '(linum-format " %3i "))


;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))


;;;###autoload
(defun pink-cat-boo-theme()
  "Apply the pink-cat-boo-theme."
  (interactive)
  (load-theme 'pink-cat-boo t))


(provide-theme 'pink-cat-boo)


;; Local Variables:
;; no-byte-compile: t
;; End:


;; Generated using https://github.com/nice/themeforge
;; Feel free to remove the above URL and this line.

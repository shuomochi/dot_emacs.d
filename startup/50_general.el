;;; 50_general.el --- 未整理

;;; Commentary:
;;; code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 表示関連
;;

;; mode line settings
(line-number-mode t)
(column-number-mode t)

;;; 対応する括弧をハイライト
(show-paren-mode t)

;; メニューバーの非表示
(menu-bar-mode -1)

;; ツールバーの非表示
(tool-bar-mode -1)

;; 時刻をモードラインに表示
;;(display-time-mode t)
 
;; 左端に行数を表示させる
;; (global-linum-mode t)

;; スクロールを滑らかに
;(setq scroll-step 5)

;; 起動時の Emacsロゴなどのメッセージを出さない
(setq inhibit-startup-message t)

;; *scratch* バッファの初期メッセージを消す
;; (setq initial-scratch-message "")

;; font
;;(set-default-font "Ricty Diminished")
(set-frame-font "Ricty Diminished")
(add-to-list 'default-frame-alist '(font . "Ricty Diminished-12"))
(add-to-list 'default-frame-alist '(width . 120))
(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(top . 30))
(add-to-list 'default-frame-alist '(left . 800))

;; 初期表示位置

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; キーバインド
;;

;; 行頭の kill-line (C-k) で行ごと削除
(setq kill-whole-line t)
 
;; CUAモード(C-RET) 有効
(cua-mode t)
(setq cua-enable-cua-keys nil)

;; M-n M-pで複数行移動
(global-set-key (kbd "M-n")
		(lambda() (interactive) (next-line 5)))
(global-set-key (kbd "M-p")
		(lambda() (interactive) (previous-line 5)))

;; C-v > Scroll up
;;(global-set-key (kbd "C-v") 'scroll-up)
 
;; C-h > バックスペース
;;(global-set-key (kbd "C-h") 'delete-backward-char)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; IME設定
;;

;; windows設定ファイルへ
;; (setq default-input-method "W32-IME")
;;(setq-default w32-ime-mode-line-state-indicator "[--]")
;;(setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))

;; 日本語入力時にカーソルの色を変える設定 (色は適宜変えてください)
;;(global-set-key [kanji] 'toggle-input-method)
;;(add-hook 'w32-ime-on-hook '(lambda () (set-cursor-color "coral3")))
;;(add-hook 'w32-ime-off-hook '(lambda () (set-cursor-color "orchid")))

;; MAC設定ファイルへ
;; (when (fboundp 'mac-input-source)
;;     (defun my-mac-selected-keyboard-input-source-chage-function ()
;;       "英語のときはカーソルの色を黄色に、日本語のときは赤にします."
;;       (let ((mac-input-source (mac-input-source)))
;;         (set-cursor-color
;;           (if (string-match "com.google.inputmethod.Japanese.Roman" mac-input-source)
;;               "White" "Yellow"))))
;;     (add-hook 'mac-selected-keyboard-input-source-change-hook
;;               'my-mac-selected-keyboard-input-source-chage-function))

;; ミニバッファにカーソルが移動すると自動的に英語モードにする
;; (when (functionp 'mac-auto-ascii-mode)
;;    (mac-auto-ascii-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; diredの設定
;;

;; Macへ
;; "ls does not support --dired; see ‘dired-use-ls-dired’ for more details."
;; のエラー回避(参考：https://qiita.com/tetsuo_jp/items/fce40ffe4222cb3dbd70)
(let ((gls "/usr/local/bin/gls"))
  (if (file-exists-p gls) (setq insert-directory-program gls)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; その他
;;

;; 自動保存されるバックアップファイルの置き場所を ~/.emacs.d/backup に変更する
(setq backup-directory-alist
  (cons (cons ".*" (expand-file-name "~/.emacs.d/backup"))
        backup-directory-alist))
(setq auto-save-file-name-transforms
      `((".*", (expand-file-name "~/.emacs.d/backup/") t)))


;; bash on windows
(defun my-bash-on-windows-shell()
  (let ((explicit-shell-file-name "C:/Windows/System32/bash.exe"))
    (shell)))

;; ;; theme
;; (use-package doom-themes
;;     :custom
;;     (doom-themes-enable-italic t)
;;     (doom-themes-enable-bold t)
;;     :custom-face
;;     ;;(doom-modeline-bar ((t (:background "#6272a4"))))
;;     :config
;;     (load-theme 'doom-dracula t)
;;     (doom-themes-neotree-config)
;;     (doom-themes-org-config))

(use-package color-theme-modern :demand
  :config
  (load-theme 'dark-blue2 t t)
  (enable-theme 'dark-blue2)
  )
  
  

(use-package ivy :demand
  :config
  (use-package ivy-hydra)
  ;; `ivy-switch-buffer' (C-x b) のリストに recent files と bookmark を含める
  (setq ivy-use-virtual-buffers t
	ivy-count-format "%d/%d")
  ;; minibufferのサイズを拡大(30のほうがいい？)
  (setq ivy-height 10)

  (setq ivy-re-builders-alist
	'((t . ivy--regex-plus)))

  ;; ミニバッファでコマンド発行を認める
  (when (setq enable-recursive-minibuffers t)
    (minibuffer-depth-indicate-mode 1)) ;; 何階層入ったかプロンプトに表示する

  ;; ESC連打でミニバッファを閉じる
  (define-key ivy-minibuffer-map (kbd "<escape>") 'minibuffer-keyboard-quit)

  ;; アクティベート
  (ivy-mode 1))


(use-package migemo
  :config
  (setq migemo-command "cmigemo")
  (setq migemo-options '("-q" "--emacs" "-i" "\a"))
  (setq migemo-dictionary "c:/apps/cmd/cmigemo-default-win64/dict/utf-8/migemo-dict")
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  ;; charset encoding
  (setq migemo-coding-system 'utf-8-unix)
  ;;(setq migemo-coding-system 'cp932-unix)
  )

(use-package avy)

(use-package swiper
  :bind ("C-c C-s" . swiper) ;  (global-set-key (kbd "C-s") 'swiper)

  :config
  (use-package avy-migemo
    :config
    (avy-migemo-mode 1)
    (setq avy-timeout-seconds nil)
    ;; avy-migemoをswiperで使えるように、というものだが、動いていないっぽい。バージョンの問題？(2019/09/16)
    (require 'avy-migemo-e.g.swiper)
    :bind ("C-M-;" . avy-migemo-goto-char-timer)
  ))

(use-package counsel
  :bind (("M-x" . counsel-M-x) 
	 ("C-x C-f" . counsel-find-file))
  :config
  (setq counsel-find-file-iqnore-regexp	(regexp-opt '("./" "../")))
  )
;  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history))


(use-package recentf-ext
  :bind ("C-x C-r" . recentf-open-files) ; (global-set-key (kbd "C-x C-r") 'recentf-open-files)
  
  :config
  (setq recentf-max-saved-items 2000)
  (setq recentf-exclude '(".recentf"))
  (setq recentf-auto-cleanup 10)
  (setq recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list))
  (recentf-mode 1)
;; 起動画面削除
;;(setq inhibit-startup-message t)

;; 起動画面で recentf を開く
;;(add-hook 'after-init-hook (lambda()
;;    (recentf-open-files)
;;    ))
  )


;; (use-package yasnippet
;;   :config
;;   (setq yas-snippet-dirs
;; 	'("~/.emacs.d/yasnippets" ;; お好みで!!
;; 	  yas-installed-snippets-dir  ;; packageに最初から含まれるスニペット
;; 	))
;;   (yas-global-mode t)
;;   (bind-key "C-x y i" 'yas-insert-snippet yas-minor-mode-map)
;;   (bind-key "C-x y n" 'yas-new-snippet yas-minor-mode-map)
;;   (bind-key "C-x y v" 'yas-visit-snippet-file yas-minor-mode-map)
;;   )

(use-package company
  :config
  (bind-keys :map company-active-map
	     ("C-n" . company-select-next)
	     ("C-p" . company-select-previous)
	     ("<tab>" . company-complete-selection)
	     )
  (bind-keys :map company-search-map
	     ("C-n" . company-select-next)
	     ("C-p" . company-select-previous)
	     )
  (global-company-mode) ; 全バッファで有効にする
  ;;(setq company-idle-delay 0) ;; デフォルトは0.5
  ;;(setq company-minimum-prefix-length 2) ;; デフォルトは4
  (setq company-selection-wrap-around t) ;; 候補の一番下でさらに下に行こうとすると一番上に戻る
  )
  
;; (use-package lsp-mode
;;   :custom ((lsp-inhibit-message t)
;; 	   (lsp-message-project-root-warning t)
;; 	   (create-lockfiles nil))
;;   :hook   (prog-major-mode . lsp-prog-major-mode-enable))
(use-package lsp-mode
  :hook (dart-mode . lsp)
  :custom
  (lsp-print-io t)
  (lsp-enable-snippet nil)
  :commands lsp)

;; optionaly
(use-package lsp-ui
  :custom
  ;; lsp-ui-doc
  (lsp-ui-doc-enable nil)
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature nil)
  (lsp-ui-doc-position 'at-point) ;; top, bottom, or at-point
  (lsp-ui-doc-max-width 150)
  (lsp-ui-doc-max-height 30)
  (lsp-ui-doc-use-childframe t)
  (lsp-ui-doc-use-webkit t)
  
  ;; lsp-ui-flycheck
  (lsp-ui-flycheck-enable t)

  ;; lsp-ui-peek
  (lsp-ui-peek-enable t)
  (lsp-ui-peek-peek-height 20)
  (lsp-ui-peek-list-width 50)
  (lsp-ui-peek-fontify 'on-demand) ;; never, on-demand, or always
  
  ;; lsp-ui-imenu
  (lsp-ui-imenu-enable nil)
  (lsp-ui-imenu-kind-position 'top)
  
  ;; lsp-ui-sideline
  (lsp-ui-sideline-enable nil)
  
  :commands lsp-ui-mode
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  ;(eval-after-load "flymake"
  ;  (setq flymake-fringe-indicator-position nil)
  ;  )  
  )
(use-package company-lsp
;:commands company-lsp
  :after (lsp-mode company)
  :init (push 'company-lsp company-backends)
  )
;;(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;;(use-package lsp-treemacs :commands lsp-treemacs-errors-list)
;; optionally if you want to use debugger
;;(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; (use-package lsp-ui
;;   :after lsp-mode
;;   :custom (scroll-margin 0)
;;   :hook (lsp-mode . lsp-ui-mode))

;; (use-package company-lsp
;;   :after (lsp-mode company yasnippet)
;;   :defines company-backends
;;   :functions company-backend-with-yas
;;   :init (cl-pushnew (company-backend-with-yas 'company-lsp) company-backends))

(use-package flycheck
  :config
;;  (global-flycheck-mode)
  )

(use-package lua-mode
  ;; C-c C-l でlua-send-buffer 現在のluaファイルをREPLで実行
  :config
  (setq lua-indent-level 2)
  )

(use-package js2-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(use-package plantuml-mode
  :config
  ;; .pu拡張子のファイルをplantuml-modeで開く
  ;; (add-to-list 'auto-mode-alist '("\\.pu$\\|\\.puml$" . plantuml-mode))
  (add-to-list 'auto-mode-alist '("\\.puml$" . plantuml-mode))
  
  ;; あなたのplantuml.jarファイルの絶対パスをかく
  ;;(setq plantuml-jar-path "/usr/local/Cellar/plantuml/1.2019.6/libexec/plantuml.jar")
  (setq plantuml-jar-path "c:/apps/devtools/plantuml/plantuml.1.2019.10.jar")
;;  (setq plantuml-jar-path "~/plantuml.jar")
  ;; javaにオプションを渡したい場合はここにかく
  (setq plantuml-java-options "")
  ;; plantumlのプレビューをsvg, pngにしたい場合はここをコメントイン
  ;; デフォルトでアスキーアート
  (setq plantuml-output-type "png")
  ;; 日本語を含むUMLを書く場合はUTF-8を指定
  (setq plantuml-options "-charset UTF-8")
  ;; (setq plantuml-mode-map
  ;;       (let ((map (make-sparse-keymap)))
  ;;         (define-key map (kbd "C-c C-c") 'plantuml-execute)
  ;;         map))

  (bind-keys :map plantuml-mode-map
	     ;; plantuml-modeの時にC-c C-sでplantuml-save-png関数を実行
	     ("C-c C-o" . plantuml-save-png)
	     )
  
  ;; もしも.puファイルを保存した時にpngファイルを保存したい場合はこちらをコメントイン
  ;; (add-hook ‘plantuml-mode-hook
  ;; (lambda () (add-hook ‘after-save-hook ‘plantuml-save-png)))

  ;; plantumlをpngで保存する関数
  (defun plantuml-save-png ()
    (interactive)
    (when (buffer-modified-p)
      (map-y-or-n-p "Save this buffer before executing PlantUML?"
		    ‘save-buffer (list (current-buffer))))
    (let ((code (buffer-string))
	  out-file
	  cmd)
      (when (string-match "^\\s-*@startuml\\s-+\\(\\S-+\\)\\s*$" code)
	(setq out-file (match-string 1 code)))
      (setq cmd (concat
		 "java -Djava.awt.headless=true -jar " plantuml-java-options " "
		 (shell-quote-argument plantuml-jar-path) " "
		 (and out-file (concat "-t" (file-name-extension out-file))) " "
		 plantuml-options " "
		 (buffer-file-name)))
      (message cmd)
      (call-process-shell-command cmd nil 0)))

  
;; (defun plantuml-execute ()
;;   (interactive)
;;   (when (buffer-modified-p)
;;     (map-y-or-n-p "Save this buffer before executing PlantUML?"
;;                   'save-buffer (list (current-buffer))))
;;   (let ((code (buffer-string))
;;         out-file
;;         cmd)
;;     (when (string-match "^\\s-*@startuml\\s-+\\(\\S-+\\)\\s*$" code)
;;       (setq out-file (match-string 1 code)))
;;     (setq cmd (concat
;;                "java -jar " plantuml-java-options " "
;;                (shell-quote-argument plantuml-jar-path) " "
;;                (and out-file (concat "-t" (file-name-extension out-file))) " "
;;                plantuml-options " "
;;                (buffer-file-name)))
;;     (message cmd)
;;     (shell-command cmd)
;;     (message "done")))
;; )

;; (defun plantuml-execute ()
;;     (interactive)
;;     (when (buffer-modified-p)
;;       (map-y-or-n-p "Save this buffer before executing PlantUML?"
;; 		    'save-buffer (list (current-buffer))))
;;     (let ((code (buffer-string))
;; 	  out-file
;; 	  cmd)
;;       (when (string-match "^\\s-*@startuml\\s-+\\(\\S-+\\)\\s*$" code)
;; 	(setq out-file (match-string 1 code)))
;;       (setq cmd (concat
;; 		 "java -jar " plantuml-java-options " "
;; 		 (shell-quote-argument plantuml-jar-path) " "
;; 		 (and out-file (concat "-t" (file-name-extension out-file))) " "
;; 		 plantuml-options " "
;; 		 (buffer-file-name)))
;;       (message cmd)
;;       (shell-command cmd)
;;       (cond ((not window-system)
;; 	     (find-file file))
;; 	    ((eq system-type 'windows-nt)
;; 	     ;;png専用
;; 	     (call-process "cmd.exe" nil 0 nil "/c" "start" "" (replace-regexp-in-string "puml" "png" (convert-standard-filename buffer-file-name)))))   
;;       (message "done")))      
;; ;;      (message "done")))
  )

(use-package dart-mode
  :config
  ;; (add-hook 'dart-mode-hook 'lsp)
  ;;  (setq dart-enable-analysis-server t)
  ;;  (add-hook 'dart-mode-hook 'flycheck-mode)

  ;; (defun project-try-dart (dir)
  ;;   (let ((project (or (locate-dominating-file dir "pubspec.yaml")
  ;; 		       (locate-dominating-file dir "BUILD"))))
  ;;     (if project
  ;; 	  (cons 'dart project)
  ;; 	(cons 'transient dir))))
  ;; (add-hook 'project-find-functions #'project-try-dart)
  ;; (cl-defmethod project-roots ((project (head dart)))
  ;;   (list (cdr project)))

  (with-eval-after-load "projectile"
    (add-to-list 'projectile-project-root-files-bottom-up "pubspec.yaml")
    (add-to-list 'projectile-project-root-files-bottom-up "BUILD"))
  
  (setq lsp-auto-guess-root t)  
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 自前関数
;;

;; macへ移動
;; Finderを開く
;; current directory open
(defun finder-current-dir-open()
  (interactive)
  (shell-command "open ."))

;; directory open
(defun finder-open(dirname)
  (interactive "DDirectoryName:")
  (shell-command (concat "open " dirname)))

;; set the keybind
(global-set-key (kbd "C-c C-f") 'finder-current-dir-open)

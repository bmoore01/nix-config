;;; init.el -- Initialization of my config -*- lexical-binding:t -*-


;; Setup package archieves
(require 'package)
(setq package-archives '(("org" . "http://orgmode.org/elpa/")
	     ("gnu" . "http://elpa.gnu.org/packages/")
	     ("melpa-stable" . "http://stable.melpa.org/packages/")
	     ("melpa" . "http://melpa.org/packages/")))
(package-initialize)


;; If use package isn't installed, install it
(unless (package-installed-p 'use-package)
  (package-refresh-contents) ; updage packages archive
  (package-install 'use-package))


;; Initialize use-package before loading config
(require 'use-package)

;; Enable quelpa with use-package
;;(quelpa
;; '(quelpa-use-package
;;   :fetcher git
;;   :url "https://github.com/quelpa/quelpa-use-package.git"))
;;(require 'quelpa-use-package)

;;(unless (package-installed-p 'quelpa)
;;(with-temp-buffer
;;  (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
;;  (eval-buffer)
;;  (quelpa-self-upgrade)))

;; Set use package to install from ELPA unless :quelpa keyword is found
;; otherwise `:ensure t` causes everything to be downloaded from quelpa
;;(quelpa-use-package-activate-advice)

(org-babel-load-file (concat user-emacs-directory "config.org"))
;;; init.el ends here

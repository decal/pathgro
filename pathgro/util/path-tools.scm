(define-module (pathgro util path-tools)
  #:use-module (ice-9 regex)
  #:export     (directory? expand-user expand-variables basefilename extname))


;; ------------------------------------------------------ ;;
;; Get base file name without extension from pathname.    ;;
;; Like basename, but does not have what extname would    ;;
;; include. The result will also not include any dots.    ;;
;; ------------------------------------------------------ ;;
;; #:param: path :: string - path                         ;;
;; ------------------------------------------------------ ;;
(define (basefilename afile)
  (car (string-split (basename afile) #\.)))

;; ------------------------------------------------------ ;;
;; Extract file extension string from path name.          ;;
;; Essentially emulate extname() functions, but do not    ;;
;; include a period at beginning of returned string.      ;;
;; ------------------------------------------------------ ;;
;; #:param: path :: string - path                         ;;
;; ------------------------------------------------------ ;;
(define (extname afile)
  (define (extname-helper acnt alen alst)
    (if (= acnt (- alen 1))
      (list-ref alst acnt)
      (string-append (list-ref alst acnt) "." (extname-helper (+ 1 acnt) alen alst))))
  (letrec* ((alst (string-split afile #\.))
            (alen (length alst)))
    (if (>= 1 alen)
      afile
      (extname-helper 1 alen alst))))

;; ------------------------------------------------------ ;;
;; Check whether 'path' is an existing directory.         ;;
;; Follows symlinks.                                      ;;
;; ------------------------------------------------------ ;;
;; #:param: path :: string - path                         ;;
;;                                                        ;;
;; #:return: x :: bool - #t if 'path' is an existing dir, ;;
;;           #f otherwise                                 ;;
;; ------------------------------------------------------ ;;
(define (directory? path)
  (and (file-exists? path)
       (eq? 'directory (stat:type (stat path)))))

;; ------------------------------------------------------ ;;
;; Expand initial '~' or '~user' in a path by replacing   ;;
;; it with user's home directory. If the path does not    ;;
;; begin with '~', 'path' is returned unchanged.          ;;
;; If 'user' is not found path is returned unchanged.     ;;
;; ------------------------------------------------------ ;;
;; #:param: path :: string - path                         ;;
;;                                                        ;;
;; #:return: x :: string - 'path' with initial '~' or     ;;
;;           '~user' expanded                             ;;
;; ------------------------------------------------------ ;;
(define (expand-user path)
  (if (not (string-prefix? "~" path))
    path
    (catch 'misc-error
      (lambda ()
        (let* ((i (string-index path #\/ 1))
               (index (if i i (string-length path)))
               (pw (if (eq? index 1)
                     ;; if path is of form '~/path'
                     (getpwuid (getuid))
                     ;; if path is of form '~user/path'
                     (getpwnam (substring path 1 index)))) ;; <- throws if no such user
               (home (passwd:dir pw)))
          (string-replace path home 0 index)))
      (lambda (key . args)
        path))))


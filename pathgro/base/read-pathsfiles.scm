(define-module (pathgro base read-pathsfiles)
               #:use-module (ice-9 common-list)
               #:export (bases dirns extns read-pathsfiles handle-pathstr))

(use-modules ((pathgro util splitter)))
(use-modules ((pathgro util read-lines)))
(use-modules ((pathgro util clean-list) #:select (flatten unblank unempty ununspec clean)))

(define-values (bases dirns extns) (values '() '() '()))

(define (string-haschar? astr achr)
  (not (eq? #f (string-index astr achr))))

(define (pathstr-hasdir? aname)
    (string-haschar? aname #\/))

(define (pathstr-hasext? aname)
    (string-haschar? aname #\.))

(define (pathstr-isdir? aname)
  (letrec ((asize (string-length aname))
           (szdec (- asize 1)))
    (= 1 (string-suffix-length aname "/" szdec asize))))

(define (extname afile)
    (cadr (string-split afile #\.)))

;(define (uniq e)
;  (if (null? e)
;    '()
;    (cons (car e) (uniq (filter (lambda (x) (not (string=? x (car e)))) (cdr e))))))

(define (handle-pathstr patho)
  (if (null? patho)
    '()
    (let ((copad (cons patho dirns)))
      (if (pathstr-hasdir? patho)
        (if (pathstr-isdir? patho)
            (set! dirns (uniq (unblank copad)))
            (begin
              (set! dirns (uniq (unblank (cons (dirname patho) dirns))))
              (handle-pathstr (basename patho))))
          (if (pathstr-hasext? patho)
            (let ((anext (extname patho)))
                (set! extns (uniq (unblank (cons anext extns))))
                (set! bases (uniq (unblank (cons (basename patho (string-append "." anext)) bases)))))
            (set! dirns (uniq (unblank copad))))))))

(define (apply-all alist)
  (if (null? alist)
    '()
    (cons (map handle-pathstr (car alist)) (apply-all (cdr alist)))))

(define (read-pathsfiles files-list)
  (if (null? files-list)
    '()
    (if (not (file-exists? (car files-list)))
      (read-pathsfiles (cdr files-list))
      (cons (apply-all (delete "" (splitter (read-lines (car files-list))))) (read-pathsfiles (cdr files-list))))))

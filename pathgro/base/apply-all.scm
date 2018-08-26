(define-module (pathgro base apply-all)
               #:export (apply-all)
               #:use-module (pathgro base read-pathsfiles)) 

(define (apply-all alist)
  (if (null? alist)
    '()
    (cons (map handle-pathstr (car alist)) (apply-all (cdr alist)))))

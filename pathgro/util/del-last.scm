(define-module (pathgro util del-last)
               #:export (del-last))

(define (empty? list)
  (eq? list '()))

(define (del-last alist)
  (define (iter li rem)
    (cond ((empty? alist) rem)
          ((empty? (cdr alist)) rem)
          (else (iter (cdr alist) (cons (car alist) rem)))))
  (reverse (iter alist '())))

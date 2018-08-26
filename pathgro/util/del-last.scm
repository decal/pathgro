(define-module (pathgro util del-last)
               #:export (del-last))

(define (empty? list)
     (eq? list '()))

(define (del-last list)
  (define (iter li rem)
    (cond ((empty? li) rem)
          ((empty? (cdr li)) rem)
          (else (iter (cdr li) (cons (car li) rem)))))
  (reverse (iter list '())))

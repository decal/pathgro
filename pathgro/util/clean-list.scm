(define-module (pathgro util clean-list)
               #:export (suniq flatten unblank unempty ununspec clean))

(use-modules (ice-9 common-list))

(define flatten
  (lambda (e)
    (cond
      ((pair? e) `(,@(flatten (car e)) ,@(flatten (cdr e))))
      ((null? e) '())
      (else (list e)))))

;(define unspecified (begin))
;(define (unspecified? v) (eq? unspecified) v)

(define (ununspec l) (noop l))
  ;(delete unspecified l))

(define (unblank l)
  (delete "" l))

(define (unempty l)
  (delete '() l))

(define (suniq e)
  (if (null? e)
    '()
    (cons (car e) (uniq (filter (lambda (x) (not (string=? x (car e)))) (cdr e))))))

(define (clean l)
  (suniq (ununspec (unblank (unempty (flatten l))))))

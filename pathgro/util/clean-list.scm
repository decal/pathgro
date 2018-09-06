(define-module (pathgro util clean-list)
               #:use-module (ice-9 common-list)
               #:use-module (srfi srfi-1)
               #:export (output-list suniq flatten blank empty blank? empty? unblank unempty unempty-unblank unblank-unempty ununspec clean))

(use-modules (pathgro util stdio))
(use-modules (pathgro base path-slashes))

(define (output-list l)
  (for-each println (clean l)))

(define (flatten x)
  (reverse
    (let loop ((x x) (r '()))
      (if (pair? x)
        (loop (cdr x) (loop (car x) r))
          (if (null? x)
            r
            (cons x r))))))

;(define (flatten e)
  ;(cond
    ;((pair? e) `(,@(flatten (car e)) ,@(flatten (cdr e))))
    ;((null? e) '())
    ;(else (list e))))

;(define unspecified (begin))
;(define (unspecified? v) (eq? unspecified) v)

(define (ununspec l) (noop l))
  ;(delete unspecified l))

(define empty '())

(define (empty? l)
  (eq? empty))

(define blank "")

(define (unblank l)
  (delete! blank l))

(define (blank? l)
  (eq? blank))

(define (unempty l)
  (delete! empty l))

(define (remove-dups l)
  (cond
    [(empty? l) empty]
    [(empty? (rest l)) l]
    [else
      (let ([i (first l)])
        (if (equal? i (first (rest l)))
          (remove-dups (rest l))
          (cons i (remove-dups (rest l)))))]))

(define (suniq e)
  (if (null? e)
    '()
    (let ((ce (car e)))
      (if (or (eq? ce '()) (string=? ce blank))
        (suniq (filter (lambda (x) (not (string=? x ce))) (cdr e)))
        (cons ce (suniq (filter (lambda (x) (not (string=? x ce))) (cdr e))))))))

(define (unempty-unblank l)
  (filter (lambda (e) (not (or (eq? e empty) (string=? blank e)))) alist))

(define (unblank-unempty l) unempty-unblank)

(define (clean l)
  (delete-duplicates!
    (unempty
      (unblank
        (flatten l)))))

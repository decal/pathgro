(define-module (pathgro util clean-list)
               #:use-module (ice-9 common-list)
               #:use-module (srfi srfi-1)
               #:export (rm2deep pathcnt output-list suniq flatten blank? empty? unblank unempty clean))

(use-modules (pathgro util stdio))
(use-modules (pathgro base path-slashes))

(define pathcnt 0)

(define (output-list l)
  (set! pathcnt (+ pathcnt (length (map println (clean l))))))

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

(define (empty? l)
  (eq? '()))

(define (unblank l)
  (delete! "" l))

(define (blank? l)
  (eq? ""))

(define (unempty l)
  (delete! '() l))

(define (remove-dups l)
  (cond
    [(empty? l) '()]
    [(empty? (cdr l)) l]
    [else
      (let ([i (car l)])
        (if (equal? i (car (cdr l)))
          (remove-dups (cdr l))
          (cons i (remove-dups (cdr l)))))]))

(define (suniq e)
  (if (null? e)
    '()
    (let ((ce (car e)))
      (if (or (eq? ce '()) (string=? ce ""))
        (suniq (filter (lambda (x) (not (string=? x ce))) (cdr e)))
        (cons ce (suniq (filter (lambda (x) (not (string=? x ce))) (cdr e))))))))

;(define (unempty-unblank l)
;  (filter (lambda (e) (not (or (eq? e '()) (string=? "" e)))) l))

;(define (unblank-unempty l) unempty-unblank)

(define (clean l)
  (delete-duplicates!
    (unempty
      (unblank
        (flatten l)))))

(define (rm2deep pdep plst)
  (if (null? plst)
    '()
    (letrec ((acar (car plst))
             (slln (string-count acar #\/)))
      (if (<= slln pdep)
        (cons acar (rm2deep pdep (cdr plst)))
        (rm2deep pdep (cdr plst))))))

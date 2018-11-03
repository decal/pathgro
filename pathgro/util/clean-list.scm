(define-module (pathgro util clean-list)
               #:use-module (ice-9 common-list)
               #:use-module (ice-9 regex)
               #:use-module (srfi srfi-1)
               #:export (pathcnt output-list suniq flatten blank? empty? unblank unempty unempty-unblank unblank-unempty ununspec clean clean2 empty-string-list?))

(use-modules (pathgro util stdio))
(use-modules (pathgro base path-slashes))

(define pathcnt 0)

(define (perform-slash-regexps astr)
  (let ((rstr (regexp-substitute/global #f "/+" astr 'pre "/" 'post)))
      (regexp-substitute/global #f "/$" rstr 'pre "" 'post)))

(define (regexps-and-print s)
  (println (perform-slash-regexps s)))

(define (output-list l)
  (set! pathcnt (+ pathcnt (length (map regexps-and-print (clean l))))))

(define (flatten x)
  (reverse!
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
      (if (or (eq? ce '()) (string=? ce ""))
        (suniq (filter (lambda (x) (not (string=? x ce))) (cdr e)))
        (cons ce (suniq (filter (lambda (x) (not (string=? x ce))) (cdr e))))))))

(define (unempty-unblank l)
  (filter (lambda (e) (not (or (eq? e '()) (string=? "" e)))) l))

(define (unblank-unempty l) unempty-unblank)

(define (clean2 l)
  (delete-duplicates!
    (unempty-unblank
      (flatten l))))

(define (clean l)
  (delete-duplicates!
        (flatten l)))

(define (empty-string-list? alist)
  (if (null? alist)
    alist
    (and (= 1 (length alist)) (eq? (car alist) ""))))

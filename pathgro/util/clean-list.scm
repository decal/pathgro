(define-module (pathgro util clean-list)
               #:use-module (ice-9 common-list)
               #:use-module (ice-9 regex)
               #:use-module (srfi srfi-1)
               #:export (rm2deep pathcnt output-list suniq flatten blank? empty? unblank unempty clean))

(use-modules (pathgro util stdio))
(use-modules (pathgro base path-slashes))
(use-modules (pathgro base path-strings))

(define pathcnt 0)

(define (perform-slash-regexps astr)
  (let ((rstr (regexp-substitute/global #f "/+" astr 'pre "/" 'post)))
      (regexp-substitute/global #f "/$" rstr 'pre "" 'post)))

(define (regexps-and-print s)
  (println (perform-slash-regexps s)))

(define (output-list n l)
  (if (zero? n)
    (set! pathcnt (+ pathcnt (length (map regexps-and-print (clean l)))))
    (set! pathcnt (+ pathcnt (length (map regexps-and-print (clean (take-string-upto-length n l))))))))

(define (flatten x)
  (reverse!
    (let loop ((x x) (r '()))
      (if (pair? x)
        (loop (cdr x) (loop (car x) r))
          (if (null? x)
            r
            (cons x r))))))

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

(define (clean l)
  (delete-duplicates!
        (flatten l)))

(define (empty-string-list? alist)
  (if (null? alist)
    alist
    (and (= 1 (length alist)) (eq? (car alist) ""))))

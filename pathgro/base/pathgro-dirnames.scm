(define-module (pathgro base pathgro-dirnames)
               #:export (pathgro-dirnames combine-paths)
               #:use-module (ice-9 common-list))

(use-modules ((pathgro base read-pathsfiles) #:select (bases dirns extns)))

(define (combine-paths slist elist)
  (map (lambda (x)
         (map (lambda (y)
                (string-append x (string-append "." y)))
              elist))
       slist))

(define (flatten e)
  (cond
    ((pair? e) `(,@(flatten (car e)) ,@(flatten (cdr e))))
    ((null? e) '())
    (else (list e))))

(define (combine-files dlist flist)
  (flatten (map (lambda (d)
      (map (lambda (f)
             (string-append d f))
           flist))
       dlist)))

(use-modules (srfi srfi-1))

(define (powerset slst)
  (if (null? slst)
  '(())
  (append-map (lambda (x) (list x (cons (car slst) x))) (powerset (cdr slst)))))

(define (pathgro-dirnames adepth cfiles)
  (define (join-path alst)
    (define (join-path-helper acnt hlst)
      (cond
        ((null? hlst) "")
        ((= adepth acnt) "")
        ((pair? hlst) (string-append (car hlst) "/" (join-path-helper (+ 1 acnt) (cdr hlst))))))
    (string-append "/" (join-path-helper 0 alst)))
  (letrec*
    ((aset (powerset dirns))
     (amap (map join-path aset)))
    (append amap (flatten (combine-files amap cfiles)))))

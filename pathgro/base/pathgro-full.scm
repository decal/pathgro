(define-module (pathgro base pathgro-full)
               #:export (pathgro-full combine-paths)
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

(define (pathgro-full fdepth cfiles)
  (define (join-path alst)
    (define (join-path-helper acnt hlst)
      (cond
        ((or (null? hlst) (= fdepth acnt)) "")
        ((pair? hlst) (string-append (car hlst) "/" (join-path-helper (+ 1 acnt) (cdr hlst))))
        ((list? hlst) (string-append (car hlst) "/" (join-path-helper (+ 1 acnt) (cdr hlst))))))
    (string-append "/" (join-path-helper 0 alst)))
  (letrec*
    ((aset (powerset dirns))
     (amap (map join-path aset))
     (apts (flatten (map (lambda (l)
                  (combine-files amap l))
                cfiles))))
    (append amap apts)))

(define-module (pathgro base path-powerset)
               #:export (path-powerset combine-paths combine-paths-helper combine-files combine-files-helper)
               #:use-module (ice-9 common-list))

(use-modules ((pathgro util clean-list)))
(use-modules ((pathgro util splitter) #:select (max-depth)))

(define (combine-paths-helper slist elist)
  (map (lambda (x)
         (map (lambda (y)
                (string-append/shared x y))
              elist))
       slist))

(define (combine-paths maxdc slist elist)
  (if (< maxdc (+ (length slist) (length elist)))
    '()
    (combine-paths-helper slist elist)))

(define (combine-files-helper dlist flist)
  (map (lambda (d)
         (map (lambda (f) 
                (string-append/shared d "." f))
              flist))
       dlist))

(define (drop-string-length slen slst)
  (filter (lambda (s) (<= slen (string-count s #\/))) slst))

(define (drop-length llen llst)
  (filter (lambda (l) (>= llen (length l))) llst))

(define (combine-files maxdc dlist flist)
  (if (>= maxdc (length dlist))
    '()
    (combine-files-helper dlist flist)))

(use-modules (srfi srfi-1))

(define (powerset set)
  (if (null? set) '(())
    (let ((ps-rest (powerset (cdr set))))
      (if (> (length set) max-depth)
        (powerset (cdr set)) 
        (append ps-rest
                (map (lambda (ss)
                       (cons (car set) ss)) ps-rest))))))

(define (rm2deep pdep plst)
  (if (null? plst)
    '()
    (letrec ((acar (car plst))
             (slln (string-count acar #\/)))
      (if (<= slln pdep)
        (cons acar (rm2deep pdep (cdr plst)))
        (rm2deep pdep (cdr plst))))))

(define (path-powerset cfiles dirns)
  (define (join-path alst)
    (define (join-path-helper acnt hlst)
      (cond
        ((null? hlst) "")
        ((pair? hlst) (string-append/shared (car hlst) "/" (join-path-helper (+ 1 acnt) (cdr hlst))))))
    (string-append/shared "/" (join-path-helper 0 alst)))
  (letrec*
     ((aset (drop-length max-depth (powerset dirns)))
     (amap (map join-path aset))
     (apls (clean (rm2deep max-depth amap))))
    (append amap (combine-paths-helper apls cfiles))))

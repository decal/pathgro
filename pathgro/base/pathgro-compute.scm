(define-module (pathgro base pathgro-compute)
               #:export (pathgro-compute combine-paths combine-paths-helper combine-files combine-files-helper)
               #:use-module (ice-9 common-list))

;(use-modules ((pathgro base read-pathsfiles) #:select (bases dirns extns)))
(use-modules ((pathgro util clean-list) #:select (suniq flatten unblank unempty ununspec clean)))

(define (combine-paths-helper slist elist)
  (map (lambda (x)
         (map (lambda (y)
                (string-append x y))
              elist))
       slist))

(define (combine-paths maxdc slist elist)
  (if (< maxdc (+ (length slist) (length elist)))
    '()
    (combine-paths-helper slist elist)))

;(define (combine-files dlist flist)
;  (flatten (map (lambda (d)
;      (map (lambda (f)
;             (string-append d f))
;           flist))
;       dlist)))

(define (combine-files-helper dlist flist)
  (map (lambda (d)
         (map (lambda (f) 
                (string-append d "." f))
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

;(define (powerset slst)
;  (if (null? slst)
;  '(())
;  (append-map (lambda (x) (list x (cons (car slst) x))) (powerset (cdr slst)))))

(define (powerset set)
  (if (null? set) '(())
    (let ((ps-rest (powerset (cdr set))))
      (append ps-rest
        (map (lambda (ss)
          (cons (car set) ss)) ps-rest)))))

(define (rm2deep pdep plst)
  (if (null? plst)
    '()
    (letrec ((acar (car plst))
             (slln (string-count acar #\/)))
      (if (<= slln pdep)
        (cons acar (rm2deep pdep (cdr plst)))
        (rm2deep pdep (cdr plst))))))

(define (pathgro-compute adepth cfiles dirns)
  (define (join-path alst)
    (define (join-path-helper acnt hlst)
      (cond
        ((null? hlst) "")
        ((pair? hlst) (string-append (car hlst) "/" (join-path-helper (+ 1 acnt) (cdr hlst))))))
    (string-append "/" (join-path-helper 0 alst)))
  (letrec*
     ((aset (drop-length adepth (powerset dirns)))
     (amap (map join-path aset))
     (apls (clean (rm2deep adepth amap))))
    (suniq (clean (append amap (combine-paths-helper apls (clean cfiles)))))))

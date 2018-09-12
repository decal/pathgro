(define-module (pathgro base path-powerset)
               #:export (path-powerset)
               #:use-module (ice-9 common-list))

(use-modules (pathgro base combine-paths))
(use-modules (pathgro base path-strings))
(use-modules (pathgro util stdio))
(use-modules (pathgro util clean-list))

(use-modules (srfi srfi-1))

(define (powerset dep set)
  (if (null? set) '(())
    (let ((ps-rest (powerset dep (cdr set))))
      ;(if (>= (length set) dep)
        (powerset dep (cdr set)) 
        (append ps-rest
                (map (lambda (ss)
                       (cons (car set) ss)) ps-rest)))))

(define (path-powerset pdepth cfiles dirns)
  (letrec*
     ((aset (drop-upto-length pdepth (powerset pdepth dirns)))
      (amap (map join-path aset))
      (apls (clean amap))) 
    (append apls (combine-paths-helper apls cfiles))))

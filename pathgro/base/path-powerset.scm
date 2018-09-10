(define-module (pathgro base path-powerset)
               #:export (path-powerset)
               #:use-module (ice-9 common-list))

(use-modules (pathgro base combine-paths))
(use-modules (pathgro base path-strings))
(use-modules (pathgro util stdio))
(use-modules (pathgro util clean-list))
(use-modules (pathgro util splitter))

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
  (define (join-path alst)
    (define (join-path-helper acnt hlst)
      (cond
        ((null? hlst) blank)
        ((pair? hlst) (string-append/shared (car hlst) slash (join-path-helper (+ 1 acnt) (cdr hlst))))))
    (string-append/shared slash (join-path-helper 0 alst)))
  (letrec*
     ((aset (drop-upto-length pdepth (powerset pdepth dirns)))
      (amap (map join-path aset))
      (apls (clean amap))) ;rm2deep pdepth
    (clean (combine-paths-helper apls cfiles))))

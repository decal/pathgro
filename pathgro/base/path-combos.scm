(define-module (pathgro base path-combos)
               #:export (combos path-combos)
               #:use-module (ice-9 common-list))

(use-modules (pathgro base combine-paths))
(use-modules (pathgro base path-strings))
(use-modules (pathgro util stdio))
(use-modules (pathgro util clean-list))

(define (combos m lst)
  (cond ((= m 0) '(()))
        ((null? lst) '())
        (else (append (map (lambda (y) (cons (car lst) y))
                           (combos (- m 1) (cdr lst)))
                      (combos m (cdr lst))))))

(define (path-combos cdepth cfiles dirns)
  (define (join-path alst)
    (define (join-path-helper acnt hlst)
      (cond
        ((null? hlst) blank)
        ((pair? hlst) (string-append/shared (car hlst) slash (join-path-helper (+ 1 acnt) (cdr hlst))))))
    (string-append/shared slash (join-path-helper 0 alst)))
  (letrec*
     ((aset (drop-length cdepth (combos cdepth dirns)))
      (amap (map join-path aset))
      (apls (clean amap)))
    (append apls (combine-paths-helper apls cfiles))))

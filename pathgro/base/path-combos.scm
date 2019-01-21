(define-module (pathgro base path-combos)
  #:export (combos path-combos)
  #:use-module (ice-9 common-list))

(use-modules (pathgro base combine-paths) (pathgro base path-strings))
(use-modules (pathgro util permute-list) (pathgro util clean-list))

(define (combos m lst)
  (cond ((zero? m) '(()))
        ((null? lst) '())
        (else (append (map (lambda (y) (cons (car lst) y)) (combos (- m 1) (cdr lst))) 
		      (combos m (cdr lst))))))

(define (path-combos cdepth cfiles dirns)
  (letrec*
     ((aset (drop-length cdepth (permute-list (combos cdepth dirns))))
      (amap (map join-path aset))
      (apls (clean amap)))
    (append apls (combine-paths-helper apls cfiles))))

(define-module (pathgro base path-powerset)
               #:export (path-powerset))

(use-modules (pathgro base path-combos) (pathgro util permute-list))

(define (path-powerset acount pdepth cfiles dirns)
  (if (> acount pdepth)
    '()
    (append (permute-list (path-combos acount cfiles dirns)) (path-powerset (+ 1 acount) pdepth cfiles dirns))))

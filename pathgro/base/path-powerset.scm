(define-module (pathgro base path-powerset)
               #:export (path-powerset)
               #:use-module (srfi srfi-1)
               #:use-module (ice-9 common-list))

(use-modules (pathgro base path-combos))

(define (path-powerset acount pdepth cfiles dirns)
  (if (> acount pdepth)
    '()
    (append (path-combos acount cfiles dirns) (path-powerset (+ 1 acount) pdepth cfiles dirns))))

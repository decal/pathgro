(define-module (pathgro util unblank)
               #:export (unblank))

(define (unblank l)
  (delete "" l))

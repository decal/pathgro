(define-module (pathgro util pp)
               #:export (pp)
               #:use-module (ice-9 pretty-print))

(define (pp x)
  (pretty-print
    (let loop ((y x))
      (syntax-case y ()
                   ((a . b) (cons (loop #'a) (loop #'b)))
                   (x       (syntax->datum #'x)))))
  x)

(define-module (pathgro base path-generate)
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 format)
  #:export (path-generate))

(use-modules (pathgro util path-tools))

(define (path-generate apth)
  (let ((abase (basename apth))
        (anext (extname apth))
        (upper-limit 94) (lower-limit 33) (increment-value 1))
      (append
        (map (lambda (d) (format #f (string-append "/" abase "~c") (integer->char d))) (iota upper-limit lower-limit increment-value))
        (map (lambda (d) (format #f (string-append "/" abase ".~c") (integer->char d))) (iota upper-limit lower-limit increment-value))
        (map (lambda (d) (format #f (string-append "/" anext "~c") (integer->char d))) (iota upper-limit lower-limit increment-value))
        (map (lambda (d) (format #f (string-append "/" anext ".~c") (integer->char d))) (iota upper-limit lower-limit increment-value))
        (map (lambda (d) (format #f (string-append "/" abase "." anext "~c") (integer->char d))) (iota upper-limit lower-limit increment-value))
        (map (lambda (d) (format #f (string-append "/" abase "." anext ".~c") (integer->char d))) (iota upper-limit lower-limit increment-value)))))

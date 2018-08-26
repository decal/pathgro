(define-module (pathgro util splitter)
               #:export (splitter))

(define (splitter lines)
  (if (null? lines)
    '()
    (cons (string-split (car lines) #\/) (splitter (cdr lines)))))

(define-module (pathgro util splitter)
               #:export (splitter max-depth))

(define max-depth 0)

(define (splitter lines)
  (if (null? lines)
    '()
    (let ((asp (delete! "" (string-split (car lines) #\/))))
      (when (> (length asp) max-depth) (set! max-depth (length asp)))
      (cons asp (splitter (cdr lines))))))

(define-module (pathgro util flatten)
   #:export (flatten))

(define (flatten x)
  (cond ((null? x) '())
        ((not (pair? x)) (list x))
        (else (append (flatten (car x)) (flatten (cdr x))))))

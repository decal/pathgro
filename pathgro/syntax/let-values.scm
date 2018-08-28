(define-module (pathgro syntax let-values)
               #:export (let-values))

(define-syntax let-values
  (syntax-rules ()
                ((_ (bs producer) body ...)
                 (call-with-values (lambda () producer)
                                   (lambda bs body ...)))))

(define-module (pathgro util stdio)
  #:use-module (pathgro util stdstreams)
  #:export (fprintln println fnewlines newlines))

(define (fprintln astr aport)
  (display astr aport)
  (newline aport))

(define (println astr)
  (fprintln astr stdout))

(define (fnewlines acnt aport)
  (if (zero? acnt)
    #t
    (fnewlines (- acnt 1) aport)))

(define (newlines acnt)
  (if (zero? acnt)
    #t
    (fnewlines (- acnt 1) stdout)))

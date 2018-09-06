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
    (begin
      (newline aport)
      (fnewlines (- acnt 1) aport))))

(define (newlines acnt)
  (fnewlines acnt stdout))

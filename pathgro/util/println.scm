(define-module (pathgro util println)
  #:export (println))

(define (println astr)
  (define (fprintln astr aport)
    (display astr aport)
    (newline aport))
  (fprintln astr stdout))

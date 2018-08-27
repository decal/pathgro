(define-module (pathgro util println)
  #:use-module (pathgro util stdstreams)
  #:export (println))

(define (println astr)
  (define (fprintln astr aport)
    (display astr aport)
    (newline aport))
  (fprintln astr stdout))

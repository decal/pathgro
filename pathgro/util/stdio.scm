(define-module (pathgro util stdio)
  #:export (stdin stdout stderr fprintln println false? true?))

(define-values (stdin stdout stderr) (values (current-input-port) (current-output-port) (current-error-port)))

(define (fprintln astr aout)
  (display astr aout)
  (newline aout))

(define (println astr)
  (fprintln astr stdout))

(define (false? v)
  (eq? #f v))

(define (true? v)
  (eq? #t v))

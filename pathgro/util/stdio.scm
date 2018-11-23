(define-module (pathgro util stdio)
  #:export (stdin stdout stderr fprintln println false? true?))

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

(define-values (stdin stdout stderr) (values (current-input-port) (current-output-port) (current-error-port)))

(define (newlines acnt)
  (fnewlines acnt stdout))

(define-module (pathgro util stdio)
  #:export (stdin stdout stderr fprintln println fnewlines newlines empty? unblank blank? unempty false? true?)) 

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

(define (empty? l)
  (eq? '()))

(define (unblank l)
  (delete! "" l))

(define (blank? l)
  (eq? ""))

(define (unempty l)
  (delete! '() l))

(define (false? v)
  (eq? #f v))

(define (true? v)
  (eq? #t v))

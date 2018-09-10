(define-module (pathgro util stdio)
  #:export (stdin stdout stderr fprintln println fnewlines newlines ununspec 
                  empty blank slash dot 
                  blank-string slash-string dot-string period-string
                  slash-char backslash-char dot-char 
                  forward-slash-char back-slash-char period-char
                  empty? unblank blank? unempty))

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

;(define unspecified (begin))
;(define (unspecified? v) (eq? unspecified) v)

(define (ununspec l) (noop l))
  ;(delete unspecified l))

(define-values (empty blank slash dot) (values '() "" "/" "."))
(define-values (blank-string slash-string dot-string) (values blank slash dot))
(define-values (period-string) (values dot-string))
(define-values (slash-char backslash-char dot-char) (values #\/ #\\ #\.))
(define-values (forward-slash-char back-slash-char period-char) (values slash-char backslash-char dot-char))

(define (empty? l)
  (eq? empty))

(define (unblank l)
  (delete! blank l))

(define (blank? l)
  (eq? blank))

(define (unempty l)
  (delete! empty l))

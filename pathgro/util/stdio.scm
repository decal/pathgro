(define-module (pathgro util stdio)
  #:export (fprintln println stdin stdout stderr))

(define-values (stdin stdout stderr) (values (current-input-port) (current-output-port) (current-error-port)))

(define (fprintln astr aport)
  (display astr aport)
  (newline aport))

(define (println astr)
  (fprintln astr stdout))

;(define (dbgout alist)
;  (display (string (car alist)))
;  (display (cdr alist))
;  (newline))

;(dbgout (list println "abc"))


;(define (fnewlines acnt aport)
;  (if (zero? acnt)
;    #t
;    (begin
;      (newline aport)
;      (fnewlines (- acnt 1) aport))))

;(define (newlines acnt)
;  (fnewlines acnt stdout))

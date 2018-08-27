(define-module (pathgro util stdstreams)
  #:export (stdout stdin stderr))

(define-values (stdin stdout stderr) (values (current-input-port) (current-output-port) (current-error-port)))

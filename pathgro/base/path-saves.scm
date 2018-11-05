(define-module (pathgro base path-saves)
  #:use-module (srfi srfi-1)
  #:export (path-saves))

(define (path-saves apth)
  (append 
    (list 
      (string-append "#" apth)
      (string-append ".#" apth)
      (string-append apth "#")
      (string-append "." apth "#")
      (string-append "#" apth "#")
      (string-append ".#" apth "#")
      (string-append "~" apth)
      (string-append apth "~")
      (string-append "." apth "~")
      (string-append ".~" apth)
      (string-append ".~" apth "~"))
    (list (map (lambda (x) (string-append apth "~" (number->string x))) (iota 10 0 1)))))

(define-module (pathgro base path-macos)
  #:export (path-macos))

(use-modules (pathgro util path-tools))

(define (path-macos apth)
  (list 
    (string-append "_" apth) (string-append apth "_") (string-append "_" apth "_")
    (string-append "-" apth) (string-append apth "-") (string-append "-" apth "-")
    (string-append ":" apth) (string-append apth ":") (string-append ":" apth ":")
    (string-append "." apth) (string-append apth ".") (string-append "." apth ".") 
    (string-append "=" apth) (string-append apth "=") (string-append "=" apth "=")
    (string-append "+" apth) (string-append apth "+") (string-append "+" apth "+")
    (string-append "^" apth) (string-append apth "^") (string-append "^" apth "^")
    (string-append "%" apth) (string-append apth "%") (string-append "%" apth "%")
    (string-append "._" apth) (string-append apth ".-") (string-append "._." apth)))

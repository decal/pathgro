(define-module (pathgro base path-vimswap)
  #:use-module (srfi srfi-1)
  #:export (path-vimswap))

;; From GitHub's gitignore file for vim:
; [._]*.s[a-v][a-z]
; [._]*.sw[a-p]
; [._]s[a-v][a-z]
; [._]sw[a-p]

(define (path-vimswap apth)
  (map (lambda (x) (string-append "/" "." apth ".sw" (list->string (list (integer->char x))))) (iota 16 97 1)))

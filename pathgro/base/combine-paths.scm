(define-module (pathgro base combine-paths)
  #:use-module (ice-9 common-list)
  #:export (combine-paths-helper combine-paths combine-files-helper combine-files))

; essentially a cartesian product for lists of strings
(define (combine-paths-helper slist elist)
  (map (lambda (x)
         (map (lambda (y)
		(string-append x y))
              elist))
       slist))

; check the combined list lengths against the max depth before proceeding
(define (combine-paths maxdc slist elist)
  (if (<= maxdc (+ (length slist) (length elist)))
    '()
    (combine-paths-helper slist elist)))

; like combine-paths-helper but insert period between directory and filename
(define (combine-files-helper dlist flist)
  (map (lambda (d)
         (map (lambda (f)
                (string-append d "." f))
              flist))
       dlist))

;; TODO: try this with < instead of >= 
(define (combine-files maxdc dlist flist)
  (if (<= maxdc (length dlist))
    '()
    (combine-files-helper dlist flist)))

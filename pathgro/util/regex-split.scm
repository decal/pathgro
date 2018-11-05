(define-module (pathgro util regex-split)
  #:export (regex-split)
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 regex))

(define (regex-split regexp str . options)
  (let ((keep #f) (trim #f))
    (if (member 'keep options)
      (begin (set! options (delete 'keep options))
             (set! keep #t)))
    (if (member 'trim options)
      (begin (set! options (delete 'trim options))
             (set! trim #t)))
    (let* ((matches (apply list-matches regexp str options))
           (indices
             (append '(0)
               (fold-right
                 (lambda (m acc) (cons (match:start m)
                                   (cons (match:end m) acc))) '()
                 matches)
               (list (string-length str))))
           (substrings
              (pair-fold-right
                (lambda (lst accum)
                  (if (or (even? (length lst))
                          (and keep (> (length lst) 1)))
                    (cons (apply substring str (take lst 2)) accum)
                    accum))
                '()
                indices)))
      (if trim
        (reverse! (drop-while string-null?
          (reverse! (drop-while string-null? substrings))))
        substrings))))

;(display (regex-split "[^a-zA-Z0-9]" "abc!123"))
;(newline)

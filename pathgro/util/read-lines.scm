(define-module (pathgro util read-lines)
               #:export (read-lines))

(use-modules (ice-9 rdelim))

(define (read-lines file)
  (let ((ls '()))
    (with-input-from-file file
      (lambda ()
        (do ((line (read-line) (read-line)))
            ((eof-object? line))
            (set! ls (cons line ls)))
            (reverse ls)))))

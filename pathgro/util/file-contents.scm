(define-module (pathgro util file-contents)
               #:export (file-contents)
               #:use-module (ice-9 rw))

(define (file-contents file)
  (call-with-input-file file
    (lambda (p)
      (let* ((size (stat:size (stat p)))
        (buf (make-string size)))
        (read-string!/partial buf p)
        buf))))

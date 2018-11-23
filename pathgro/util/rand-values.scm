(define-module (pathgro util rand-values)
  #:use-module (srfi srfi-27)
  #:export (srand rand-values rand-truth-value rand-boolean-string rand-boolean-number))

(define-values (boolean-true boolean-false number-zero number-one char-zero char-one string-zero string-one) (values #t #f 0 1 #\0 #\1 "0" "1"))
(define-values (booleans-vector numbers-vector chars-vector strings-vector) (values #(#t #f) #(0 1) #(#\0 #\1) #("0" "1")))

(define (srand)
  (seed->random-state (random (current-time)))
  (usleep (random (random 100000)))
  (set! default-random-source (make-random-source))
  (random-source-randomize! default-random-source)
  (set! *random-state* (random-state-from-platform))
  (usleep (random (random 100000))))

(srand)

(define (rand-list-ref alist)
  (srand)
  (let ((arand (random (length alist))))
    (list-ref alist arand)))

(define rand-values rand-list-ref)

(define (rand-vector-ref avec)
  (srand)
  (let ((arand (random (vector-length avec))))
    (vector-ref avec arand)))

(define (rand-truth-value)
  (rand-vector-ref booleans-vector))

(define (rand-boolean-string)
  (rand-vector-ref strings-vector))

(define (rand-boolean-number)
  (rand-vector-ref booleans-vector))

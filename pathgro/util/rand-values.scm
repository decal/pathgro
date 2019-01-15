(define-module (pathgro util rand-values)
  #:use-module (srfi srfi-27)
  #:export (srand rand-values rand-integer-pair rand-truth-value))

(define booleans-vector #(#t #f))

;(define (srand)
;  (seed->random-state 0))

;(define (srand)
;  (seed->random-state 1))

(define (srand)
  (seed->random-state (random (current-time))))

(srand)

;(define (srand)
  ;(seed->random-state (random (current-time)))
  ;(display "SRAND")(newline)
  ;(seed->random-state 1)
  ;(usleep (random (random 100000)))
  ;(set! default-random-source (make-random-source))
  ;(random-source-randomize! default-random-source)
  ;(set! *random-state* (random-state-from-platform))
  ;(usleep (random (random 100000))))

(define (rand-list-ref alist)
  (let ((arand (random (length alist))))
    (list-ref alist arand)))

(define rand-values rand-list-ref)

(define (rand-vector-ref avec)
  (let ((arand (random (vector-length avec))))
    (vector-ref avec arand)))

(define (rand-truth-value)
  (rand-vector-ref booleans-vector))

(define (rand-integer-pair)
  (letrec* ((acombos (random 5))
          (apowers (random acombos)))
      (when (zero? apowers) (set! apowers (- acombos 1)))
      (if (zero? acombos) 
        (rand-integer-pair)
        (values acombos apowers))))

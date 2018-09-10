(define-module (pathgro base path-kperms)
                #:export (path-kperms path-kperms-helper))

(define (factorial n)    
  (if (zero? n) 
    1 
    (* n (factorial (- n 1)))))

(define (path-kperms-helper n k)  ; lists will be from 0..(n-1)
  (define pl '()) ; all permutations list;
    (let loop ((ol '())) ; one permutation list; 
      (define a (random n))  ; 0 to n-1
      (if 
        (member a ol) (loop ol)
        (begin 
          (set! ol (cons a ol))
          (if 
            (< (length ol) k) (loop ol)
            (if (member ol pl) (loop '())
              (begin 
                (set! pl (cons ol pl))
                (if (< (length pl)
                       (/ (factorial n)
                          (factorial (- n k))))
                  (loop '())
                  pl))))))))

(define (path-kperms n k)
  (define (path-kperms-iter n k x)
    (if (or (> x k) (zero? k) (> k n))
      '()
      (cons (path-kperms-helper n x) (path-kperms-iter n k (+ 1 x)))))
  (path-kperms-iter n k 1))

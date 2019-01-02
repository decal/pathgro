(define-module (pathgro base path-kperms)
                #:export (path-kperms))

(use-modules (pathgro base combine-paths))
(use-modules (pathgro base path-strings))

(define (index2path-helper dirns ainds)
  (if (or (null? ainds) (null? dirns))
    '()
    (cons (list-ref dirns (car ainds)) (index2path-helper dirns (cdr ainds)))))

(define (index2path dirns ainds)
  (if (or (null? ainds) (null? dirns))
    '()
    (cons (string-join (index2path-helper dirns (car ainds)) "/") (index2path dirns (cdr ainds)))))

(define (factorial n)    
  (if (zero? n) 
    1 
    (* n (factorial (- n 1)))))

(define (calc-kperms-helper n k)  ; lists will be from 0..(n-1)
  (define pl '()) ; all permutations list;
    (let loop ((ol '())) ; one permutation list; 
      ;(define a (random n))  ; 0 to n-1
      (define a (- n 1))
      (if (member a ol) 
	      (loop ol)
        (begin 
          (set! ol (cons a ol))
          (if (< (length ol) k) 
	          (loop ol)
	          (if (member ol pl) 
		          (loop '())
		          (begin 
		            (set! pl (cons ol pl))
		            (if (< (length pl) (/ (factorial n) (factorial (- n k))))
		              (loop '())
		              pl))))))))

(define (calc-kperms n k)
  (define (calc-kperms-iter n k x)
    (if (or (> x k) (zero? k) (> k n))
      '()
      (cons (calc-kperms-helper n x) (calc-kperms-iter n k (+ 1 x)))))
  (calc-kperms-iter n k 1))

(define (path-kperms kdepth cfiles dirns)
  (let ((aln (length dirns)))
    (let ((kps (calc-kperms (length dirns) kdepth)))
      (if (null? kps)
	  cfiles
          (let ((kpx (append-strings "/" (index2path dirns (list-ref kps (- kdepth 1))))))
	    (append kpx (combine-paths-helper kpx cfiles)))))))

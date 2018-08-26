(define-module (pathgro util perm)
               #:export (perm))

(define (empty? list)
     (eq? list '()))

(define (concate l1 l2)
   (cond ((empty? l1) l2)
         (else (concate (del-last l1) (cons (last l1) l2)))))

(define (fc l1 l2)
  (concate (del-last l1)
           (concate (cons (car (filter (lambda (x) (> x (last l1))) (reverse l2)))
                          (filter (lambda (x)(<= x (last l1))) (reverse l2)))
                    (cons (last l1)
                          (cdr (filter (lambda (x)(> x (last l1))) (reverse l2)))))))

(define (fr l1 l2)
  (cond ((empty? l2) (fr (del-last l1) (cons (last l1) l2)))
        ((empty? l1) '())
        ((> (last l1) (car l2)) (fr (del-last l1) (cons (last l1) l2)))
        (else (fc l1 l2))))

(define (perm list)
  (cond ((empty? list) '())
        (else (cons list (perm (fr list '()))))))

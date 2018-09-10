(define-module (pathgro base path-strings)
  #:use-module (ice-9 common-list)
  #:export (join-path append-strings drop-string-length drop-length drop-upto-length prepend-strings unappend-strings unprepend-strings)) 

(define (prepend-strings astr slst)
  (if (null? slst)
    '()
    (cons (string-append/shared astr (car slst)) (prepend-strings astr (cdr slst)))))

(define (unprepend-strings astr slst)
  (if (null? slst)
    '()
    (if (string=? (substring/shared (car slst) 0 (string-length astr)) astr)
      (cons (substring/shared (car slst) (string-length astr) (string-length (car slst))) (unprepend-strings astr (cdr slst)))
      (cons (car slst) (unprepend-strings (car slst) (cdr slst))))))

; FIX THESE TO BE MORE LIKE *prepend-* procs above
(define (append-strings astr slst)
  (if (null? slst)
    '() ; (reduce + 0 (map string-length acar))))) 
      (if (string=? (car slst) (substring/shared (string-reverse (string-append/shared (car slst) astr)) 0 (string-length (car slst))))
        (append-strings astr (cdr slst))
        (cons (string-append/shared (car slst) astr) (append-strings astr (cdr slst))))))

(define (unappend-strings astr slst)
  (if (null? slst)
    '()
    (if (string=? (substring/shared (car slst) (- (string-length (car slst)) (string-length astr))))
      (cons (substring/shared (car slst) 0 (- (string-length (car slst)) (string-length astr)) (unappend-strings astr (cdr slst))))
      (cons (car slst) (unappend-strings astr (cdr slst))))))

(define (drop-string-length slen slst)
  (filter (lambda (s) (<= slen (string-count s #\/))) slst))

(define (drop-length llen llst)
  (filter (lambda (l) (= llen (length l))) llst))

(define (drop-upto-length llen llst)
  (filter (lambda (l) (>= llen (length l))) llst))

(define (rm2deep pdep plst)
  (if (null? plst)
    '()
    (if (<= (string-count (car plst) #\/) pdep)
      (cons (car plist) (rm2deep pdep (cdr plst)))
      (rm2deep pdep (cdr plst)))))

(define (join-path alst)
  (define (join-path-helper acnt hlst)
    (cond
      ((null? hlst) "")
      ((pair? hlst) (string-append/shared (car hlst) "/" (join-path-helper (+ 1 acnt) (cdr hlst))))))
  (string-append/shared "/" (join-path-helper 0 alst)))

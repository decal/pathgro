(define-module (pathgro base path-traverse)
  #:export (path-traverse)
  #:use-module (ice-9 common-list)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-11))

(use-modules (pathgro base combine-paths) (pathgro base path-strings))
(use-modules (pathgro util stdio) (pathgro util clean-list))
(use-modules (pathgro base path-traverse))

(define-values (forward-slash backward-slash) (values #\/ #\\))
(define seperator forward-slash)

(define ascii-separate-zeroen #("/" "\\"))
(define ascii-separate-single #("%2F" "%5C"))
(define ascii-separate-nibble #("%%42%36%%42%36" "%%43%30%%43%30"))
(define ascii-separate-double #("%252F" "%255C" "%25C0%25AF"))

(define ucode-separate-zeroen #())
(define ucode-separate-single #("%U002F" "%U005C" "%C0%AF" "%C0%9V" "%C1%1C" "%C0%1C" "%C0%AF" "%C1%AF" "%C1%9C" "%C1%PC" "%C0%QF" "%C1%8S" "%E0%80" "%F0%80%80%AF" "%F8%80%80%80"))
(define ucode-separate-double #("%U252F" "%U255C"))
(define ucode-separate-nibble #("%2%46" "%2%66" "%5%43" "%5%63" "%%45C"))

(define ascii-traverse-zeroen #(".."))
(define ascii-traverse-single #("%2E%2E"))
(define ascii-traverse-nibble #("%%32%45%%32%65" "%%43%31%%31%43" "%%43%30%%41%46" "%%43%31%%43%31")) ;see udelimiters1
(define ascii-traverse-double #("%252E%252E"))

(define ucode-traverse-zeroen #())
(define ucode-traverse-single #("%U002E%U002E" "%E0%80%AE" "%F0%80%80%AE" "%F8%80%80%80%AE" "%FC%80%80%80%80%AE"))
(define ucode-traverse-double #("%U252E%U252E"))

(define (cdup-strings vs vt)
  (let-values ((sl (vector-length vs)) (tl (vector-length vt)))
    (let-values ((si (iota (car sl))) (ti (iota (car tl))))
      (map (lambda (y)
        (map (lambda (x) (string-append (vector-ref vt (car y)) (vector-ref vs (car x)))) si))
        ti)))) 
          
(define (rand-cdup-string vads vats)
    (let-values ((delin (random (vector-length vads))) (trlin (random (vector-length vats))))
      (string-append (vector-ref vats (car trlin)) (vector-ref vads (car delin)))))

(define cdup-string (rand-cdup-string ascii-separate-single ascii-traverse-single))

(define (rand-grow-cdup-path astr)
  (define (rand-grow-cdup-path-helper acnt xstr)
    (if (zero? acnt)
      astr
      (string-append xstr (rand-grow-cdup-path-helper (- acnt 1) xstr))))
  (rand-grow-cdup-path-helper (random 5) astr))

(define cdup-path (rand-grow-cdup-path cdup-string))

(define (path-depth apn)
  (let
    ((drl (delete-duplicates! (string-split apn seperator))))
      (length drl)))

(define (path-traverse adirs)
  (if (null? adirs)
    '()
    (cons (string-append (car adirs) cdup-path) (path-traverse (cdr adirs)))))

(define apath "/cgi-bin/test")

(display (path-depth apath))
(newline)

(display (path-traverse (list apath)))
(newline)

(display (cdup-strings ascii-separate-single ascii-traverse-single))
(newline)

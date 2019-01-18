;;
;; pathgro - combinatoric pathname wordlist expander
;;
;; v1.0 coded by Derek Callaway [derek.callaway (AT) ioactive {D0T} com]
;;

(define-module (pathgro main)
               #:use-module (ice-9 common-list)
               #:use-module (ice-9 getopt-long)
               #:use-module (srfi srfi-1)
               #:use-module (srfi srfi-11)
               #:export (main))

(use-modules (pathgro base combine-paths) (pathgro base read-pathsfiles) (pathgro base path-combos))
(use-modules  (pathgro util clean-list) (pathgro util stdio))
(use-modules (pathgro base path-slashes) (pathgro base path-strings))
(use-modules (pathgro base path-powerset) (pathgro base path-saves) (pathgro base path-traverse))
(use-modules (pathgro base path-generate) (pathgro base path-macos) (pathgro base path-vimswap))
(use-modules (pathgro util rand-values) (pathgro version) (pathgro help))

(define (main args) 
  (let* 
    ((option-spec 
      '((help       (single-char #\h))
        (basename   (single-char #\b))
        (dirname    (single-char #\d))
        (extname    (single-char #\e))
        (filename   (single-char #\f))
        (Combos     (single-char #\C) (value #t))
        (Grow       (single-char #\G) (value #t))
        (Length     (single-char #\L) (value #t))
        (Powerset   (single-char #\P) (value #t))
        (Traverse   (single-char #\T) (value #t))
        (xtdirname  (single-char #\x))
        (noslash    (single-char #\n))
        (generate   (single-char #\g))
        (macos      (single-char #\m))
        (rmtrail    (single-char #\r))
        (saves      (single-char #\s))
        (vimswap    (single-char #\v))
        (Version    (single-char #\V))))
     (options          (getopt-long args option-spec #:stop-at-first-non-option #t))
     (opt-length       0)
     (opt-help         (option-ref options 'help #f))
     (opt-Version      (option-ref options 'Version #f))
     (opt-basename     (option-ref options 'basename #f))
     (opt-dirname      (option-ref options 'dirname #f))
     (opt-extname      (option-ref options 'extname #f))
     (opt-filename     (option-ref options 'filename #f))
     (opt-generate     (option-ref options 'generate #f))
     (opt-macos        (option-ref options 'macos #f))
     (opt-saves        (option-ref options 'saves #f))
     (opt-vimswap      (option-ref options 'vimswap #f))
     (opt-Combos       (string->number (option-ref options 'Combos "0")))
     (opt-Grow         (string->number (option-ref options 'Grow "-1")))
     (opt-Length       (string->number (option-ref options 'Length "0")))
     (opt-Powerset     (string->number (option-ref options 'Powerset "0")))
     (opt-Traverse     (string->number (option-ref options 'Traverse "0")))
     (opt-xtdirname    (option-ref options 'xtdirname #f))
     (opt-noslash      (option-ref options 'noslash #f))
     (opt-rmtrail      (option-ref options 'rmtrail #f)))
    (cond
      (opt-help
        (display-help))
      (opt-Version
        (display-version))
      (else
	      (when (zero? opt-Grow) 
          (begin 
            (set! opt-basename (rand-truth-value)) 
            (set! opt-extname (rand-truth-value)) 
            (set! opt-filename (rand-truth-value)) 
            (set! opt-dirname (rand-truth-value)) 
            (set! opt-xtdirname (rand-truth-value)) 
            (set! opt-macos (rand-truth-value)) 
            (set! opt-saves (rand-truth-value)) 
            (set! opt-generate (rand-truth-value)) 
            (set! opt-vimswap (rand-truth-value))))
        (when (= 1 opt-Grow) 
          (begin 
            (set! opt-basename #t) 
            (set! opt-extname #t) 
            (set! opt-filename #t)))
        (when (= 2 opt-Grow) 
          (begin 
            (set! opt-dirname #t) 
            (set! opt-xtdirname #t)))
        (when (= 3 opt-Grow) 
          (begin 
            (set! opt-basename #t) 
            (set! opt-extname #t) 
            (set! opt-filename #t) 
            (set! opt-dirname #t) 
            (set! opt-xtdirname #t)))
        (when (= 4 opt-Grow) 
          (begin 
            (set! opt-macos #t) 
            (set! opt-saves #t)))
        (when (= 5 opt-Grow) 
          (begin 
            (set! opt-generate #t) 
            (set! opt-vimswap #t)))
        (when (= 6 opt-Grow) 
          (begin 
            (set! opt-macos #t) 
            (set! opt-saves #t) 
            (set! opt-generate #t) 
            (set! opt-vimswap #t)))
        (when (= 7 opt-Grow) 
          (begin 
            (set! opt-Combos 4) 
            (set! opt-Traverse 2)))
        (when (= 8 opt-Grow) 
          (let-values ([(xcombos xpowers) (rand-integer-pair)])
            (set! opt-Traverse xcombos)
            (set! opt-Powerset xpowers)))
        (when (= 9 opt-Grow) 
          (begin 
            (set! opt-basename #t) 
            (set! opt-extname #t) 
            (set! opt-filename #t) 
            (set! opt-dirname #t)
            (set! opt-xtdirname #t) 
            (set! opt-macos #t) 
            (set! opt-saves #t) 
            (set! opt-generate #t) 
            (set! opt-vimswap #t)
            (set! opt-Powerset 4) 
            (set! opt-Traverse 2)))
        (when opt-Length 
          (set! opt-length (- opt-Length 1)))
        (let ((stripped-args (option-ref options '() '())))
          (when (zero? (length stripped-args)) (display-help))
          (read-pathsfiles stripped-args)
          (let ((cfiles (prepend-slashes (clean (combine-files-helper bases extns))))
                (edirs (prepend-slashes (clean (combine-files-helper dirns extns)))))
                  (when opt-noslash (set! prepend-slashes unprepend-slashes))
                  (if opt-rmtrail 
                    (begin 
                      (set! dirns (unappend-slashes dirns))
		                  (set! edirs (unappend-slashes edirs)))
		                (set! unappend-slashes append-slashes))
                  (when (and opt-filename (zero? opt-Powerset)) (output-list opt-length (prepend-slashes cfiles)))
                  (when opt-basename   (output-list opt-length (prepend-slashes bases)))
    (when opt-generate   
      (output-list opt-length (prepend-slashes (flatten (map (lambda (b) (path-generate b)) bases)))))
    (when opt-macos      
      (output-list opt-length (prepend-slashes (flatten (map (lambda (b) (path-macos b)) bases)))))
    (when opt-saves      
      (output-list opt-length (prepend-slashes (flatten (map (lambda (b) (path-saves b)) bases)))))
    (when opt-vimswap    
      (output-list opt-length (prepend-slashes (flatten (map (lambda (b) (path-vimswap b)) bases)))))
    ;(when (and opt-dirname (zero? opt-Powerset)) 
    ;  (output-list opt-length (prepend-slashes dirns)))
    (when opt-dirname    
      (output-list opt-length (prepend-slashes dirns)))
    (when opt-extname    
      (output-list opt-length (prepend-slashes extns)))
    (when opt-xtdirname  
      (output-list opt-length (prepend-slashes edirs)))
    (when (not (zero? opt-Traverse))
        (output-list opt-length (path-traverse opt-Traverse "../" (prepend-slashes (flatten dirns)))))
    (when (< 0 opt-Combos) 
      (let ((cps (path-combos opt-Combos cfiles dirns)))
        (output-list opt-length (prepend-slashes (flatten cps)))))
    (when (< 0 opt-Powerset)
      (let ((aps (path-powerset 1 opt-Powerset cfiles dirns)))
        (output-list opt-length (prepend-slashes (flatten aps))))))))))
        (exit 0))

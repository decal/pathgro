;;
;; display software version banner and license disclaimer in full technicolor
;;

(define-module (pathgro version)
               #:export (display-version))

(use-modules (pathgro util ansi-color))
(use-modules (pathgro util stdio))

(define (display-version)
  (newline)
  (display (colorize-string "pathgro" 'BLACK 'ON-GREEN 'BOLD))
  (display " ")
  (display (colorize-string "v1.0" 'BLACK 'ON-YELLOW 'UNDERLINE))
  (display " ")
  (display (colorize-string "Copyright (C) 2018" 'BLACK 'ON-CYAN))
  (display " ")
  (display (colorize-string "Derek" 'BLACK 'ON-BLUE)) 
  (display " ")
  (display (colorize-string "Callaway" 'BLACK 'ON-BLUE))
  (display " ")
  (display (colorize-string "[" 'YELLOW 'BOLD))
  (display (colorize-string "derek" 'WHITE 'ON-BLUE 'REVERSE 'UNDERLINE))
  (display (colorize-string "." 'BLACK 'ON-MAGENTA 'REVERSE 'UNDERLINE)) 
  (display (colorize-string "callaway" 'WHITE 'ON-BLUE 'REVERSE 'UNDERLINE))
  (display " ")
  (display (colorize-string "(" 'BLACK 'ON-WHITE)) 
  (display (colorize-string "AT" 'WHITE 'ON-BLACK)) 
  (display (colorize-string ")" 'BLACK 'ON-WHITE))
  (display " ")
  (display (colorize-string "ioactive" 'WHITE 'ON-RED 'BOLD 'REVERSE 'UNDERLINE))
  (display " ")
  (display (colorize-string "{" 'BLACK 'ON-WHITE)) 
  (display (colorize-string "D0T" 'WHITE 'ON-BLACK))
  (display (colorize-string "}" 'BLACK 'ON-WHITE))
  (display " ")
  (display (colorize-string "com" 'WHITE 'ON-RED 'BOLD 'REVERSE 'UNDERLINE))
  (display (colorize-string "]" 'YELLOW 'BOLD))
  (newline)
  (display (colorize-string "This program comes with ABSOLUTELY NO WARRANTY. It is free software and you are welcome to redistribute it" 'RED))
  (newline)
  (display (colorize-string "under certain conditions. See the COPYING.txt file in the root directory of the source repository for details." 'RED))
  (newline)
  (display (colorize-string "https://github.com/decal/pathgro" 'BOLD 'REVERSE 'UNDERLINE))
  (newline)
  (newline)
  (exit 0))

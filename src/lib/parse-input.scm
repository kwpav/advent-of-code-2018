(define-module (aoc parse)
  #:use-module (ice-9 rdelim)
  #:use-module (srfi srfi-1)
  #:export (parse-input))

(define (parse-input)
  "Parses the input of a text file, return a list of every row of the file"
  (define (parse input)
    (let ((row (read-line)))
      (if (eof-object? row)
          input
          (parse (cons row input)))))
  (reverse! (parse '())))

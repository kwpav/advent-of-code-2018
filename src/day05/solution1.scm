#!/usr/local/bin/guile \
-e solution1 -s
!#
(use-modules (ice-9 rdelim)
             (srfi srfi-1))

(define (parse-input)
  (define (parse input)
    (let ((row (read-line)))
      (if (eof-object? row)
          input
          (parse (cons row input)))))
  (reverse! (parse '())))


(define input (car (with-input-from-file "input.txt" parse-input)))

(define my-regex "aA|Aa|bB|Bb|cC|Cc|dD|Dd|eE|Ee|fF|Ff|gG|Gg|hH|Hh|iI|Ii|jJ|Jj|kK|Kk|lL|Ll|mM|Mm|nN|Nn|oO|Oo|pP|Pp|qQ|Qq|rR|Rr|sS|Ss|tT|Tt|uU|Uu|vV|Vv|wW|Ww|xX|Xx|yY|Yy|zZ|Zz")

(define (polymers-remaining polymers)
  (if (string-match my-regex polymers)
      (polymers-remaining (regexp-substitute/global #f my-regex polymers 'pre "" 'post))
      (string-length polymers)))

(define (solution1 args)
  (display (polymers-remaining input)))

#!/usr/local/bin/guile \
-e solution1 -s
!#
(use-modules (ice-9 rdelim)
             (srfi srfi-1))

(define (parse-input)
  (define (parse input)
    (let ((row (read-line)))
      (if (eof-object? row)
          input
          (parse (cons row input)))))
  (reverse! (parse '())))

(define input (car (with-input-from-file "input.txt" parse-input)))

(define (smallest-reaction polymers)
  (define my-regex "aA|Aa|bB|Bb|cC|Cc|dD|Dd|eE|Ee|fF|Ff|gG|Gg|hH|Hh|iI|Ii|jJ|Jj|kK|Kk|lL|Ll|mM|Mm|nN|Nn|oO|Oo|pP|Pp|qQ|Qq|rR|Rr|sS|Ss|tT|Tt|uU|Uu|vV|Vv|wW|Ww|xX|Xx|yY|Yy|zZ|Zz")

  (define units (string->list "abcdefghijklmnopqrstuvwxyz"))

  (define (polymers-remaining polymers)
    (if (string-match my-regex polymers)
        (polymers-remaining (regexp-substitute/global #f my-regex polymers 'pre "" 'post))
        (string-length polymers)))

  (define (remove-unit unit polymers)
    (list->string (filter! (lambda (x) (not (char-ci=? x unit))) (string->list polymers))))

  (apply min (map! polymers-remaining (map! (lambda (unit) (remove-unit unit polymers)) units))))

(define (solution2 args)
  (display (smallest-reaction input)))

#!/usr/local/bin/guile \
-e solution1 -s
!#
(use-modules (aoc parse)
             (ice-9 rdelim)
             (srfi srfi-1))

(define input (car (with-input-from-file "input.txt" parse-input)))

(define (polymers-remaining polymers)
  (let ((re "aA|Aa|bB|Bb|cC|Cc|dD|Dd|eE|Ee|fF|Ff|gG|Gg|hH|Hh|iI|Ii|jJ|Jj|kK|Kk|lL|Ll|mM|Mm|nN|Nn|oO|Oo|pP|Pp|qQ|Qq|rR|Rr|sS|Ss|tT|Tt|uU|Uu|vV|Vv|wW|Ww|xX|Xx|yY|Yy|zZ|Zz"))
    (do ((polymers polymers (regexp-substitute/global #f re polymers 'pre "" 'post)))
        ((not (string-match my-regex polymers))
         (string-length polymers)))))

(define (solution1 args)
  (display (polymers-remaining input)))

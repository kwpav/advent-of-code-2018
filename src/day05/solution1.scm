#!/usr/local/bin/guile \
-e solution1 -s
!#
(use-modules (aoc parse)
             (ice-9 regex)
             (srfi srfi-1))

(define input (car (with-input-from-file "testinput.txt" parse-input)))

(define (polymers-remaining polymers)
  "Return the number of polymers remaining after reacting,
e.g. remove all matching 'Aa/aA', and return the length after all have been removed"
  (let ((re "aA|Aa|bB|Bb|cC|Cc|dD|Dd|eE|Ee|fF|Ff|gG|Gg|hH|Hh|iI|Ii|jJ|Jj|kK|Kk|lL|Ll|mM|Mm|nN|Nn|oO|Oo|pP|Pp|qQ|Qq|rR|Rr|sS|Ss|tT|Tt|uU|Uu|vV|Vv|wW|Ww|xX|Xx|yY|Yy|zZ|Zz"))
    (do ((reacted polymers (regexp-substitute/global #f re reacted 'pre "" 'post)))
        ((not (string-match re reacted))
         (string-length reacted)))))

(define (solution1 args)
  (display (polymers-remaining input)))

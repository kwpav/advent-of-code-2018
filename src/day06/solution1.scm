(use-modules (aoc parse)
             (srfi srfi-1))

(define input (with-input-from-file "testinput.txt" parse-input))

(define (largest-area coordinates)
  (define max-x (apply max (map get-x coordinates)))
  (define max-y (apply max (map get-y coordinates)))
  (make-point max-x max-y))

(define (solution1)
  (largest-area input))

(define (distance p1 p2)
  (+ (abs (- (get-x p1) (get-x p2)))
     (abs (- (get-y p1 (get-y p2))))))
(define (make-point x y) (list x y))
(define get-x car)
(define get-y cadr)

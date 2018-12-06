(use-modules (aoc parse)
             (ice-9 rdelim)
             (srfi srfi-1)
             (srfi srfi-13))

(define input (map (lambda (x) (string-split x #\space)) (with-input-from-file "testinput.txt" parse-input)))

(define (parse-log l)
  (define (guards-hash str size) (remainder (string-hash-ci str) size))
  (define (guards-assoc str alist)
    (find (lambda (pair) (string-ci=? str (car pair))) alist))
  (define guards-table (make-hash-table))
  (define (guards-set! id val)
    (hashx-set! guards-hash guards-assoc guards-table id val))
  (define (guards-ref id)
    (hashx-ref guards-hash guards-assoc guards-table id))

  (define (generate-log guard-id guards log)
    (cond ((null? log) guards)
          ((member "Guard" (car log)) (generate-log (cadddr (car log))
                                                    (cons (list (cadddr (car log))) guards)
                                                    (cdr log)))
          (else (generate-log guard-id
                              (if (= 1 (length (car guards)))
                                  (cons (list 1) (car guards))
                                  (cons 2 (cadr guards)))
                              (cdr log)))))
  (generate-log #f '() l))

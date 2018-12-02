(use-modules (ice-9 rdelim))

(define (parse-input)
  (define (parse input)
    (let ((row (read-line)))
      (if (eof-object? row)
          input
          (parse (cons row input)))))
  (parse '()))

(define input (with-input-from-file "input.txt" parse-input))

(define (checksum box-ids)
  (define (calculate-checksum twos-total threes-total box-ids)
    (if (null? box-ids)
        (* twos-total threes-total)
        (let ((box-id (car box-ids)))
          (calculate-checksum (+ (contains-two? box-id) twos-total)
                              (+ (contains-three? box-id) threes-total)
                              (cdr box-ids)))))

  (define (contains-two? box-id)
    (contains-num? box-id 2))

  (define (contains-three? box-id)
    (contains-num? box-id 3))

  (define (contains-num? box-id num)
    (define (iter letters)
      (cond ((null? letters) 0)
            ((= num (length (sames (car letters) (string->list box-id)))) 1)
            (else (iter (cdr letters)))))
    (iter (string->list box-id)))

  (define (sames chr lst)
    (filter (lambda (x) (eq? chr x)) lst))

  (calculate-checksum 0 0 box-ids))

(define (solution1)
  (checksum input))

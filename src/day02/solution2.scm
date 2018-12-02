(use-modules (ice-9 rdelim)
             (srfi srfi-1))

(define (parse-input)
  (define (parse input)
    (let ((row (read-line)))
      (if (eof-object? row)
          input
          (parse (cons row input)))))
  (reverse (parse '())))

(define input (with-input-from-file "input.txt" parse-input))

(define (find-prototype-fabric box-ids)
  (define (find-box-ids times other-box-ids)
    (if (null? other-box-ids)
        #f
        (let ((answer? (go-through-letters (car other-box-ids) 0 times)))
          (if answer?
              answer?
              (find-box-ids (+ 1 times)
                            (cdr other-box-ids))))))

  (define (go-through-letters box-id times current-location)
    (let ((id (list->string (remove-nth times (string->list box-id))))
          (ids (remove-nth current-location (remove-letters times box-ids))))
      (cond ((= times (string-length id)) #f)
            ((member id ids) id)
            (else (go-through-letters box-id
                                      (+ 1 times)
                                      current-location)))))

  (define (remove-letters nth box-ids)
    (map (lambda (x) (list->string (remove-nth nth (string->list x))))
         box-ids))

  (find-box-ids 0 box-ids))

(define (solution2)
  (find-prototype-fabric input))

(define (remove-nth nth lst)
  (define (inner nth lst)
    (cond ((null? lst) '())
          ((<= nth 0) (cdr lst))
          (else (cons (car lst)
                      (inner (- nth 1) (cdr lst))))))
  (inner nth lst))

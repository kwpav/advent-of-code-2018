(use-modules (ice-9 rdelim))

(define input-file "input.txt")

(define (calibrate)

  (define (first-duplicate frequency)
    (let ((change (read-line)))
      (if (eof-object? change)
          (with-input-from-file input-file (lambda () (first-duplicate frequency)))
          (if (list? frequency)
              (let ((new-frequency (calculate-frequency (car frequency) change)))
                (if (memq new-frequency frequency)
                    new-frequency
                    (first-duplicate (cons new-frequency frequency))))
              (first-duplicate (list (calculate-frequency frequency change) frequency))))))

  (define (calculate-frequency frequency change)
    (eval (list (get-operator change)
                frequency
                (get-number change))
          (interaction-environment)))

  (define (get-operator change)
    (string->symbol (substring change 0 1)))

  (define (get-number change)
    (string->number (substring change 1)))

  (first-duplicate 0))

(define (solution2)
  (with-input-from-file input-file calibrate))

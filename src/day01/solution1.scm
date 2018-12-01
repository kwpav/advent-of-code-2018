(use-modules (ice-9 rdelim))

(define (calibrate)

  (define (calculate-frequency frequency)
    (let ((change (read-line)))
      (if (eof-object? change)
          frequency
          (calculate-frequency (eval (list (get-operator change)
                                           frequency
                                           (get-number change))
                                     (interaction-environment))))))

  (define (get-operator change)
    (string->symbol (substring change 0 1)))

  (define (get-number change)
    (string->number (substring change 1)))

  (calculate-frequency 0))

(define (solution1)
  (with-input-from-file "input.txt" calibrate))

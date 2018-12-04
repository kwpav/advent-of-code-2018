(use-modules (ice-9 rdelim)
             (srfi srfi-1))

(define (parse-input)
  (define (parse input)
    (let ((row (read-line)))
      (if (eof-object? row)
          input
          (parse (cons row input)))))
  (reverse (parse '())))

(define input (with-input-from-file "testinput.txt" parse-input))

(define (overlap claims)
  (define (parse-claims claims)
    (if (null? claims)
        '()
        (cons (parse-claim (car claims))
              (parse-claims (cdr claims)))))

  (define (parse-claim claim)
    (let* ((claim-split (string-split claim #\space))
           (id (string->number (substring (car claim-split) 1)))
           (start (string-split (caddr claim-split) #\,))
           (size (map string->number (string-split (cadddr claim-split) #\x))))
      (list id
            (list (string->number (car start))
                  (string->number (substring (cadr start) 0 (1- (string-length (cadr start))))))
            size)))

  (define (generate-points claim)
    (let ((rect (make-rectangle (claim-start claim)
                                (make-point (+ (get-x (claim-start claim))
                                               (get-x (claim-size claim)))
                                            (+ (get-y (claim-start claim))
                                               (get-y (claim-size claim)))))))
      (define (generate points)
        (cond ((null? points)
               (generate (cons (get-top-left rect) points)))
              ((< (get-x (car points))
                  (1- (get-x (get-bottom-right rect))))
               (generate (cons (make-point (1+ (get-x (car points))) (get-y (car points)))
                               points)))
              ((< (get-y (car points))
                  (1- (get-y (get-bottom-right rect))))
               (generate (cons (make-point (get-x (get-top-left rect))
                                           (1+ (get-y (car points))))
                               points)))
              (else points)))
      (generate '())))

  (define (generate-blanket claims)
    (if (null? claims)
        '()
        (cons (generate-points (car claims))
              (generate-blanket (cdr claims)))))

  (define (calculate-overlap blanket)
    (- (length blanket) (length (dedupe blanket))))

  (calculate-overlap (apply append (generate-blanket (parse-claims claims)))))

(define (solution1)
  (overlap input))

(define (dedupe e)
  (if (null? e) '()
      (cons (car e) (dedupe (filter (lambda (x) (not (equal? x (car e)))) 
                                    (cdr e))))))

(define (flatten x)
    (cond ((null? x) '())
          ((pair? x) (append (flatten (car x)) (flatten (cdr x))))
          (else (list x))))


(define (make-point x y) (list x y))
(define get-x car)
(define get-y cadr)

(define x 1)
(define y 2)

(define (make-rectangle top-left bottom-right)
  (list top-left bottom-right))

(define get-top-left car)
(define get-bottom-right cadr)

(define claim-id car)
(define claim-start cadr)
(define claim-size caddr)

(define (generate-rectangle-points start size)
  (define (inner point size points)
    (cond ((> (get-x size) 0)
           (inner (make-point (1+ (get-x point))
                              (get-y point))
                  (make-point (1- (get-x size))
                              (get-y size))
                  (cons point points)))
          ((> (get-y size) 0)
           (inner (make-point (get-x point)
                              (1+ (get-y point)))
                  (make-point (get-x size)
                              (1- (get-y size)))
                  (cons point points)))
          (else points)))
  (inner start size '()))

;; #1 @ 1,3: 4x4
;; #2 @ 3,1: 4x4
;; #3 @ 5,5: 2x2

;; example data
(define sample
  '((1
     ;; row 1
     (1 3) (2 3) (3 3) (4 3)
     ;; row2
     (1 4) (2 4) (3 4) (4 4)
     ;; row3
     (1 5) (2 5) (3 5) (4 5)
     ;; row 4
     (1 6) (2 6) (3 6) (4 6))
    (2 (x y)
       (x y)
       (x y))))

(define rectangle1 (make-rectangle (make-point 0 10)
                                   (make-point 10 0)))

(define rectangle2 (make-rectangle (make-point 5 5)
                                   (make-point 15 0)))

(define (overlap? r1 r2)
  (cond ((or (> (get-x (get-top-left r1))
                (get-x (get-bottom-right r2)))
             (> (get-x (get-top-left r2))
                (get-x (get-bottom-right r1))))
         #f)
        ((or (< (get-y (get-top-left r1))
                (get-y (get-bottom-right r2)))
             (< (get-y (get-top-left r2))
                (get-y (get-bottom-right r1))))
         #f)
        (else #t)))

(define (add-to-blanket rect blanket)
  (cons (get-top-left rect) (cons (get-bottom-right rect) blanket)))

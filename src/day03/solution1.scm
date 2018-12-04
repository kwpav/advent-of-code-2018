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

(define input (with-input-from-file "testinput.txt" parse-input))

(define (overlap claims)

  (define claim-id car)
  (define claim-start cadr)
  (define claim-size caddr)
 
  (define (parse-claims claims)
    (map! parse-claim claims))
 
  (define (parse-claim claim)
    (let* ((claim-split (string-split claim #\space))
           (id (string->number (substring (car claim-split) 1)))
           (start (string-split (caddr claim-split) #\,))
           (size (map! string->number (string-split (cadddr claim-split) #\x))))
      (list id
            (list (string->number (car start))
                  (string->number (substring (cadr start) 0 (1- (string-length (cadr start))))))
            size)))

  (define (claim->rectangle claim)
    (make-rectangle (claim-start claim)
                    (make-point (+ (get-x (claim-start claim))
                                   (get-x (claim-size claim)))
                                (+ (get-y (claim-start claim))
                                   (get-y (claim-size claim))))))

  (define (generate-points rect)
    (let ((max-y (1- (get-y (get-bottom-right rect))))
          (max-x (1- (get-x (get-bottom-right rect)))))
      (let loop ((points (list (get-top-left rect))))
        (cond ((< (get-x (car points)) max-x)
               (loop (cons (make-point (1+ (get-x (car points)))
                                       (get-y (car points)))
                           points)))
              ((< (get-y (car points)) max-y)
               (loop (cons (make-point (get-x (get-top-left rect))
                                       (1+ (get-y (car points))))
                           points)))
              (else points)))))
      
  (define (generate-blanket claims)
    (append-map! generate-points (map! claim->rectangle claims)))

  (define (calculate-overlap blanket)
    (- (length blanket) (length (delete-duplicates! blanket))))

  (calculate-overlap (generate-blanket (parse-claims claims))))

(define (solution1 args)
  (display (overlap input)))

(define (make-point x y) (list x y))
(define get-x car)
(define get-y cadr)

(define (make-rectangle top-left bottom-right)
  (list top-left bottom-right))
(define get-top-left car)
(define get-bottom-right cadr)

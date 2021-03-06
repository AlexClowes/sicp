(define (enumerate-interval low high)
  (if (> low high)
    '()
    (cons low (enumerate-interval (+ low 1) high))))

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define empty-board '())

(define (adjoin-position new-row rest-of-queens)
  (cons new-row rest-of-queens))

(define (safe? positions)
  (let ((new-row (car positions)))
    (define (iter i rest-of-queens)
      (cond ((null? rest-of-queens) #t)
            ((let ((dist (abs (- (car rest-of-queens) new-row))))
               (or (= dist 0) (= dist i)))
             #f)
            (else (iter (+ i 1) (cdr rest-of-queens)))))
    (iter 1 (cdr positions))))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
      (list empty-board)
      (filter (lambda (positions) (safe? positions))
              (flatmap (lambda (rest-of-queens)
                         (map (lambda (new-row)
                                (adjoin-position new-row rest-of-queens))
                              (enumerate-interval 1 board-size)))
                       (queen-cols (- k 1))))))
  (queen-cols board-size))

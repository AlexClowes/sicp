(define (make-point x y) (cons x y))

(define (x-point p) (car p))

(define (y-point p) (cdr p))

(define (average-points p1 p2)
  (define (average a b) (/ (+ a b) 2))
  (make-point (average (x-point p1) (x-point p2))
              (average (y-point p1) (y-point p2))))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define (make-segment p1 p2) (cons p1 p2))

(define (start-segment p) (car p))

(define (end-segment p) (cdr p))

(define (midpoint-segment s)
  (average-points (start-segment s) (end-segment s)))

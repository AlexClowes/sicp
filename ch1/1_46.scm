(define (iterative-improve good-enough? improve)
  (define (try guess)
    (if (good-enough? guess)
      guess
      (try (improve guess))))
  try)

(define tolerance 0.00001)

(define (close-enough? x y)
  (< (abs (- x y)) tolerance))

(define (sqrt x)
  ((iterative-improve (lambda (y) (close-enough? (* y y) x))
                      (lambda (y) (/ (+ y (/ x y)) 2)))
   1.0))

(define (fixed-point f first-guess)
  ((iterative-improve (lambda (x) (close-enough? x (f x)))
                      f)
   first-guess))

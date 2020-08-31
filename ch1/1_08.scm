(define (good-enough? guess x)
  (<= (abs (- guess (improve guess x))) (* 0.001 guess)))

(define (improve guess x)
  (/ (+ (* 2 guess)
        (/ x (square guess)))
     3))

(define (cube-root-iter guess x)
  (if (good-enough? guess x)
    guess
    (cube-root-iter (improve guess x) x)))

(define (cube-root x)
  (cube-root-iter 1.0 x))

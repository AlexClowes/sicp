; For small numbers, the tolerance of 0.001 is too large, and the results will
; be inaccurate.
; For large numbers, the tolerance may be smaller than floating point precision,
; so the termination condition will never be reached and the procedure will run
; forever.

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? guess x)
  (<= (abs (- guess (improve guess x))) (* 0.001 guess )))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
    guess
    (sqrt-iter (improve guess x) x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

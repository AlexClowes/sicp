; x = 1 + 1 / x => x^2 = x + 1
; This is a quadratic equation with roots (1 +- sqrt(5)) / 2, so the golden
; ratio is one of two fixed points of the map 1 -> 1 + 1 / x.

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
        next
        (try next))))
  (try first-guess))

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.)
(/ (+ 1 (sqrt 5)) 2)

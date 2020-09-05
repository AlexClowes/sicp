(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (newline)
      (display next)
      (if (close-enough? guess next)
        next
        (try next))))
  (try first-guess))

(define (f x)
  (/ (log 1000) (log x)))

(fixed-point f 5)
(fixed-point (lambda (x) (/ (+ x (f x)) 2)) 5)

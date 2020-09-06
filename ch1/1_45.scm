(define (repeated f n)
  (if (= n 1)
    f
    (lambda (x) ((repeated f (- n 1)) (f x)))))

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

(define (average x y)
  (/ (+ x y) 2))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (log2 x)
  (/ (log x) (log 2)))

(define (nth-root x n)
  (let ((n-damps (floor (log2 n)))
        (func (lambda (y) (/ x (expt y (- n 1))))))
    (fixed-point ((repeated average-damp n-damps) func) 1.0)))

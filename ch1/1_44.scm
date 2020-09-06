(define (repeated f n)
  (if (= n 1)
    f
    (lambda (x) ((repeated f (- n 1)) (f x)))))

(define dx 0.00001)

(define (smooth f)
  (lambda (x) (/ (+ (f (- x dx))
                    (f x)
                    (f (+ x dx)))
                 3)))

(define (n-fold-smooth f n)
  ((repeated smooth n) f))

(define (double f)
  (lambda (x) (f (f x))))

(define (inc n) (+ n 1))

(((double (double double)) inc) 5); 5 + 2^2^2 = 5 + 16 = 21

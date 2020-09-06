(define (repeated f n)
  (if (= n 1)
    f
    (lambda (x) ((repeated f (- n 1)) (f x)))))

((repeated square 2) 5)

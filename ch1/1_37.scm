(define (cont-frac-recursive n d k)
  (define (recurse i)
    (if (> i k)
      0
      (/ (n i) (+ (d i) (recurse (+ i 1))))))
  (recurse 1))

(define (cont-frac-iterative n d k)
  (define (iter i result)
    (if (= i 0)
      result
      (iter (- i 1)
            (/ (n i) (+ (d i) result)))))
  (iter k 0.))

(cont-frac-iterative (lambda (i) 1) (lambda (i) 1) 10)
(/ 2 (+ 1 (sqrt 5)))

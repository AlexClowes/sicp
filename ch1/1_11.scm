(define (f-recursive n)
  (if (< n 3)
    n
    (+ (f-recursive (- n 1))
       (* 2 (f-recursive (- n 2)))
       (* 3 (f-recursive (- n 3))))))

(define (f-iterative n)
  (define (iter count a b c)
    (if (= count 0)
      a
      (iter (- count 1)
            (+ a (* 2 b) (* 3 c))
            a
            b)))
  (if (< n 3)
    n
    (iter (- n 2) 2 1 0)))

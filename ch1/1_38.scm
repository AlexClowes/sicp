(define (cont-frac n d k)
  (define (iter i result)
    (if (= i 0)
      result
      (iter (- i 1)
            (/ (n i) (+ (d i) result)))))
  (iter k 0.))

(+ 2
   (cont-frac (lambda (i) 1)
              (lambda (i) (if (= (remainder i 3) 2)
                            (* (/ 2 3) (+ i 1))
                            1))
              100))

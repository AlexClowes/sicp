(define (split op1 op2)
  (define (f painter n)
    (if (= n 0)
      painter
      (let ((smaller (f painter (- n 1))))
        (op1 painter (op2 smaller smaller)))))
  f)

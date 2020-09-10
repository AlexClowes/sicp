(define (fringe tree)
  (define (iter tree result)
    (cond ((null? tree) result)
          ((not (pair? tree)) (cons tree result))
          (else (iter (car tree)
                      (iter (cdr tree) result)))))
  (iter tree '()))

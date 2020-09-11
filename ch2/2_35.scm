(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define (count-leaves t)
  (accumulate +
              0
              (map (lambda (sub-tree)
                     (cond ((null? sub-tree) 0)
                           ((not (pair? sub-tree)) 1)
                           (else (count-leaves sub-tree))))
                   t)))

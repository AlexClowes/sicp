(define (has-cycle x)
  (define (iter p1 p2)
    (cond ((eq? p1 p2) true)
          ((and (pair? p1) (pair? p2) (pair? (cdr p2)))
           (iter (cdr p1) (cddr p2)))
          (else false)))
  (if (null? x)
    false
    (iter x (cdr x))))

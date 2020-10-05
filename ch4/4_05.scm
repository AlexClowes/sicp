(define (make-combination procedure arguments)
  (cons procedure arguments))

(define (cond? exp) (tagged-list? exp 'cond))
(define (cond-clauses exp) (cdr exp))
(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))
(define (cond-arrow-clause? clause)
  (eq? (cadr clause) '=>))
(define (cond-predicate clause) (car clause))
(define (cond-actions clause) (cdr clause))
(define (cond-arrow-procedure clause) (caddr clause))
(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))
(define (expand-clauses clauses)
  (if (null? clauses)
    'false
    (let ((first (car clauses))
          (rest (cdr clauses)))
      (cond ((cond-else-clause? first)
             (if (null? rest)
               (sequence->exp (cond-actions first))
               (error "ELSE clause isn't last -- COND->IF" clause)))
            ((cond-arrow-clause? first)
             (make-combination
               (make-lambda (list 'test)
                            (list (make-if 'test
                                           (make-combination (cond-arrow-procedure first)
                                                             'test)
                                           (expand-clauses rest))))
               (cond-predicate first)))
            (else
              (make-if (cond-predicate first)
                       (sequence->exp (cond-actions first))
                       (expand-clauses rest)))))))
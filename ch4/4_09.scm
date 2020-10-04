; This converts an expression (while predicate body) to
;(begin (define (while-iter)
;         (if (predicate)
;           (begin (body)
;                  (while-iter))))
;       (while-iter))

(define (while? exp) (tagged-list? exp 'while))
(define (while-predicate exp) (cadr exp))
(define (while-body exp) (caddr exp))
(define (while->combination exp)
  (sequence->exp
    (list
      (list 'define
            (list 'while-iter)
            (make-if (list (while-predicate exp))
                     (sequence->exp (list (list (while-body exp))
                                          (list 'while-iter)))
                     'done))
      (list 'while-iter))))

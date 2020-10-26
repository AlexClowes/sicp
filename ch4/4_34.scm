; Now we need to add a lazy-cons tag to the result of the lazy cons procedure.
(define (cons x y)
  (list 'lazy-cons
        (lambda (m) (m x y))))

(define (car z)
  ((lazy-cons-operands z) (lambda (p q) p)))

(define (cdr z)
  ((lazy-cons-operands z) (lambda (p q) q)))

(define (lazy-cons? exp)
  (tagged-list? exp 'lazy-cons))

(define (lazy-cons-operands exp)
  (cadr exp))

(define (user-print object)
  (cond ((compound-procedure? object)
         (display (list 'compound-procedure
                        (procedure-parameters object)
                        (procedure-body object)
                        '<procedure-env>)))
        ((lazy-cons? object) (print-lazy-cons object))
        (else (display object))))

; For lazy lists, we stop printing after 20 items, in case the list is infinite
(define print-limit 20)

(define (print-lazy-list exp)
  (define (iter exp count)
    (if (null? exp)
      (display ")")
      (if (< count print-limit)
        (begin (display (car exp))
               (display " ")
               (iter (cdr exp) (+ count 1)))
        (display "...)"))))
  (display "(")
  (iter exp 0))

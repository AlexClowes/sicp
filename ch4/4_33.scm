; Add cons, car, cdr to environment at setup time, and do not include them as
; primitive procedures.
(define (setup-environment)
  (let ((initial-env
          (extend-environment (primitive-procedure-names)
                              (primitive-procedure-objects)
                              the-empty-environment)))
    (define-variable! 'true true initial-env)
    (define-variable! 'false false initial-env)
    (eval '(define (cons x y) (lambda (m) (m x y))) initial-env)
    (eval '(define (car z) (z (lambda (p q) p))) initial-env)
    (eval '(define (cdr z) (z (lambda (p q) q))) initial-env)
    initial-env))

; Now we can redefine text-of-quotation
(define (text-of-quotation exp env)
  (let ((operand (cadr exp)))
    (if (pair? operand)
      (eval (make-lazy-list operand) env)
      operand)))

(define (make-lazy-list exp)
  (if (null? exp)
    '()
    (list 'cons (make-lazy-list (car exp)) (make-lazy-list (cdr exp)))))

; eval should now pass exp and env to text-of-quotation in the cond block.

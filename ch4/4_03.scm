(define (operator exp) (car exp))

(define (install-syntax-package)
  (put 'eval 'quote
       (lambda (exp env) (text-of-quotation exp)))
  (put 'eval 'set! eval-assignment)
  (put 'eval 'define eval-definition)
  (put 'eval 'if eval-if)
  (put 'eval 'lambda
       (lambda (exp env)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env)))
  (put 'eval 'begin
       (lambda (exp env)
         (eval-sequence (begin-actions exp) env)))
  (put 'eval 'cond
       (lambda (exp env)
         (eval-if (cond->if exp) env)))
  'ok)

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((get 'eval (operator exp)) => (lambda (op) (op exp env)))
        ((application? exp) (apply (eval (operator exp) env)
                                   (list-of-values (operands exp) env)))
        (else (error "Unknown expression type -- EVAL" exp))))

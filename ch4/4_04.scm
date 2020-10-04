; Syntax logic is the same for both approaches
(define (and? exp)
  (tagged-list?  exp 'and))
(define (and-predicates exp) (cdr exp))
(define (or? exp)
  (tagged-list? exp 'or))
(define (or-predicates exp) (cdr exp))
(define (first-predicate exps) (car exps))
(define (rest-predicates exps) (cdr exps))
(define (no-predicates exps) (null? exps))

; Implementing and, or by defining new evaluation procedures
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((and? exp) (eval-and (and-predicates exp) env))
        ((or? exp) (eval-or (or-predicates exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL" exp))))

(define (eval-and exps env)
  (cond ((no-predicates? exps) 'true)
        ((true? (eval (first-predicate exps) env))
         (eval-and (rest-predicates exps) env))
        (else 'false)))

(define (eval-or exps env)
  (cond ((no-predicates exps) 'false)
        ((true? (eval (first-predicate exps) env)) 'true)
        (else
          (eval-or (rest-predicates exps) env))))

; Implementing and, or as derived expressions
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((and? exp) (eval (and->if exp) env))
        ((or? exp) (eval (or->if exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL" exp))))

(define (and->if exp)
  (expand-and-predicates (and-predicates exp)))
(define (expand-and-predicates exps)
  (if (no-predicates? exps)
    'true
    (make-if (first-predicate exps)
             (expand-and-predicates (rest-predicates exps))
             'false)))

(define (or->if exp)
  (expand-or-predicates (or-predicates exp)))
(define (expand-or-predicates exps)
  (if (no-predicates? exps)
    'false
    (make-if (first-predicate exps)
             'true
             (expand-or-predicates (rest-predicates exps)))))

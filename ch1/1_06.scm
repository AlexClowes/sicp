; The if special form only causes the predicate and one other argument to be
; evaluated, but the new-if function evaluates all arguments.
; So in this case, the interpreter gets stuck in an infinite loop while trying
; to evaluate the sqrt-iter call in the else-clause argument.

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

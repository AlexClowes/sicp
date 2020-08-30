; With applicative-order evaluation, (p) is evaluated as (p), and the
; interpreter is trapped in an infinite recursion.
; With normal-order evaluation, the predicate expression evaluates to #t, so the
; expression (p) is never evaluated, and test returns a value of 0.

(define (p) (p))

(define (test x y)
  (if (= x 0)
    0
    y))

(test 0 (p))

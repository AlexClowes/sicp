(define (subsets s)
  (if (null? s)
    (list '())
    (let ((rest (subsets (cdr s))))
      (append rest
              (map (lambda (r) (cons (car s) r)) rest)))))

; Let X be a set, and P(X) be the powerset of X.
; If X is the empty set, then P(X) = {{}}, which corresponds to (()) in lisp.
; Otherwise, choose an element x from X. Then P(X) is the union of all the
; subsets of X not containing x (i.e. P(X\{x})) and all the subsets of X which
; do contain x (i.e. Y U {x} for all Y in P(X\{x})). this gives a recursive
; implementation of P(X), which is implemented by the procedure above.

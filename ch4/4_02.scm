; Louis's plan will cause assignment statements to be evaluated as procedure
; applications - i.e. they won't work anymore.
; For example, trying to evaluate (define x 3) cause the interpreter to try to
; evaluate x, instead of assigning to it.

(define (application? exp) (tagged-list? exp 'call))
(define (operator exp) (cadr exp))
(define (operands expr) (cddr exp))

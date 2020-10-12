; Ben is correct, unless could be implemented as a derived expression.

; Add this to cond expression inside eval
((unless? exp) (eval (unless->if exp) env))

; Syntax
(define (unless? exp)
  (tagged-list? exp 'unless))
(define (unless-condition) (cadr exp))
(define (unless-usual-value) (caddr exp))
(define (unless-exceptional-value) (cadddr exp))
(define (unless->if exp)
  (make-if (unless-condition exp)
           (unless-exceptional-value exp)
           (unless-usual-value exp)))

; I can't imagine why anyone would need unless, since it is exactly equivalent
; to if, except with the order of two arguments interchanged.

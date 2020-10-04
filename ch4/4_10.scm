; We could put functions at the end of combinations instead. This only requires
; changes to the syntax procedures, and not to the eval or apply.
(define (last-element items)
  (if (null? (cdr items))
    (car items)
    (last-element (cdr items))))

(define (tagged-list? exp tag)
  (and (pair? exp)
       (eq? (last-element exp) tag)))

(define (text-of-quotation exp) (car exp))

(define (assignment-variable exp) (car exp))
(define (assignment-value exp) (cadr exp))

(define (definition-variable exp)
  (if (symbol? (car exp))
    (car exp)
    (caar exp)))
(define (definition-value exp)
  (if (symbol? (car exp))
    (cadr exp)
    (make-lambda (cdar exp)
                 (cdr exp))))

; And so on...

(define (letrec? exp) (tagged-list? exp 'letrec))
(define (letrec-bindings exp) (cadr exp))
(define (letrec-body exp) (cddr exp))
(define (binding-variable binding) (car binding))
(define (binding-value binding) (cadr binding))

(define (letrec->let exp)
  (let ((bindings (letrec-bindings exp)))
    (make-let (map binding-variable bindings)
              (map (lambda (b) '*unassigned*) bindings)
              (append (map (lambda (b) (make-assignment (binding-variable b)
                                                        (binding-value b)))
                           bindings)
                      (letrec-body exp)))))

; Using letrec, the body of f is equivalent to
((lambda (even? odd?)
   (set! even? (lambda (n)
                 (if (= n 0)
                   true
                   (odd? (- n 1)))))
   (set! odd? (lambda (n)
                (if (= n 0)
                  false
                  (even? (- n 1)))))
   <rest of body of f>)
 '*unassigned*
 '*unassigned*)

; Using let instead, the body of f is equivalent to
((lambda (even? odd?)
   <rest of body of f>)
 (lambda (n)
   (if (= n 0)
     true
     (odd? (- n 1))))
 (lambda (n)
   (if (= n 0)
     false
     (even? (- n 1)))))
; But this isn't going to work, because there is no binding for odd? or even? in
; the global environment.

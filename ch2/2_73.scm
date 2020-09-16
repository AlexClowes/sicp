(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (operator expr) (car expr))
(define (operands expr) (cdr expr))

(define (deriv expr var)
  (cond ((number? expr) 0)
        ((variable? expr) (if (same-variable? expr var) 1 0))
        (else ((get 'deriv (operator expr)) (operands expr)
                                            var))))


; This procedure works by extracting the operator and the operands of the
; expression, then using the operator to determine the correct procedure to
; compute the derivative. We can't obtain an operator for the number and
; variable types, so they must be handled explicitly.


(define (install-symbolic-differentiation-package)
  (define (=number? expr num)
    (and (number? expr) (= expr num)))

  ; Sums
  ; Internal procedures
  (define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2))))
  (define (addend s) (cadr s))
  (define (augend s) (caddr s))
  ; Interface to the rest of the system
  (put 'deriv '+
       (lambda (operands var)
         (let ((addend (car operands))
               (augend (cadr operands)))
           (make-sum (deriv addend var)
                     (deriv augend var)))))

  ; Products
  ; Internal procedures
  (define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list '* m1 m2))))
  (define (multiplier p) (cadr p))
  (define (multiplicand p) (caddr p))
  ; Interface to the rest of the system
  (put 'deriv '*
       (lambda (operands var)
         (let ((multiplier (car operands))
               (multiplicand (cadr operands)))
           (make-sum (make-product multiplier
                                   (deriv multiplicand var))
                     (make-product (deriv multiplier var)
                                   multiplicand)))))
  ; Exponentiation
  ; Internal procedures
  (define (make-exponentiation base exponent)
    (cond ((=number? base 0) 0)
          ((=number? base 1) 1)
          ((=number? exponent 0) 1)
          ((=number? exponent 1) base)
          ((and (number? base) (number? exponent)) (expt base exponent))
          (else (list '** base exponent))))
  (define (base e) (car e))
  (define (exponent e) (cadr e))
  ; Interface to the rest of the system
  (put 'deriv '**
       (lambda (operands var)
         (let ((base (car operands))
               (exponent (cadr operands)))
           (make-product (make-product exponent
                                       (make-exponentiation base (- exponent 1)))
                         (deriv base var)))))
  'done)

; If we replace (get 'deriv (operator expr)) with (get (operator expr) 'deriv)
; in the deriv procedure definition, then we must also flip the order of the
; arguments in the calls to put.
; For example, (put 'deriv '+ (make-sum ...)) would become
; (put '+ 'deriv (make-sum ...)) instead.

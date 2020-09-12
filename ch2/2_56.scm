(define (=number? expr num)
  (and (number? expr) (= expr num)))

; Variables
(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

; Sums
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))

(define (addend s) (cadr s))
(define (augend s) (caddr s))
(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

; Products
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))

(define (multiplier p) (cadr p))
(define (multiplicand p) (caddr p))
(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

; Exponentiation
(define (make-exponentiation base exponent)
  (cond ((=number? base 0) 0)
        ((=number? base 1) 1)
        ((=number? exponent 0) 1)
        ((=number? exponent 1) base)
        ((and (number? base) (number? exponent)) (expt base exponent))
        (else (list '** base exponent))))

(define (base e) (cadr e))
(define (exponent e) (caddr e))
(define (exponentiation? x)
  (and (pair? x) (eq? (car x) '**)))

; Differentiation
(define (deriv expr var)
  (cond ((number? expr) 0)
        ((variable? expr)
         (if (same-variable? expr var) 1 0))
        ((sum? expr)
         (make-sum (deriv (addend expr) var)
                   (deriv (augend expr) var)))
        ((product? expr)
         (make-sum (make-product (multiplier expr)
                                 (deriv (multiplicand expr) var))
                   (make-product (deriv (multiplier expr) var)
                                 (multiplicand expr))))
        ((exponentiation? expr)
         (let ((b (base expr))
               (e (exponent expr)))
           (make-product (make-product e (make-exponentiation b (- e 1)))
                         (deriv b var))))
        (else (error "unknown expression type -- DERIV" expr))))

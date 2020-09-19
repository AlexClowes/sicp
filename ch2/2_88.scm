(define (negate x) (apply-generic 'negate x))

(put 'negate '(scheme-number)
     (lambda (x) (tag (- x))))
(put 'negate '(rational)
     (lambda (x) (make-rational (- (numer x)) (denom x))))
(put 'negate '(real)
     (lambda (x) (make-real (- x))))
(put 'negate '(complex)
     (lambda (x) (make-from-real-imag (- (real-part x)) (- (imag-part x)))))

(define (negate-terms term-list)
  (map (lambda (t) (make-term (order t)
                              (negate (coeff t))))
       term-list))
(put 'negate '(polynomial)
     (lambda (p) (make-polynomial (variable p)
                                  (negate-terms (term-list p)))))

(put 'sub '(polynomial polynomial)
     (lambda (p1 p2) (tag (add-poly p1 (negate p2)))))

(define (install-scheme-number-package)
  ; ...
  (put 'raise '(scheme-number)
       (lambda (x) ((get 'make 'rational) x 1)))
  'done)

(define (install-rational-package)
  ; ...
  (put 'raise '(rational)
       (lambda (x) ((get 'make 'real) (/ (numer x) (denom x)))))
  'done)

(define (install-real-package)
  ; ...
  (put 'raise '(real)
       (lambda (x) ((get 'make-from-real-imag 'complex) x 0)))
  'done)

(define (raise x) (apply-generic 'raise x))

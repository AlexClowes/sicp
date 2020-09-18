(define (sine x) (apply-generic 'sine x))
(define (cosine x) (apply-generic 'cosine x))
(define (arctan x) (apply-generic 'arctan x))

(define (install-scheme-number-package)
  ; ...
  (put 'sine '(scheme-number)
       (lambda (x) (tag (sin x))))
  (put 'cosine '(scheme-number)
       (lambda (x) (tag (cos x))))
  'done)

(define (install-rational-package)
  ; ...
  (put 'sine '(rational)
       (lambda (x) ((get 'make 'real) (sin (/ (numer x) (denom x))))))
  (put 'cosine '(rational)
       (lambda (x) ((get 'make 'real) (cos (/ (numer x) (denom x))))))
  (put 'arctan '(rational)
       (lambda (x) ((get 'make 'real) (atan (/ (numer x) (denom x))))))
  'done)

(define (install-complex-rect-package)
  ; ...
  (define (square x) (mul x x))
  (define (magnitude z) (sqrt (add (square (real-part z))
                                   (square (imag-part z)))))
  (define (angle z) (arctan (div (imag-part z) (real-part z))))
  'done)

(define (install-complex-polar-package)
  ; ...
  (define (real-part z) (* (magnitude z) (cosine z)))
  (define (imag-part z) (* (magnitude z) (sine z)))
  'done)

(define (install-complex-package)
  ; ...
  (define (add-complex z1 z2)
    (make-from-real-imag (add (real-part z1) (real-part z2))
                         (add (imag-part z1) (imag-part z2))))
  (define (sub-complex z1 z2)
    (make-from-real-imag (sub (real-part z1) (real-part z2))
                         (sub (imag-part z1) (imag-part z2))))
  (define (mul-complex z1 z2)
    (make-from-mag-ang (mul (magnitude z1) (magnitude z2))
                       (add (angle z1) (angle z2))))
  (define (div-complex z1 z2)
    (make-from-mag-ang (div (magnitude z1) (magnitude z2))
                       (sub (angle z1) (angle z2))))

  (put 'add '(complex complex)
       (lambda (z1 z2) (tag (add-complex z1 z2))))
  (put 'sub '(complex complex)
       (lambda (z1 z2) (tag (sub-complex z1 z2))))
  (put 'mul '(complex complex)
       (lambda (z1 z2) (tag (mul-complex z1 z2))))
  (put 'div '(complex complex)
       (lambda (z1 z2) (tag (div-complex z1 z2))))
  'done)


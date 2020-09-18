(define (install-rational-package)
  ; ...
  (put 'project '(rational)
       (lambda (x) ((get 'make 'scheme-number) (quotient (numer x) (denom x)))))
  'done)

(define (install-real-package)
  ; ...
  (put 'project '(real)
       (lambda (x) ((get 'make 'scheme-number) (round x))))
  'done)

(define (install-complex-package)
  ; ...
  (put 'project '(complex)
       (lambda (x) ((get 'make 'real) (real-part x))))
  'done)

(define (project x) (apply-generic 'project x))

(define (drop x)
  (let ((projected-x (project x)))
    (if (equ? x (raise projected-x))
      (drop projected-x)
      x)))

; Replace (apply proc (map contents args)) with
; (drop (apply proc (map contents args))) in apply-generic, unless op is drop,
; raise or project.

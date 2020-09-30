(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (scale-stream s factor)
  (stream-map (lambda (x) (* x factor))
              s))

(define (integral delayed-integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (let ((integrand (force delayed-integrand)))
                   (add-streams (scale-stream integrand dt)
                                int))))
  int)

(define (RLC R L C dt)
  (lambda (vC0 iL0)
    (define v (integral (delay dv) vC0 dt))
    (define i (integral (delay di) iL0 dt))
    (define dv (scale-stream i (/ -1 C)))
    (define di (add-streams (scale-stream v (/ 1 L))
                            (scale-stream i (/ (- R) L))))
    (cons v i)))

(define p ((RLC 1 0.2 1 0.1) 10 0))
(define v (car p))
(define i (cdr p))

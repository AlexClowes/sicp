(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (scale-stream s factor)
  (stream-map (lambda (x) (* x factor)) s))

(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1) (stream-car s2))
               (add-streams (scale-stream (stream-cdr s2) (stream-car s1))
                            (mul-series (stream-cdr s1) s2))))

(define (invert-unit-series s)
  (define inverse (cons-stream 1
                               (scale-stream (mul-series (stream-cdr s)
                                                         inverse)
                                             -1)))
  inverse)

(define (div-series s1 s2)
  (if (= (stream-car s2) 0)
    (error "Denominator series must have nonzero constant term"))
  (mul-series (scale-stream s1 (/ 1 (stream-car s2)))
              (invert-unit-series s2)))

; Fetching sine-series and cosine-series from exercise 3.59.
(load "3_59.scm")
(define tan-series (div-series sine-series cosine-series))

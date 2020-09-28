(define (div-streams s1 s2)
  (stream-map / s1 s2))

(define (scale-stream s factor)
  (stream-map (lambda (x) (* x factor)) s))

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define (integrate-series series)
  (div-streams series (integers-starting-from 1)))

(define exp-series
  (cons-stream 1 (integrate-series exp-series)))

(define cosine-series
  (cons-stream 1 (scale-stream (integrate-series sine-series) -1)))

(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))

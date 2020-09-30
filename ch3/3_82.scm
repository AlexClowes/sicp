(define (scale-stream s factor)
  (stream-map (lambda (x) (* x factor))
              s))

(define (monte-carlo experiment-stream passed failed)
  (define (next passed failed)
    (cons-stream
      (/ passed (+ passed failed))
      (monte-carlo (stream-cdr experiment-stream) passed failed)))
  (if (stream-car experiment-stream)
    (next (+ passed 1) failed)
    (next passed (+ failed 1))))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (estimate-integral P x1 x2 y1 y2)
  (define (experiment-stream)
    (cons-stream (P (random-in-range x1 x2)
                    (random-in-range y1 y2))
                 (experiment-stream)))
  (scale-stream (monte-carlo (experiment-stream) 0 0)
                (* (- y2 y1) (- x2 x1))))

(define estimate-pi
  (estimate-integral (lambda (x y) (< (+ (square x) (square y)) 1))
                     -1.0
                     1.0
                     -1.0
                     1.0))

(define (average x y)
  (/ (+ x y) 2))

(define (smooth stream)
  (cons-stream (average (stream-ref stream 0)
                        (stream-ref stream 1))
               (stream-cdr stream)))

(define zero-crossings
  (let ((smoothed-data (smooth sense-data)))
    (stream-map sign-change-detector smoothed-data (cons-stream 0 smoothed-data))))

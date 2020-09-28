(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (partial-sums s)
  (define ps (cons-stream (stream-car s) (add-streams ps (stream-cdr s))))
  ps)

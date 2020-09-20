(define (make-accumulator val)
  (lambda (x)
    (set! val (+ x val))
    val))

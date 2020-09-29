(define (stream-limit s tol)
  (let ((s0 (stream-ref s 0))
        (s1 (stream-ref s 1)))
    (if (< (abs (- s1 s0)) tol)
      s1
      (stream-limit (stream-cdr s) tol))))

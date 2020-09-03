(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp) (remainder (* (expmod base (/ exp 2) m)
                                   (expmod base (/ exp 2) m))
                                m))
        (else (remainder (* base (expmod base (- exp 1) m)) m))))

; Using (* (expmod ...) (expmod ...)) instead of (square (expmod ...)) means
; that expmod is evaluated twice with the same arguments, so the same number of
; primitive operations will occur as in the naieve algorithm, i.t. in O(n) time
; instead of O(log(n)) time.

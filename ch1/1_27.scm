(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m))
        (else (remainder (* base (expmod base (- exp 1) m)) m))))

(define (fermat-deterministic n)
  (define (iter a)
    (cond ((= a n) true)
          ((not (= (expmod a n n) a)) false)
          (else (iter (+ a 1)))))
  (iter 2))

(fermat-deterministic 561); 3 | 561
(fermat-deterministic 1105); 5 | 1105
(fermat-deterministic 1729); 7 | 1729

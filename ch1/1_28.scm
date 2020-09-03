(define (miller-rabin-expmod base exp m)
  (define (square-and-check x)
    (define (check x s)
      (if (or (= x 1) (= x (- m 1)) (not (= s 1)))
        s
        0))
    (check x (remainder (square x) m)))
  (cond ((= exp 0) 1)
        ((even? exp) (square-and-check (miller-rabin-expmod base (/ exp 2) m)))
        (else (remainder (* base (miller-rabin-expmod base (- exp 1) m)) m))))

(define (miller-rabin-test n)
  (define (try-it a)
    (= (miller-rabin-expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (miller-rabin-prime? n times)
  (cond ((= n 1) false)
        ((= n 2) true)
        ((= times 0) true)
        ((miller-rabin-test n) (miller-rabin-prime? n (- times 1)))
        (else false)))

(miller-rabin-prime? 561 5)
(miller-rabin-prime? 1105 5)
(miller-rabin-prime? 1729 5)

(define (smallest-divisor n)
  (find-divisor n 2))

(define (next n)
  (if (= n 2) (+ n 1) (+ n 2)))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
    (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes start end)
  (define (iter n)
    (cond ((< n end) (timed-prime-test n)
                     (iter (+ n 2)))))
  (if (even? start)
    (iter (+ start 1))
    (iter start)))


; On modern hardware, these all run too fast to give a reasonable runtime
; measurement.
(search-for-primes 1000 1020)
(search-for-primes 10000 10038)
(search-for-primes 100000 100044)
(search-for-primes 1000000 1000038)

; Instead, find first 3 primes > 1e10.
(search-for-primes 10000000000 10000000062)

; The runtime has decreased from ~0.08s to ~0.05s. This is not a 2x speedup,
; presumably because there is additional overhead from evaluating next.

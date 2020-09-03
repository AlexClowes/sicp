(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m))
        (else (remainder (* base (expmod base (- exp 1) m)) m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 50)
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

; We can't easily measure the runtime on modern hardware.
; The fast-prime? procedure has logarithmic runtime, assuming that primitive
; operations occur in constant time - but this isn't true for large integers,
; so the runtime probably grows faster than O(log(n)).

; This program would run very slowly without memoisation, but much faster with
; it.
(define (fib n)
  (if (< n 10)
    (+ (fib (- n 1)) (fib (- n 2)))))
(define (sum-ints a b)
  (if (= a b)
    0
    (+ a (sum-ints (+ a 1) b))))
(sum-ints 1 (fib 20))

; The first value is 100 in both cases, because (square (id 10)) = (square 10).
; The second value is 1 with memoisation, and 2 without it. This is because
; memoisation avoids evaluating (id 10) twice when it is passed as an argument
; to square.

; T_pq^2(a, b) = T_pq(bq + a(p + q), bp + aq)
;              = (bq(q + 2p) + aq(q + 2p) + a(p^2 + q^2), b(p^2 + q^2) + aq(q + 2p))
;              = T_p'q'(a, b)
; where p' = p^2 + q^2, q' = q(q + 2p).

(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (square p) (square q))
                   (* q (+ q (* 2 p)))
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a (+ p q)))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))

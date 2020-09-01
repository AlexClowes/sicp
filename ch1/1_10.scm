(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

(A 1 10); 1024
(A 2 4); 65536
(A 3 3); 65536

(define (f n) (A 0 n)); f(n) = 2n
(define (g n) (A 1 n)); g(0) = 0, g(n) = 2^n for n >= 1
(define (h n) (A 2 n)); h(0) = 0, h(n) = 2^2^...^2, repeated n times, for n >= 1

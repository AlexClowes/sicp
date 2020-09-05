(define (filtered-accumulate filter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a)
            (if (filter a)
              (combiner (term a) result)
              result))))
  (iter a null-value))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (define (min-div div)
    (cond ((> (* div div) n) n)
          ((divides? div n) div)
          (else (min-div (+ div 1)))))
  (and (not (= n 1)) (= (min-div 2) n)))

(define (inc n) (+ n 1))

(define (sum-prime-squares a b)
  (filtered-accumulate prime? + 0 square a inc b))

(define (identity x) x)

(define (coprime-product n)
  (define (coprime? x) (= (gcd x n) 1))
  (filtered-accumulate coprime? * 1 identity 1 inc (- n 1)))

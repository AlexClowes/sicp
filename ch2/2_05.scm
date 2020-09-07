; Every integer has a unique prime factorisation, so the map (a, b) -> 2^a * 3^b
; is injective for a and b positive integers.

(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (get-exponent z p)
  (define (iter z result)
    (if (= (remainder z p) 0)
      (iter (/ z p) (+ 1 result))
      result))
  (iter z 0))

(define (car z) (get-exponent z 2))

(define (cdr z) (get-exponent z 3))

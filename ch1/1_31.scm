(define (product-recursive term a next b)
  (if (> a b)
    1
    (* (term a) (product-recursive term (next a) next b))))

(define (product-iterative term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (* (term a) result))))
  (iter a 1))

(define (identity x) x)
(define (inc x) (+ x 1))

(define (factorial n)
  (product-iterative identity 1 inc n))

(define (pi-approx n)
  (define (pi-term x)
    (if (even? x)
      (/ (+ x 2) (+ x 1))
      (/ (+ x 1) (+ x 2))))
  (* 4. (product-iterative pi-term 1 inc n)))

(define (square x) (* x x))

(define (sum-of-squares x y) (+ (square x) (square y)))

(define (max x y) (if (> x y) x y))

(define (f a b c)
  (if (> a b)
    (sum-of-squares a (max b c))
    (sum-of-squares b (max a c))))

(define (merge-weighted s1 s2 w)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
          (let ((s1car (stream-car s1))
                (s2car (stream-car s2)))
            (if (<= (w s1car) (w s2car))
              (cons-stream s1car (merge-weighted (stream-cdr s1) s2 w))
              (cons-stream s2car (merge-weighted s1 (stream-cdr s2) w)))))))

(define (weighted-pairs s t w)
  (cons-stream (list (stream-car s) (stream-car t))
               (merge-weighted
                 (merge-weighted
                   (stream-map (lambda (x) (list (stream-car s) x))
                               (stream-cdr t))
                   (stream-map (lambda (x) (list x (stream-car t)))
                               (stream-cdr s))
                   w)
                 (weighted-pairs (stream-cdr s) (stream-cdr t) w)
                 w)))

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

; Part a
(define pairs-by-sum
  (stream-filter (lambda (p) (<= (car p) (cadr p)))
                 (weighted-pairs integers
                                 integers
                                 (lambda (p) (+ (car p) (cadr p))))))

; Part b
(define (divides-by-235? n)
  (or (= (remainder n 2) 0)
      (= (remainder n 3) 0)
      (= (remainder n 5) 0)))

(define (filter-func p)
  (let ((i (car p)) (j (cadr p)))
    (and (<= i j) (not (divides-by-235? i)) (not (divides-by-235? j)))))

(define (weight-func p)
  (let ((i (car p)) (j (cadr p)))
    (+ (* 2 i) (* 3 j) (* 5 i j))))

(define part-b-list
  (stream-filter filter-func
                 (weighted-pairs integers integers weight-func)))

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

(define (repeats s)
  (if (= (stream-ref s 0) (stream-ref s 1))
    (cons-stream (stream-ref s 1) (repeats (stream-cdr s)))
    (repeats (stream-cdr s))))

(define (sum-cubes p)
  (+ (cube (car p)) (cube (cadr p))))

(define ramanujan-numbers
  (repeats
    (stream-map sum-cubes
                (stream-filter (lambda (p) (<= (car p) (cadr p)))
                               (weighted-pairs integers integers sum-cubes)))))

; After 1729, the next 5 Ramanujan numbers are 4104, 13832, 20683, 32832, 39312.

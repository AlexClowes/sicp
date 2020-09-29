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

(define (sum-squares p)
  (+ (square (car p)) (square (cadr p))))

(define (matching-triples s)
  (let ((s0 (stream-ref s 0))
        (s1 (stream-ref s 1))
        (s2 (stream-ref s 2)))
    (if (= (sum-squares s0) (sum-squares s1) (sum-squares s2))
      (cons-stream (list (sum-squares s0) s0 s1 s2)
                   (matching-triples (stream-cdr (stream-cdr (stream-cdr s)))))
      (matching-triples (stream-cdr s)))))

(define sum-2-square-3-ways
  (matching-triples (stream-filter (lambda (p) (<= (car p) (cadr p)))
                                   (weighted-pairs integers integers sum-squares))))

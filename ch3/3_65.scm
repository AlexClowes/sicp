(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (partial-sums s)
  (define ps (cons-stream (stream-car s)
                          (add-streams ps (stream-cdr s))))
  ps)

(define (euler-transform s)
  (let ((s0 (stream-ref s 0))
        (s1 (stream-ref s 1))
        (s2 (stream-ref s 2)))
    (cons-stream (- s2 (/ (square (- s2 s1))
                          (+ s0 (* -2 s1) s2)))
                 (euler-transform (stream-cdr s)))))

(define (make-tableau transform s)
  (cons-stream s
               (make-tableau transform
                             (transform s))))

(define (accelerated-sequence transform s)
  (stream-map stream-car
              (make-tableau transform s)))

(define (log2-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (log2-summands (+ n 1)))))

(define log2-stream (partial-sums (log2-summands 1)))
; Converges slowly
(define log2-stream-accelerated (euler-transform log2-stream))
; Converges faster
(define log2-stream-super-accelerated
  (accelerated-sequence euler-transform log2-stream))
; Convergees even faster

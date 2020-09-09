; Interval procedures
(define (make-interval a b) (cons a b))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (make-center-percent c p)
  (make-center-width c (* c p 0.01)))

(define (lower-bound i) (car i))

(define (upper-bound i) (cdr i))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (percent i)
  (* 100 (/ (width i) (center i))))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (lower-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

(define (display-center-percent i)
  (newline)
  (display (center i))
  (display "+-")
  (display (percent i))
  (display "%"))

; Test accuracy
(define a (make-center-percent 5 1))
(define b (make-center-percent 10 2))

(define parallel1
  (div-interval (mul-interval a b)
                (add-interval a b)))

(define parallel2
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one a)
                                (div-interval one b)))))

(display-center-percent a)
(display-center-percent b)

(display-center-percent (div-interval a a))
(display-center-percent (div-interval a b))

(display-center-percent parallel1)
(display-center-percent parallel2)
; Center values are approximately the same, but the percent values are very
; different.

(define (make-point x y) (cons x y))

(define (x-point p) (car p))

(define (y-point p) (cdr p))

; Implementation 1: specify two diagonally opposite points
(define (make-rect p1 p2) (cons p1 p2))

(define (point1-rect r) (car r))

(define (point2-rect r) (cdr r))

(define (height-rect r)
  (let ((p1 (point1-rect r))
        (p2 (point2-rect r)))
    (abs (- (y-point p1) (y-point p2)))))

(define (width-rect r)
  (let ((p1 (point1-rect r))
        (p2 (point2-rect r)))
    (abs (- (x-point p1) (x-point p2)))))

; Implementation 2: Specify bottom-left corner, height and width
(define (make-rect p h w)
  (cons p (cons h w)))

(define (height-rect r) (cdar r))

(define (width-rect r) (cddr r))

; Compute the area and perimeter of rectangles. This is independent of the
; rectangle implementation.
(define (area r)
  (* (height-rect r) (width-rect r)))

(define (perimeter r)
  (* 2 (+ (height-rect r) (width-rect r))))

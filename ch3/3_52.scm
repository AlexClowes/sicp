(define (stream-enumerate-interval low high)
  (if (> low high)
    the-empty-stream
    (cons-stream low
                 (stream-enumerate-interval (+ low 1) high))))

(define (display-line x)
  (newline)
  (display x))

(define (display-stream s)
  (stream-for-each display-line s))

(define sum 0)
; sum = 0

(define (accum x)
  (set! sum (+ x sum))
  sum)

(define seq (stream-map accum (stream-enumerate-interval 1 20)))
; sum = 1
(define y (stream-filter even? seq))
; sum = 6
(define z (stream-filter (lambda (x) (= (remainder x 5) 0)) seq))
; sum = 10

(stream-ref y 7)
; Evalutes to 136
; sum = 136

(display-stream z)
; Prints 10, 15, 21, 45, 55, 105, 120, 190, 210 separated by newlines.
; sum = 210

; Without the optimisation of memo-proc, we would evaluated (accum x) more than
; once for the same value of x when obtaining values from seq, y, and z.
; This means that we would get different values for the elements of seq each
; time that we fetch them.

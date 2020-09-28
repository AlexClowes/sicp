(define (display-line x)
  (newline)
  (display x))

(define (show x)
  (display-line x)
  x)

(define (stream-enumerate-interval low high)
  (if (> low high)
    the-empty-stream
    (cons-stream low
                 (stream-enumerate-interval (+ low 1) high))))

(define x (stream-map show (stream-enumerate-interval 0 10)))

(stream-ref x 5)
; Prints 0, 1, 2, 3, 4, 5 separated by newlines, then evaluates to 5.

(stream-ref x 7)
; Prints 6, 7, separated by newlines, then evaluates to 7.

(define (expand num den radix)
  (cons-stream
    (quotient (* num radix) den)
    (expand (remainder (* num radix) den) den radix)))

; (expand num den radix) gives the representation of num / den in base radix.
; So (expand 1 7 10) = (1 4 2 8 5 7 1 4 2 ...) because 1 / 7 = 0.142857142...
; in base 10.
; Similarly, (expand 3 8 10) = (3 7 5 0 0 ...) because 3 / 8 = 0.37500...

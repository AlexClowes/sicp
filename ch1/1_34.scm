(define (f g)
  (g 2))
(f f)

; (f f) = (f 2) = (2 2)
; 2 is not applicable, so we get an error.

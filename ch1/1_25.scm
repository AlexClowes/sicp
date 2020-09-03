(define (expmod base exp m)
  (remainder (fast-expt base exp) m))
; This calculates the actual value of base^exp, then finds the modulus. But
; base^exp may be very large and take a long time to calculate. This would make
; the evaluation much slower than taking the modulus of intermediate values as
; well.

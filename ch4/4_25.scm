(define (factorial n)
  (unless (= n 1)
    (* n (factorial (- n 1)))
    1))

; In applicative-order Scheme, this won't work. Both arguments to unless are
; evaluated, even if n = 1, and so we enter an infinite recursion.

; With normal order evaluation, we only evaluate (factorial (- n 1)) if n != 1,
; and so evaluation with terminate.
; (factorial 5)
; (unless (= 5 1) (* 5 (factorial 4)) 1)
; (* 5 (factorial 4))
; (* 5 (unless (= 4 1) (* 4 (factorial 3)) 1))
; (* 5 (* 4 (factorial 3)))
; (* 5 (* 4 (unless (= 3 1) (* 3 (factorial 2)) 1)))
; (* 5 (* 4 (* 3 (factorial 2))))
; (* 5 (* 4 (* 3 (unless (= 2 1) (* 2 (factorial 1)) 1))))
; (* 5 (* 4 (* 3 (* 2 (factorial 1)))))
; (* 5 (* 4 (* 3 (* 2 (unless (= 1 1) (* 1 (factorial 0)) 1)))))
; (* 5 (* 4 (* 3 (* 2 1))))
; 120

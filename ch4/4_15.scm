(define (run-forever) (run-forever))

(define (try p)
  (if (halts? p p)
    (run-forever)
    'halted))

; Evaluating (try try) is equivalent to evaluating
;(if (halts? try try)
;  (run-forever)
;  'halted)
; Suppose that (try try) halts. Then (halts? try try) evaluates to true, 
; and the if expression evaluates to (run-forever), so (try try) does not halt
; - a contradiction.
; Suppose instead that (try try) does not halt. Then (halts? try try) evaluates
; to false, the if expression evaluates to 'halted, and (try try) halts - also a
; contradiction.
; It follows that the halt? procedure cannot exist.

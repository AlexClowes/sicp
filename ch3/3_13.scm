(define (last-pair x)
  (if (null? (cdr x))
    x
    (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define z (make-cycle (list 'a 'b 'c)))
;      ---------------------------
;      V                         |
;    +---+---+  +---+---+  +---+-+-+
; z->| * | *-+->| * | *-+->| * | * |
;    +-+-+---+  +-+-+---+  +-+-+---+
;      |          |          |
;      v          v          v
;    +---+      +---+      +---+
;    | a |      | b |      | c |
;    +---+      +---+      +---+

; Calling (last-pair z) will cause an infinite loop.

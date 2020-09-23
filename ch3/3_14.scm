(define (mystery x)
  (define (loop x y)
    (if (null? x)
      y
      (let ((temp (cdr x)))
        (set-cdr! x y)
        (loop temp x))))
  (loop x '()))

; The procedure mystery reverses a list.

(define v (list 'a 'b 'c 'd))

;    +---+---+  +---+---+  +---+-+-+  +---+---+
; v->| * | *-+->| * | *-+->| * | *-+->| * | / |
;    +---+---+  +---+---+  +---+-+-+  +---+---+
;      |          |          |          |
;      v          v          v          V
;    +---+      +---+      +---+      +---+
;    | a |      | b |      | c |      | d |
;    +---+      +---+      +---+      +---+

(define w (mystery v))

; v is now '(a), w is '(d c b a).
;    +---+---+
; v->| * | / +
;    +---+---+
;      |      
;      v      
;    +---+    
;    | a |    
;    +---+    
;
;    +---+---+  +---+---+  +---+-+-+  +---+---+
; w->| * | *-+->| * | *-+->| * | *-+->| * | / |
;    +---+---+  +---+---+  +---+-+-+  +---+---+
;      |          |          |          |
;      v          v          v          V
;    +---+      +---+      +---+      +---+
;    | d |      | c |      | b |      | a |
;    +---+      +---+      +---+      +---+
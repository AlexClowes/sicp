; The interpreter prints the cons of the front-ptr and rear-ptr.

; (define q1 (make-queue))
;     +---+---+
; q1->| / | / |
;     +---+---+

; (insert-queue! q1 'a)
;     +---+---+
; q1->| * | * |
;     +-+-+-+-+
;       |   |
;       v   v
;     +---+---+
;     | * | / |
;     +-+-+---+
;       |
;       v
;     +---+
;     | a |
;     +---+

; (insert-queue! q1 'b)
;     +---+---+
; q1->| * | *-+-----
;     +-+-+---+    |
;       |          |
;       v          v
;     +---+---+  +---+---+
;     | * | *-+->| * | / |
;     +-+-+---+  +-+-+---+
;       |          |
;       v          v
;     +---+      +---+
;     | a |      | b |
;     +---+      +---+

; (delete-queue! q1)
;            +---+---+
;        q1->| * | * |
;            +-+-+-+-+
;              |   |  
;              v   v  
; +---+---+  +---+---+
; | * | *-+->| * | / |
; +-+-+---+  +-+-+---+
;   |          |
;   v          v
; +---+      +---+
; | a |      | b |
; +---+      +---+

; (delete-queue! q1)
;            +---+---+
;        q1->| / | * |
;            +---+-+-+
;                  |  
;                  v  
; +---+---+  +---+---+
; | * | *-+->| * | / |
; +-+-+---+  +-+-+---+
;   |          |
;   v          v
; +---+      +---+
; | a |      | b |
; +---+      +---+

(define (print-queue queue)
  (newline)
  (display (front-ptr queue)))
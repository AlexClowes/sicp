(define (append x y)
  (if (null? x)
    y
    (cons (car x) (append (cdr x) y))))

(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

(define (last-pair x)
  (if (null? (cdr x))
    x
    (last-pair (cdr x))))

(define x (list 'a 'b))
(define y (list 'c 'd))

(define z (append x y)); '(a b c d)
(cdr x); '(b)

(define w (append! x y)); '(a b c d)
(cdr x); '(b c d)

; In the first case, there is no mutation of variables.
; So (cdr x) is (b).
;    +---+---+  +---+---+    +---+---+  +---+---+
; x->| * | *-+->| * | / | y->| * | *-+->| * | / |
;    +-+-+---+  +-+-+---+    +-+-+---+  +-+-+---+
;      |          |            |          |
;      v          v            v          v
;    +---+      +---+        +---+      +---+
;    | a |      | b |        | c |      | d |
;    +---+      +---+        +---+      +---+
;      ^          ^            ^          ^
;      |          |            |          |
;    +---+---+  +---+---+    +---+---+  +---+---+
; z->| * | *-+->| * | *-+--->| * | *-+->| * | / |
;    +-+-+---+  +-+-+---+    +-+-+---+  +-+-+---+

; In the second case, we mutate the list that x points to.
; So (cdr x) is (b c d).
;      x                     y
;      |                     |
;      v                     V
;    +---+---+  +---+---+  +---+---+  +---+---+
; w->| * | *-+->| * | *-+->| * | *-+->| * | / |
;    +-+-+---+  +-+-+---+  +-+-+---+  +-+-+---+
;      |          |          |          |
;      v          v          v          v
;    +---+      +---+      +---+      +---+
;    | a |      | b |      | c |      | d |
;    +---+      +---+      +---+      +---+

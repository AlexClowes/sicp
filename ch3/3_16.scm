(define (count-pairs x)
  (if (not (pair? x))
    0
    (+ (count-pairs (car x))
       (count-pairs (cdr x))
       1)))

(count-pairs '(a b c)) ;3
; +---+---+  +---+---+  +---+---+
; | * | *-+->| * | *-+->| * | / |
; +-+-+---+  +-+-+---+  +-+-+---+
;   |          |          |
;   v          v          v
; +---+      +---+      +---+
; | a |      | b |      | c |
; +---+      +---+      +---+

(count-pairs (let ((x '(b))) (cons 'a (cons x x)))); 4
; +---+---+  +---+---+
; | * | *-+->| * | * |
; +-+-+---+  +-+-+-+-+
;   |          |   |  
;   v          v   v  
; +---+      +---+---+
; | a |      | * | / |
; +---+      +-+-+---+
;              |
;              v
;            +---+
;            | b |
;            +---+

(count-pairs (let* ((x '(a)) (y (cons x x))) (cons y y))); 7
; +---+---+
; | * | * |
; +-+-+-+-+
;   |   |  
;   v   v  
; +---+---+
; | * | * |
; +-+-+-+-+
;   |   |  
;   v   v  
; +---+---+
; | * | / |
; +-+-+---+
;   |
;   v
; +---+
; | a |
; +---+

(count-pairs (let ((x '(a b c))) (set-cdr! (cddr x) x) x)); Maximum recursion depth exceeded
;   ---------------------------
;   |                         |
;   v                         |
; +---+---+  +-+-+---+  +---+-+-+
; | * | *-+->| * | *-+->| * | / |
; +-+-+---+  +-+-+---+  +-+-+---+
;   |          |          |
;   v          v          v
; +---+      +---+      +---+
; | a |      | b |      | c |
; +---+      +---+      +---+

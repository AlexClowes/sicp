; The expression <e3> is evaluated in environment E1 when the lambda function
; has not been transformed.
; (lambda <vars>
;   (define u <e1>)
;   (define v <e2>)
;   <e3>)
;           _______________________________
; global    |                             |
; env ----->|                             |
;           |_____________________________|
;              ^                         ^
;              |                    _____|_____________
;          (*)(*)               E1->|<vars>:<bindings>|
;           |                       |u:<e1>           |
;           v                       |v:<e2>           |
;       parameters:<vars>           -------------------
;       body: (define u <e1>)
;             (define v <e2>)
;             <e3>

; The expression <e3> is evaluated in environment E2 when the lambda function
; has been transformed to
; (lambda <vars>
;   (let ((u '*unassigned*)
;         (v '*unassigned*))
;     (set! u <e1>)
;     (set! v <e2>)
;     <e3>))
;           __________________________________________
; global    |                                        |
; env ----->|                                        |
;           |________________________________________|
;              ^                                   ^
;              |                              _____|_____________
;          (*)(*)                         E1->|<vars>:<bindings>|
;           |                                 -------------------
;           v                                    ^             ^ 
;       parameters:<vars>                        |            _|______
;       body: (let ((u '*unassigned*)        (*)(*)       E2->|u:<e1>|
;                   (v '*unassigned*))        |               |v:<e2>|
;               (set! u <e1>)                 v               --------
;               (set! v <e2>)             parameters: u, v       
;               <e3>)                     body: (set! u <e1>)
;                                               (set! v <e2>)
;                                               <e3>

; let is syntactic sugar for a lambda, so after transformation there is one
; additional procedure evaluation, and hence another frame is created.

; The change in structure doesn't matter, because the bindings are the same
; when <e3> is evaluated.

; We could make a transformation to
; (lambdas <vars>
;   (define u '*unassigned*)
;   (define v '*unassigned*)
;   (set! u <e1>)
;   (set! v <e2>)
;   <e3>)
; instead. This wouldn't introduce an additional frame.

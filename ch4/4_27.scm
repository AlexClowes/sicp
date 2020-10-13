; Values are 1, 10, 2.

; When (define w (id (id 10))) is evaluated, the outer id application happens
; immediately, and w is bound to a thunk for (id 10) in the global environment.
; Since only the outer id is evaluated, we have count = 1.

; When we evaluate w, the thunk that is bound to w is forced, and we now have
; w bound to the value of (id 10), which is 10.

; Now that both the inner and outer id procedures have been applied, count is
; bound to 2.

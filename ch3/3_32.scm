; If multiple signals change at the same time step, then each change may cause
; new actions to be added to the agenda at layer times. But these actions use
; values that may not be valid at the end of the time step. So we want the final
; actions generated during the time step to be able to override these earlier
; incorrect actions. This is possible with a FIFO structure like a queue, but
; not with a LIFO structure like a list.

; Suppose we have an and gate with inputs a1, a2 and output o. Suppose that we
; have initial state (a1, a2, o) = (0, 1, 0), and then at time step t0, we have
; a1 <- 1, a2<-0. The first change will add an action to the agenda that sets
; o to 1 after a delay, and the second change will add an action to the agenda
; that sets o to 0 after the same delay. We want the action setting o to 0 to
; happen last, as this is the correct value.

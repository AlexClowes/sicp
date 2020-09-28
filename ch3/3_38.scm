; If the processes run sequentially in some order, the possible values for
; balance after all transactions are 35, 40, 45 or 50.

; If the processes are interleaved, then the effect of one or more set-balance!
; calls may be overridden, so that corresponding process has no effect on the
; final balance.
; By overriding a single set-balance! (and interchanging the order of the
; (remaining two processes) we get final balances 30, 40, 55, 60, 90.
; By overriding two set-balance! calls (i.e. only one process affects the
; balance) we get final balances 50, 80, 110.

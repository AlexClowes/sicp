; All wires are initialised with signal 0. It may be the case that some wires
; should take non-zero values after a time, even with no changes to the input
; signals. By running a procedure immediately after attaching it to a wire, any
; necessary updates are immediately added to the agenda.

; If we didn't do this, the output of the inverter in half-adder will remain
; zero indefinitely, even when both input-1 and input-2 have signal zero. Then
; when the signal of input-1 is set to 1, the signal of sum will not update to
; one as expected.

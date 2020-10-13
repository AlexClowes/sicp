; a. display is a primitive expression, so it is evaluated immediately, instead
;    of creating a thunk.
; b. With the original eval-sequence, (p1 1) evaluates to (1 2), and (p2 1) will
;    evaluate to 1.
; c. If we force a thunk, we get an object that is either an evaluated-thunk or
;    some other object. In either case, forcing the object again will still
;    return the correct value.
; d. Expressions in the body of a procedure that are not the final expression
;    only matter if they have side-effects. So it seems reasonable to make sure
;    that these side-effects actually occur. In general, allowing side-effects
;    seems to be a terrible idea when combined with memoized normal-order
;    evaluation.

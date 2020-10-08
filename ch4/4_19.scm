; Ben Bitdiddle's approach make sense for imperative programming, but that's not
; how Scheme works.
; Alyssa's approach is simple to implement, and has the effect of forcing the
; procedure to behave as if all definitions are simultaneous.
; Eva's approach could possibly be implemented by building some sort of
; dependency graph of all the define variables, then performing a topological
; sort. But this still doesn't resolve circular definitions, which would require
; some additional cleverness. This is very complicated, and probably not worth
; the effort.

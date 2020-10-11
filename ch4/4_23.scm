; For a sequence of one expression, say (exp), the analyze-sequence from the
; text will return the procedure (analyze exp).

; Alyssa's analyze-sequence will return the procedure
; (lambda (env) (execute-sequence procs env))
; where procs is the result of (list (analyze exp)).
; So when we use this procedure, we must first evaluate execute-sequence, so
; there is a performance penalty from evaluating a cond expression. In effect,
; the penalty is incurred by traversing the list of expressions at runtime,
; instead of in the call to analyze.

; For a sequence with two expressions (exp1 exp2), the resulting procedures are
; (lambda (env)
;   ((analyze exp1) env)
;   ((analyze exp2) env))
; and 
; (lambda (env) (execute-sequence procs env))
; respectively, where procs is the result of (map analyze (list exp1 exp2)).

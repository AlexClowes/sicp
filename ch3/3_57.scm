(define fibs
  (cons-stream 0
               (cons-stream 1
                            (add-streams (stream-cdr fibs)
                                         fibs))))

; Each element of fibs need only be computed once, so the runtime is O(n) in the
; number of elements.

; If we didn't use memoisation, then in order to obtain the nth fibonacci number
; we would need to recalculate the n-1th and n-2th fibonacci numbers and sum
; them. This is then equivalent to the recursive definition of the fibonacci
; function, which has exponential runtime.

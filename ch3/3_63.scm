; If we don't use the local variable guesses, then for each iteration a new
; stream is created by the evaluation of (sqrt-stream x). This means that we
; don't take advantage of memoisation, and instead perform a lot of redundant
; computation.

; If the implementation of streams doesn't use memoisation, then there would be
; no advantage to using the local variable guesses.

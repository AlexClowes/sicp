; For positive integers n, m with m >= n, the pair (n, m) appears in the stream
; preceded by f(n, m) other pairs, where
; f(n, n) = 2^n - 2
; f(n, m) = 2^n * (m - n) + 2^(n - 1) - 2 for m != n

; f(1, 100) = 197
; f(99, 100) = 3 * 2^98 - 2
; f(100, 100) = 2^100 - 2

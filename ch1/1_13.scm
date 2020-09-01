; Base cases are trivial
; Fib(0) = 0 = (1 - 1) / sqrt(5)
; Fib(1) = 1 = (1 + sqrt(5) - 1 + sqrt(5)) / (2 * sqrt(5)) = 1

; phi, psi are the two solutions for x^2 = x + 1
; So Fib(n) = Fib(n - 1) + Fib(n - 2)
;           = (phi^(n-1) - psi^(n-1) + phi^(n-2) - psi^(n-2)) / sqrt(5)
;           = (phi^(n-2) * (phi + 1) - psi^(n-2) * (psi + 1)) / sqrt(5)
;           = (phi^n - psi^n) / sqrt(5)
; As required

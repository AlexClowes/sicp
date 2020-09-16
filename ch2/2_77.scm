; The operation is dispatched first using the complex tag and then using the
; rectangular tag. So apply-generic is invoked twice.

; (magnitude '(complex rectangular 3 4))
; (apply-generic 'magnitude '(complex rectangular 3 4))
; (apply (get 'magnitude '(complex)) '(rectangular 3 4))
; ((get 'magnitude '(complex)) 'rectangular 3 4)
; (apply-generic 'magnitude '(rectangular 3 4))
; (apply (get 'magnitude '(rectangular)) '(3 4))
; (magnitude '(3 4))
; (sqrt (+ (square 3) (square 4)))
; 5

(define (test-and-set! cell)
  (if (car cell)
    true
    (begin (set-car! cell true)
           false)))

; Suppose that two processes both try to evaluate (test-and-set! cell)
; concurrently. If both processes execute line 2 before either executes line 4,
; then test-and-set! will return false in both processes, and both will have
; acquired the mutex.

(define (time-evaluation program)
  (define global-env (setup-environment))
  (define start-time (runtime))
  (eval program global-env)
  (- (runtime) start-time))

(define loop-program
  '(begin (define (loop n)
            (if (> n 0)
              (loop (- n 1))))
          (loop 100000)))

(define fib-program
  '(begin (define (fib n)
            (if (< n 2)
              n
              (+ (fib (- n 1)) (fib (- n 2)))))
          (fib 20)))

(time-evaluation loop-program)
; Takes ~8.7s with original evaluation procedure.
; Takes ~4.3s with new evaluation procedure.

(time-evaluation fib-program)
; Takes ~2.3s with original evaluation procedure.
; Takes +1.2s with new evaluation procedure.

; So around 50% of time is spent in analysis vs execution.

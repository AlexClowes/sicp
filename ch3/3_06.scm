(define rand
  (let ((x random-init))
    (lambda (arg) (cond ((eq? arg 'generate)
                         (set! x (rand-update x))
                         x)
                        ((eq? arg 'reset)
                         (lambda (new-val) (set! x new-val)))
                        (else (error "Unknown arg -- RAND" arg))))))

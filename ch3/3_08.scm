(define f
  (let ((previously-set false))
    (lambda (x) (if previously-set
                  0
                  (begin (set! previously-set true)
                         x)))))

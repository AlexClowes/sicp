(define (has-cycle x)
  (let ((seen '()))
    (define (recurse x)
      (cond ((not (pair? x)) false)
            ((memq x seen) true)
            (else (set! seen (cons x seen))
                  (recurse (cdr x)))))
    (recurse x)))
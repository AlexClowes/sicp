(define (count-pairs x)
  (let ((seen '()))
    (define (recurse x)
      (if (or (not (pair? x)) (memq x seen))
        0
        (begin (set! seen (cons x seen))
               (+ (recurse (car x)) (recurse (cdr x)) 1))))
    (recurse x)))

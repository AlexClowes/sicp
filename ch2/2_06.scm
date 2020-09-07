(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

; one
; (add-1 zero)
; (add-1 (lambda (g) (lambda (y) y)))
; (lambda (f) (lambda (x) (f (((lambda (g) (lambda (y) y)) f) x))))
; (lambda (f) (lambda (x) (f ((lambda (y) y) x))))
; (lambda (f) (lambda (x) (f x)))

(define one (lambda (f) (lambda (x) (f x))))

(define two (lambda (f) (lambda (x) (f (f x)))))

(define (+ n m) (lambda (f) (lambda (x) ((n f) ((m f) x)))))

; Still make assumption that the order of term is greater than the order
; of all elements of term-list.
(define (adjoin-term term term-list)
  (cond ((=zero? term) term-list)
        ((= (order term) (length term-list)) (cons term term-list))
        (else (adjoin-term term (cons 0 term-list)))))

(define (first-term term-list)
  (make-term (- (length term-list) 1)
             (car term-list)))

; Everything else remains the same.

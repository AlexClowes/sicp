; Sparse polynomials
(define (adjoin-term term term-list)
  (if (=zero? (coeff term))
    term-list
    (cons term term-list)))
(define (first-term term-list) (car term-list))
(define (rest-terms term-list) (cdr term-list))
(define (tag x) (attach-tag 'sparse x))
(put 'adjoin-term 'sparse
     (lambda (term-list) (tag (adjoin-term term term-list))))
(put 'first-term '(sparse) first-term)
(put 'rest-terms '(sparse)
     (lambda (term-list) (tag (rest-terms term-list))))

; Dense polyomials
(define (adjoin-term term term-list)
  (cond ((=zero? term) term-list)
        ((= (order term) (length term-list)) (cons term term-list))
        (else (adjoin-term term (cons 0 term-list)))))
(define (first-term term-list)
  (make-term (- (length term-list) 1)
             (car term-list)))
(define (rest-terms term-list) (cdr term-list))
(define (tag x) (attach-tag 'dense x))
(put 'adjoin-term 'dense
     (lambda (term-list) (tag (adjoin-term term term-list))))
(put 'first-term '(dense) first-term)
(put 'rest-terms '(dense)
     (lambda (term-list) (tag (rest-terms term-list))))

; In polynomial package
(define (adjoin-term term term-list)
  ((get 'adjoin-term (type-tag term-list)) term (contents term-list)))
(define (first-term term-list) (apply-generic 'first-term term-list))
(define (rest-terms term-list) (apply-generic 'rest-terms term-list))

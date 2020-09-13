(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set) (cons x set))

(define (union-set set1 set2) (append set1 set2))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1) (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

; element-of-set? is unchanged.
; adjoin-set now runs in O(1) time instead of O(n) time.
; union-set now runs in O(n) time instead of O(n^2) time.
; intersection-set is unchanged.

; This alternative representation would be useful where we are not constrained
; by memory, but do spend a lot of time running the adjoin-set or union-set
; procedures.

; First representation of mobiles
(define (make-mobile left right) (list left right))
(define (left-branch m) (car m))
(define (right-branch m) (cadr m))

(define (make-branch length structure) (list length structure))
(define (branch-length b) (car b))
(define (branch-structure b) (cadr b))

; Second representation of mobiles
(define (make-mobile left right) (cons left right))
(define (left-branch m) (car m))
(define (right-branch m) (cdr m))

(define (make-branch length structure) (cons length structure))
(define (branch-length b) (car b))
(define (branch-structure b) (cdr b))

; Independent of representation of mobiles and branches
(define (total-weight mobile)
  (if (not (pair? mobile))
    mobile
    (+ (total-weight (branch-structure (left-branch mobile)))
       (total-weight (branch-structure (right-branch mobile))))))

(define (torque branch)
  (* (branch-length branch)
     (total-weight (branch-structure branch))))

(define (balanced? mobile)
  (if (not (pair? mobile))
    #t
    (and (= (torque (left-branch mobile)) (torque (right-branch mobile)))
         (balanced? (branch-structure (left-branch mobile)))
         (balanced? (branch-structure (right-branch mobile))))))

(define (all? items)
  (if (null? items)
    true
    (and (car items) (all? (cdr items)))))

(define (try-coerce target-type args)
  (cond ((null? args) '())
        ((equal? (type-tag (car args)) target-type)
         (cons (car args) (try-coerce target-type (cdr args))))
        (else
          (let ((coercion ((get-coercion target-type (type-tag (car args))))))
            (if coercion
              (cons (coercion (car args) (try-coerce target-type (cdr args))))
              false)))))

(define (apply-generic op . args)
  (define (iter type-tags)
    (if (null? type-tags)
      (error "Unable to coerce types" (list op type-tags))
      (let ((coerced (try-coerce (car type-tags) args)))
        (if (all? coerced)
          (apply (get op (map type-tag coerced)) coerced)
          (iter (cdr type-tags))))))

  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (apply proc (map content args))
        (iterate type-tags)))))


; This approach won't work if we need to coerce some of the arguments to a type
; that does not appear somewhere in the list of arguments.
; For example, suppose we have a procedure which takes two complex arguments,
; and we attempt to invoke that procedure with two real arguments. Then
; apply-generic will not coerce the two arguments to complex arguments and hence
; will fail.

(define (install-level-package)
  (put 'level 'scheme-number 0)
  (put 'level 'rational 1)
  (put 'level 'real 2)
  (put 'level 'complex 3)
  'done)

(define (level type) (get 'level type))

(define (max-level type-tags)
  (define (iter type-tags result)
    (if (null? type-tags)
      result
      (iter (cdr type-tags)
            (max result (level (car type-tags))))))
  (iter type-tags -1))

(define (highest-type type-tags)
  (define (iter type-tags max-level max-type)
    (if (null? type-tags)
      max-type
      (let ((current-type (car type-tags)))
        (let ((current-level (level current-type)))
          (if (> current-level max-level)
            (iter (cdr type-tags) current-level current-type)
            (iter (cdr type-tags) max-level max-type))))))
  (iter type-tags -1 '()))

(define (raise-to target-type x)
  (if (equal? (type-tag x) target-type)
    x
    (raise-to target-type (raise x))))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (apply proc (map contents args))
        (let ((target-type (highest-type args)))
          (apply apply-generic
                 (cons op
                       (map (lambda (x) (raise-to target-type x))
                            args))))))))

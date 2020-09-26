(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (make-table) (list '*table*))

(define (lookup keys table)
  (if (null? keys)
    (cdr table)
    (let ((subtable (assoc (car keys) (cdr table))))
      (if subtable
        (lookup (cdr keys) subtable)
        false))))

(define (insert! keys value table)
  (if (null? (cdr keys))
    (let ((record (assoc (car keys) (cdr table))))
      (if record
        (set-cdr! record value)
        (set-cdr! table
                  (cons (cons (car keys) value) (cdr table)))))
    (let ((subtable (assoc (car keys) (cdr table))))
      (if subtable
        (insert! (cdr keys) value subtable)
        (begin (set-cdr! table
                         (cons (list (car keys)) (cdr table)))
               (insert! (cdr keys) value (cadr table))))))
  'ok)

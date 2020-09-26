; Implement table as a pair, ('*table*, records), where records is a set of
; (key, value) pairs, with the set represented by a binary tree.
(define (make-tree entry left right) (list entry left right))
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))

(define (make-record key value) (cons key value))
(define (record-key r) (car r))
(define (record-value r) (cdr r))

(define (make-table) (list '*table*))

(define (assoc key records)
  (if (null? records)
    false
    (let ((record (entry records)))
      (cond ((= key (record-key record)) record)
            ((< key (record-key record)) (assoc key (left-branch records)))
            ((> key (record-key record)) (assoc key (right-branch records)))))))

(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
      (record-value record)
      false)))

(define (add-record key value records)
  (cond ((null? records)
         (make-tree (make-record key value) '() '()))
        ((= key (record-key (entry records)))
         (set-cdr! (entry records) value)
         records)
        ((< key (record-key (entry records)))
         (make-tree (entry records)
                    (add-record key value (left-branch records))
                    (right-branch records)))
        ((> key (record-key (entry records)))
         (make-tree (entry records)
                    (left-branch records)
                    (add-record key value (right-branch records))))))

(define (insert! key value table)
  (set-cdr! table (add-record key value (cdr table)))
  'ok)

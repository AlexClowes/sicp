(define (last-pair items)
  (let ((tail (cdr items)))
    (if (null? tail)
      items
      (last-pair tail))))

(last-pair (list 23 72 149 34))

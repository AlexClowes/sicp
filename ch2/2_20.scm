(define (same-parity first . items)
  (define (parity-matches? x)
    (= (remainder (- first x) 2) 0))
  (define (iter items result)
    (if (null? items)
      result
      (let ((head (car items))
            (tail (cdr items)))
        (iter tail
              (if (parity-matches? head)
                (cons head result)
                result)))))
  (reverse (iter items (list first))))

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7 8)

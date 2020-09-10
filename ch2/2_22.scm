(define (square-list items)
  (define (iter things answer)
    (if (null? things)
      answer
      (iter (cdr things)
            (cons (square (car things))
                  answer))))
  (iter items '()))
; iter conses the square of the first item of things onto the answer, and
; repeats until things is exhausted. So the list is constructed in reverse
; order.

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
      answer
      (iter (cdr things)
            (cons answer
                  (square (car things))))))
  (iter items '()))
; Now iter conses the answer to the square of the first element of things. So
; now we don't get a list at all, but instead a structure of nested lists.
; e.g. (square-list (list 1 2 3)) = (((() . 1) . 4) . 9)

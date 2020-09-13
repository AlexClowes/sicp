(define (make-tree entry left right) (list entry left right))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
    (cons '() elts)
    (let ((left-size (quotient (- n 1) 2)))
      (let ((left-result (partial-tree elts left-size)))
        (let ((left-tree (car left-result))
              (non-left-elts (cdr left-result))
              (right-size (- n (+ left-size 1))))
          (let ((this-entry (car non-left-elts))
                (right-result (partial-tree (cdr non-left-elts)
                                            right-size)))
            (let ((right-tree (car right-result))
                  (remaining-elts (cdr right-result)))
              (cons (make-tree this-entry left-tree right-tree)
                    remaining-elts))))))))

; partial-tree splits an ordered list into three parts:
; a list of the first floor((n - 1) / 2) elements, the median element, and a
; list of the last floor(n / 2) elements.
; partial-tree is called for each of the two lists to construct two balanced
; subtrees, which are then combined with the median element to create a
; balanced tree for the entire list.

; The tree produced by (list->tree '(1 3 5 7 9 11)) is
;    5
;  /   \
; 1     9
;  \   / \
;   3 7  11

; The algorithm runs in O(n) time.

(define (div-terms L1 L2)
  (if (empty-termlist? L1)
    (list (the-empty-termlist) (the-empty-termlist))
    (let ((t1 (first-term L1))
          (t2 (first-term L2)))
      (if (> (order t2) (order t1))
        (list (the-empty-termlist) L1)
        (let ((new-c (div (coeff t1) (coeff t2)))
              (new-o (- (order t1) (order t2))))
          (let ((new-term (make-term new-o new-c)))
            (let ((rest-of-result
                    (div-terms (sub-terms L1
                                          (mul-term-by-all-terms new-term L2))
                               L2)))
              (list (adjoin-term new-term (car rest-of-result))
                    (cadr rest-of-result)))))))))

(define (div-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
    (map (lambda (tl) (make-poly (variable p1) tl))
         (div-terms (term-list p1) (term-list p2)))
    (error "Polys not in same var -- DIV-POLY"
           (list p1 p2))))

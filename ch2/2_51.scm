(define (below bottom top)
  (let ((split-point (make-vect 0 0.5)))
    (let ((paint-bottom (transform-painter bottom
                                           (make-vect 0 0)
                                           (make-vect 1 0)
                                           split-point))
          (paint-top (transform-painter top
                                        split-point
                                        (make-vect 1 0.5)
                                        (make-vect 0 1))))
      (lambda (frame)
        (paint-bottom frame)
        (paint-top frame)))))

(define (below bottom top)
  (rotate90 (beside (rotate270 bottom) (rotate270 top))))

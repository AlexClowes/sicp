(define (segments->painter segment-list)
  (lambda (frame)
    (for-each (lambda (segment)
                (draw-line ((frame-coord-map frame) (start-segment segment))
                           ((frame-coord-map frame) (end-segment segment))))
              segment-list)))

(define bl (make-vect 0 0))
(define br (make-vect 1 0))
(define tl (make-vect 0 1))
(define tr (make-vect 1 1))

(define outline-painter
  (segments->painter (list (make-segment bl br)
                           (make-segment br tr)
                           (make-segment tr tl)
                           (make-segment tl bl))))

(define x-painter
  (segments->painter (list (make-segment bl tr) (make-segment br tl))))

(define diamond-painter
  (let ((top (make-vect 0.5 1))
        (left (make-vect 0 0.5))
        (right (make-vect 1 0.5))
        (bottom (make-vect 0.5 0)))
    (segments->painter (list (make-segment bottom right)
                             (make-segment right top)
                             (make-segment top left)
                             (make-segment left bottom)))))

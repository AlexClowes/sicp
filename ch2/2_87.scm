(define (=zero?-poly p)
  (define (iter terms)
    (if (empty-termlist? terms)
      #t
      (if (=zero? (first-term terms))
        (iter (rest-terms terms))
        #f)))
  (iter (term-list p)))

(put '=zero? 'polynomial =zero-poly?)

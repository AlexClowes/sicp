(define (random-numbers requests)
  (define (dispatch request last-val)
    (cond ((eq? request 'generate)
           (rand-update last-val))
          ((and (pair? request) (eq? (car request) 'reset))
           (cdr request))
          (else
            (error "Unknown request" request))))
  (define nums
    (cons-stream (dispatch (stream-car requests)
                           random-init)
                 (stream-map dispatch
                             (stream-cdr requests)
                             nums)))
  nums)

; It seems reasonable to only allow procedures to remove bindings in the
; first frame of their environment.
(define (make-unbound! var env)
  (define (delete-var frame)
    (cond ((null? frame)
           (error "Unbound variable" var))
          ((eq? var (caar frame))
           (cdr frame))
          (else (cons (car frame)
                      (delete-var (cdr frame))))))
  (set-car! env (delete-var (first-frame env))))

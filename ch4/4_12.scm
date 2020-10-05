(define (env-loop env var on-null-vars on-var-eq)
  (define (scan vars vals)
    (cond ((null? vars)
           (on-null-vars env))
          ((eq? var (car vars))
           (on-var-eq vals))
          (else (scan (cdr vars) (cdr vals)))))
  (let ((frame (first-frame env)))
    (scan (frame-variables frame)
          (frame-values frame))))

(define (lookup-variable-value var env)
  (define (on-null-vars env)
    (env-loop (enclosing-environment env)
              var
              on-null-vars
              on-var-eq))
  (define (on-var-eq vals)
    (car vals))
  (env-loop env var on-null-vars on-var-eq))

(define (set-variable-value! var val env)
  (define (on-null-vars env)
    (env-loop (enclosing-environment env)
              var
              on-null-vars
              on-var-eq))
  (define (on-var-eq vals)
    (set-car! vals val))
  (env-loop env var on-null-vars on-var-eq))

(define (define-variable! var val env)
  (define (on-null-vars env)
    (add-binding-to-frame! var val (first-frame env)))
  (define (on-var-eq vals)
    (set-car! vals val))
  (env-loop env var on-null-vars on-var-eq))

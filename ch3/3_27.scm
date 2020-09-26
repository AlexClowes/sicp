(define (make-table) (list '*table*))

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
      (cdr record)
      false)))

(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
      (set-cdr! record value)
      (set-cdr! table
                (cons (cons key value) (cdr table))))))

(define (memoize f)
  (let ((table (make-table)))
    (lambda (x)
      (let ((previously-computed-result (lookup x table)))
        (or previously-computed-result
            (let ((result (f x)))
              (insert! x result table)
              result))))))

(define memo-fib
  (memoize (lambda (n)
             (if (<= n 1)
               n
               (+ (memo-fib (- n 1)) (memo-fib (- n 2)))))))

; For brevity's sake, some bindings in the global environment have been omitted.
; Evaluating (memo-fib 3) results in the following environments, and returns
; the value 2.
;           _________________________________________________________
; global    |                                                       |
; env ----->|                                            memo-fib:  |
;           |________________________________________________|______|
;                 ^        ^                                 |
;               __|__      |                                 |
;           E1->|f:-+->(*)(*)                                |
;               -----   |                                    |
;                ^      v                                    |
;                | parameters:n                              |
;                | body:(if (<= n 1)                         |
;                |        n                                  |
;                |        (+ (memo-fib (- n 1))              |
;                |           (memo-fib (- n 2))))            |
;               _|________________________________________   |
;           E2->|table:('*table* (0 0) (1 1) (2 1) (3 2))|   |
;               ------------------------------------------   |
;                                           ^                |
;                                           |                |
;                                       (*)(*)<---------------
;                                        |
;                                        v
;                                   parameters:x
;                                   body: (let ((previously-computed-result (lookup x table)))
;                                           (or previously-computed-result
;                                               (let ((result (f x)))
;                                                 (insert! x result table)
;                                                 result)))

; For each integer n, (memo-fib n) is computed at most once, and if computed it
; is stored in the table. So the runtime is O(n), not O(e^n).

; If we used (define memo-fib (memoize fib)) instead, then the body of memo-fib
; would still contain a reference to the naieve fib procedure from the global
; environment, and we wouldn't get the expected speedup.

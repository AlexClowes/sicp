(define *op-table* (make-hash-table))
(define (put op type proc)
  (hash-table/put! *op-table* (list op type) proc))
(define (get op type)
  (hash-table/get *op-table* (list op type) #f))

(define (attach-tag type-tag contents)
  (if (eq? type-tag 'scheme-number)
    contents
    (cons type-tag contents)))
(define (type-tag datum)
  (cond ((number? datum) 'scheme-number)
        ((pair? datum) (car datum))
        (else (error "Bad tagged datum -- TYPE-TAG" datum))))
(define (contents datum)
  (cond ((number? datum) datum)
        ((pair? datum) (cdr datum))
        (else (error "Bad tagged datum -- CONTENTS" datum))))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (apply proc (map contents args))
        (error "No method for these types -- APPLY-GENERIC"
               (list op type-tags))))))

(define (install-scheme-number-package)
  ; Interface to the rest of the system
  (put 'add '(scheme-number scheme-number) +)
  (put 'mul '(scheme-number scheme-number) *)
  (put '=zero? '(scheme-number)
       (lambda (x) (= x 0)))
  'done)

(define (install-rational-package)
  ; Internal procedures
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (make-rat n d) (cons n d))
  (define (add-rat x y)
    (make-rat (add (mul (numer x) (denom y))
                   (mul (numer y) (denom x)))
              (mul (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (mul (numer x) (numer y))
              (mul (denom x) (denom y))))

  ; Interface to the rest of the system
  (define (tag x) (attach-tag 'rational x))
  (put 'make 'rational
       (lambda (n d) (tag (make-rat n d))))
  (put 'add '(rational rational)
       (lambda (x y) (tag (add-rat x y))))
  (put 'mul '(rational rational)
       (lambda (x y) (tag (mul-rat x y))))
  'done)

(define (install-polynomial-package)
  ; internal procedures
  ; representation of poly
  (define (make-poly variable term-list) (cons variable term-list))
  (define (variable p) (car p))
  (define (term-list p) (cdr p))
  (define (variable? x) (symbol? x))
  (define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2)))

  ; representation of terms and term lists
  (define (adjoin-term term term-list)
    (if (=zero? (coeff term))
      term-list
      (cons term term-list)))
  
  (define (the-empty-termlist) '())
  (define (first-term term-list) (car term-list))
  (define (rest-terms term-list) (cdr term-list))
  (define (empty-termlist? term-list) (null? term-list))

  (define (make-term order coeff) (list order coeff))
  (define (order term) (car term))
  (define (coeff term) (cadr term))

  (define (add-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (add-terms (term-list p1)
                            (term-list p2)))
      (error "Polys not in same var -- ADD-POLY"
             (list p1 p2))))
  (define (add-terms L1 L2)
    (cond ((empty-termlist? L1) L2)
          ((empty-termlist? L2) L1)
          (else (let ((t1 (first-term L1)) (t2 (first-term L2)))
                  (cond ((> (order t1) (order t2))
                         (adjoin-term t1
                                      (add-terms (rest-terms L1) L2)))
                        ((< (order t1) (order t2))
                         (adjoin-term t2
                                      (add-terms L1 (rest-terms L2))))
                        (else (adjoin-term (make-term (order t1)
                                                      (add (coeff t1) (coeff t2)))
                                           (add-terms (rest-terms L1)
                                                      (rest-terms L2)))))))))

  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (mul-terms (term-list p1)
                            (term-list p2)))
      (error "Polys not in same var -- ADD-POLY"
             (list p1 p2))))
  (define (mul-terms L1 L2)
    (if (empty-termlist? L1)
      (the-empty-termlist)
      (add-terms (mul-term-by-all-terms (first-term L1) L2)
                 (mul-terms (rest-terms L1) L2))))
  (define (mul-term-by-all-terms t1 L)
    (if (empty-termlist? L)
      (the-empty-termlist)
      (let ((t2 (first-term L)))
        (adjoin-term (make-term (+ (order t1) (order t2))
                                (mul (coeff t1) (coeff t2)))
                     (mul-term-by-all-terms t1 (rest-terms L))))))

  ; interface to the rest of the system
  (define (tag p) (attach-tag 'polynomial p))
  (put 'make 'polynomial
       (lambda (var terms) (tag (make-poly var terms))))
  (put 'add '(polynomial polynomial)
       (lambda (p1 p2) (tag (add-poly p1 p2))))
  (put 'mul '(polynomial polynomial)
       (lambda (p1 p2) (tag (mul-poly p1 p2))))
  'done)

(define (add x y) (apply-generic 'add x y))
(define (mul x y) (apply-generic 'mul x y))
(define (=zero? x) (apply-generic '=zero? x))

(install-scheme-number-package)

(install-rational-package)
(define (make-rational n d)
  ((get 'make 'rational) n d))

(install-polynomial-package)
(define (make-polynomial variable terms)
  ((get 'make 'polynomial) variable terms))

(define p1 (make-polynomial 'x '((2 1) (0 1))))
(define p2 (make-polynomial 'x '((3 1) (0 1))))
(define rf (make-rational p1 p2))
(add rf rf)

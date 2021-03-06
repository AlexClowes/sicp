(define (make-leaf symbol weight) (list 'leaf symbol weight))

(define (leaf? object) (eq? (car object) 'leaf))

(define (symbol-leaf x) (cadr x))

(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))

(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
    (list (symbol-leaf tree))
    (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
    (weight-leaf tree)
    (cadddr tree)))

(define (encode-symbol symbol tree)
  (if (leaf? tree)
    '()
    (let ((lbranch (left-branch tree))
          (rbranch (right-branch tree)))
      (cond ((memq symbol (symbols lbranch))
             (cons 0 (encode-symbol symbol lbranch)))
            ((memq symbol (symbols rbranch))
             (cons 1 (encode-symbol symbol rbranch)))
            (else (error "symbol not contained in tree -- ENCODE-SYMBOL" symbol))))))

(define (encode message tree)
  (if (null? message)
    '()
    (append (encode-symbol (car message) tree)
            (encode (cdr message) tree))))

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree (make-leaf 'B 2)
                                  (make-code-tree (make-leaf 'D 1)
                                                  (make-leaf 'C 1)))))

(define sample-message '(A D A B B C A))

(encode sample-message sample-tree)
; (0 1 1 0 0 1 0 1 0 1 1 1 0)

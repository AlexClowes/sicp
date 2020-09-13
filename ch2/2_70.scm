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

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
    '()
    (let ((pair (car pairs)))
      (adjoin-set (make-leaf (car pair)   ;symbol
                             (cadr pair)) ;frequency
                  (make-leaf-set (cdr pairs))))))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge set)
  (if (= (length set) 1)
    (car set)
    (let ((first (car set))
          (second (cadr set))
          (rest (cddr set)))
      (successive-merge (adjoin-set (make-code-tree first second) rest)))))

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

(define alphabet '((A 1) (BOOM 1) (GET 2) (JOB 2) (NA 16) (SHA 3) (YIP 9) (WAH 1)))
(define tree (generate-huffman-tree alphabet))
(define message '(GET A JOB
                  SHA NA NA NA NA NA NA NA NA
                  GET A JOB
                  SHA NA NA NA NA NA NA NA NA
                  WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP
                  SHA BOOM))
(length (encode message tree))
; Message requires 84 bits with huffman encoding.
(* (length message) 3)
; Message requires 3 * 36 = 108 bits with fixed-length code.

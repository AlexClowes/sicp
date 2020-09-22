; The procedure
(define (make-withdraw initial-amount)
  (let ((balance initial-amount))
    (lambda (amount)
      (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))))
; is syntactic sugar for
(define (make-withdraw initial-amount)
  ((lambda (balance)
     (lambda (amount)
       (if (>= balance amount)
         (begin (set! balance (- balance amount))
                balance)
         "Insufficient funds")))
   initial-amount))

; (define W1 (make-withdraw 100))
; To evaluate (make-withdraw 100), an environment E1 is created with
; initial-amount bound to 100. Then in evaluating the top-level lambda in the
; body of make-withdraw, another environment E2 is created with balance bound
; to the value of initial-amount in E1, i.e. 100. E2 is then the environment
; of the procedure W1.
;           _____________________________________________________________
; global    |                                                           |
; env ----->| make-withdraw:              W1:                           |
;           |______|_______________________|____________________________|
;                  |     ^                 |                          ^
;                  v     |                 |                 _________|__________
;           parameters: initial-amount     |             E1->|initial-amount:100|
;           body: ((lambda (balance) ...)  |                 --------------------
;                  initial-amount)         |                          ^
;                                          |                     _____|_______
;                                          |                 E2->|balance:100|
;                                          |                     -------------
;                                          v                          ^
;                                   parameters: amount ---------------|
;                                   body: (if (>= balance amount)
;                                           (begin (set! balance (- balance amount))
;                                                  balance)
;                                           "Insufficient funds")

; (W1 50)
; A new environment E3 is created, with amount bound to 50. set! is used to
; change the value of balance in E2 from 100 to 100 - 50 = 50.
;           _____________________________________________________________
; global    |                                                           |
; env ----->| make-withdraw:              W1:                           |
;           |______|_______________________|____________________________|
;                  |     ^                 |                          ^
;                  v     |                 |                 _________|__________
;           parameters: initial-amount     |             E1->|initial-amount:100|
;           body: ((lambda (balance) ...)  |                 --------------------
;                  initial-amount)         |                          ^
;                                          |                     _____|______
;                                          |                 E2->|balance:50|
;                                          |                     ------------
;                                          v                        ^  ^
;                                   parameters: amount -------------|  |-------------------------   
;                                   body: (if (>= balance amount)                          _____|____
;                                           (begin (set! balance (- balance amount))   E3->|amount:50|
;                                                  balance)                                -----------
;                                           "Insufficient funds")

; (define W2 (make-withdraw 100))
; This is the same as the first diagram, except that new environments E4 and E5
; are created with bindings initial-amount:100 and balance:100 are created.
; In this diagram W1 and its related environments are omitted for brevity's
; sake.
;           ____________________________________________________________
; global    |                                                           |
; env ----->| make-withdraw:              W2:                           |
;           |______|_______________________|____________________________|
;                  |     ^                 |                          ^
;                  v     |                 |                 _________|__________
;           parameters: initial-amount     |             E4->|initial-amount:100|
;           body: ((lambda (balance) ...)  |                 --------------------
;                  initial-amount)         |                          ^
;                                          |                     _____|_______
;                                          |                 E5->|balance:100|
;                                          |                     -------------
;                                          v                          ^
;                                   parameters: amount ---------------|
;                                   body: (if (>= balance amount)
;                                           (begin (set! balance (- balance amount))
;                                                  balance)
;                                           "Insufficient funds")

; (define acc (make-account 50))
; In evaluating (make-account 50), a new environment E1 is created, with balance
; bound to 50. Then the body of make-account is evaluated, and the define
; statements cause procedures withdraw, deposit and dispatch to be created in
; E1. In the global environment, acc is just a pointer to the dispatch procedure
; in E1.
;           ______________________________________________________________________________________________
; global    |                                                                                            |
; env ----->| make-account:                                                                         acc: |
;           |_______|_________________________________________________________________________________|__|
;                   | ^                                  ^                                            |
;                   v |                                  |                                            |
;                 (*)(*)                            _____|_____                                       |
;                  |                            E1->|balance:50|<------                               |
;                  v                                |          |      |                               |
;         parameters: balance                       |withdraw:-+->(*)(*)                              |
;         body: (define (withdraw ...) ...)         |          |   |------> parameters: amount        |
;               (define (deposit ...) ...)          |          |<------     body: (if (>= ...) ...)   |
;               (define (dispatch ...) ...)         |          |      |                               |
;               dispatch                            |deposit:--+->(*)(*)                              |
;                                                   |          |   |------> parameters: amount        |
;                                                   |          |<------     body: (set! ...)          |
;                                                   |          |      |                               |
;                                                   |dispatch:-+->(*)(*)<-----------------------------|
;                                                   |__________|   |------> parameters: m
;                                                                           body: (cond ...)

; ((acc 'deposit) 40)
; To evaluate (acc 'deposit), create a new environment E2, with m bound to the
; symbol 'deposit. This returns a pointer to the deposit procedure in E1,
; and (deposit 40) is evaluated by creating a new environment E3 with amount
; bound to 40. This causes the value of balance in E1 to change from 50 to
; 50 + 40 = 90.
;           ______________________________________________________________________________________________
; global    |                                                                                            |
; env ----->| make-account:                                                                         acc: |
;           |_______|_________________________________________________________________________________|__|
;                   | ^                                  ^                                            |
;                   v |                                  |                                            |
;                 (*)(*)                            _____|_____                                       |
;                  |                            E1->|balance:90|<------                               |
;                  v                                |          |      |                               |
;         parameters: balance                       |withdraw:-+->(*)(*)                              |
;         body: (define (withdraw ...) ...)         |          |   |------> parameters: amount        |
;               (define (deposit ...) ...)          |          |<------     body: (if (>= ...) ...)   |
;               (define (dispatch ...) ...)         |          |      |                               |
;               dispatch                            |deposit:--+->(*)(*)                              |
;                                                   |          |   |------> parameters: amount        |
;                                                   |          |<------     body: (set! ...)          |
;                                                   |          |      |                               |
;                                                   |dispatch:-+->(*)(*)<-----------------------------|
;                                                   |__________|   |------> parameters: m
;                                    ____________     ^     ^               body: (cond ...)
;                                E2->|m:'deposit|-----|     |
;                                    ------------           |
;                                    ___________            |
;                                E3->|amount:40|------------|
;                                    -----------

; ((acc 'withdraw) 60)
; This is similar to the previous expression. (dispatch 'withdraw) is evaluted
; in environment E4, then (withdraw 60) is evaluted in frame E5, so that the
; final value of balance in E1 is 90 - 60 = 30.
;           ______________________________________________________________________________________________
; global    |                                                                                            |
; env ----->| make-account:                                                                         acc: |
;           |_______|_________________________________________________________________________________|__|
;                   | ^                                  ^                                            |
;                   v |                                  |                                            |
;                 (*)(*)                            _____|_____                                       |
;                  |                            E1->|balance:30|<------                               |
;                  v                                |          |      |                               |
;         parameters: balance                       |withdraw:-+->(*)(*)                              |
;         body: (define (withdraw ...) ...)         |          |   |------> parameters: amount        |
;               (define (deposit ...) ...)          |          |<------     body: (if (>= ...) ...)   |
;               (define (dispatch ...) ...)         |          |      |                               |
;               dispatch                            |deposit:--+->(*)(*)                              |
;                                                   |          |   |------> parameters: amount        |
;                                                   |          |<------     body: (set! ...)          |
;                                                   |          |      |                               |
;                                                   |dispatch:-+->(*)(*)<-----------------------------|
;                                                   |__________|   |------> parameters: m
;                                    ____________     ^ ^  ^ ^             body: (cond ...)
;                                E2->|m:'deposit|-----| |  | |
;                                    ------------       |  | |
;                                    ___________        |  | |
;                                E3->|amount:40|---------  | |
;                                    -----------           | |
;                                    _____________         | |
;                                E4->|m:'withdraw|---------| |
;                                    -------------           |
;                                    ___________             |
;                                E5->|amount:60|-------------|
;                                    -----------

; (define acc2 (make-account 100))
; In defining acc2, a new environment E6 is created, containing bindings
; for balance, withdraw, deposit and dispatch. Because this is a different
; environment, acc and acc2 have separate local state. They both share the
; same global environment, and the procedure objects may point to the same
; procedure objects (this would depend on the implementation).

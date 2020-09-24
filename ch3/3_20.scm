; The global environment initially looks like this. For brevity's sake, these
; procedures aren't shown in subsequent diagrams.
;           ________________________________________________________________________________________________
; global    |                                                                                              |
; env ----->| cons:                        car:            cdr:          set-car!:            set-cdr!:    |
;           |___|___________________________|_______________|_______________|____________________|_________|
;               | ^                         | ^             | ^             | ^                  | ^
;               v |                         v |             v |             v |                  v |
;             (*)(*)                      (*)(*)          (*)(*)          (*)(*)               (*)(*)
;              |                           |               |               |                    |
;              v                           v               v               v                    v
;       parameters: x, y            parameters: z   parameters: z   parameters: z        parameters: z
;       body: (define (dispatch m)  body: (z 'car)  body: (z 'cdr)  body: (z 'set-car!)  body: (z 'set-cdr!)
;               ...)
;             dispatch

; (define x (cons 1 2))
; (cons 1 2) is evaluated inside frame E1 with x bound to 1, y bound to 2,
; and set-x!, set-y!, dispatch bound to procedures. Then in the global 
; environment, x is bound to dispatch from E1.
;           ___________________________________________
; global    |                                         |
; env ----->| cons: car: cdr: set-car!: set-cdr!: x:  |
;           |_____________________________________|___|
;                  ^                              |
;                  |                ---------------
;            ______|_____           |
;        E1->|x:1       |<------    |
;            |y:2       |      |    |
;            |set-x!:---+->(*)(*)   |
;            |          |   |-------+--> parameters: v
;            |          |<------    |    body: (set! x v)
;            |          |      |    |
;            |set-y!:---+->(*)(*)   |
;            |          |   |-------+--> parameters: v
;            |          |<------    |    body: (set! y v)
;            |          |      |    |
;            |dispatch:-+->(*)(*)<---
;            |          |   |----------> parameters: m
;            ------------                body: (cond ...)

; (define z (cons x x))
; (cons x x) is evaluated in frame E2 with x and y bound to x from the global
; environment. In the global environment, z is bound to the dispatch procedure
; in E2.
;           ___________________________________________________________________
; global    |                                                                 |
; env ----->| cons: car: cdr: set-car!: set-cdr!: x:<- z:                     |
;           |_____________________________________|__|_|______________________|
;                  ^                              |  --+-------------------- ^     
;                  |                ---------------    |                   | |     
;            ______|_____           |                  -----|          ____|_|_____
;        E1->|x:1       |<------    |                       |      --->|x:-|      |<-E2
;            |y:2       |      |    |                       |      |   |y:-|      |
;            |set-x!:---+->(*)(*)   |                       |  (*)(*)<-+-set-x!:  |
;            |          |   |-------+--> parameters: v   <--+---|      |          |
;            |          |<------    |    body: (set! x v)   |      --->|          |
;            |          |      |    |                       |      |   |          |
;            |set-y!:---+->(*)(*)   |                       |  (*)(*)<-+-set-y!:  |
;            |          |   |-------+--> parameters: v   <--+---|      |          |
;            |          |<------    |    body: (set! y v)   |      --->|          |
;            |          |      |    |                       |      |   |          |
;            |dispatch:-+->(*)(*)<---                       |->(*)(*)<-+-dispatch:|
;            |          |   |----------> parameters: m   <------|      |          |
;            ------------                body: (cond ...)              ------------

; (set-car! (cdr z) 17)
; (cdr z) is evaluated in frame E3 with z bound to z from the global environment.
; This causes (z 'cdr) to be evaluated in frame E4, returning x from the global
; environment.
; Then (set-car! x 17) is evaluated in frame E5, causing (x 'set-car!) to be
; evaluated in frame E6, and hence (set-x! 17) to be evaluated in frame E7.
; This changes the value of x in frame E1 from 1 to 17.
;                                  _____         _____
;                              E5->|x:-+--   E3->|z:-+--
;                                  ----- |       ----- |
;                                    |   ---------- |  |
;           _________________________v____________|_v__|_______________________
; global    |                                     v    v                      |
; env ----->| cons: car: cdr: set-car!: set-cdr!: x:<- z:                     |
;           |_____________________________________|__|_|______________________|
;                  ^                              |  --+-------------------- ^     
;                  |                ---------------    |                   | |     
;            ______|_____           |                  -----|          ____|_|_____
;        E1->|x:1       |<------    |                       |      --->|x:-|      |<-E2
;            |y:2       |      |    |                       |      |   |y:-|      |
;            |set-x!:---+->(*)(*)   |                       |  (*)(*)<-+-set-x!:  |
;            |          |   |-------+--> parameters: v   <--+---|      |          |
;            |          |<------    |    body: (set! x v)   |      --->|          |
;            |          |      |    |                       |      |   |          |
;            |set-y!:---+->(*)(*)   |                       |  (*)(*)<-+-set-y!:  |
;            |          |   |-------+--> parameters: v   <--+---|      |          |
;            |          |<------    |    body: (set! y v)   |      --->|          |
;            |          |      |    |                       |      |   |          |
;            |dispatch:-+->(*)(*)<---                       |->(*)(*)<-+-dispatch:|
;            |          |   |----------> parameters: m   <------|      |          |
;            ------------                body: (cond ...)              ------------
;             ^       ^                                                   ^
;     ________|____   |----                                            ___|____
; E6->|m:'set-car!|     __|___                                     E4->|m:'cdr|
;     ------------- E7->|v:17|                                         --------
;                       ------

; For the sake of brevity, compute (factorial 3) instead of (factorial 6).

; Recursive
;           ______________
; global    |            |
; env ----->| factorial: |
;           |_____|______|
;                 |  ^
;                 v  |
;           parameters: n
;           body: (if (= n 1) 1 (* n (factorial (- n 1))))
;
;           ______________________________________________
; global    |                                            |
; env ----->|                                            |
;           |____________________________________________|
;             ^                   ^                 ^
;           __|__               __|__             __|__
;       E1->|n:3|           E2->|n:2|        E3 ->|n:1|
;           -----               -----             -----
;    (* 3 (factorial 2)) (* 2 (factorial 1))        1

; Iterative
;           _______________________________
; global    |                             |
; env ----->| factorial:    fact-iter:    |
;           |_____|_____________|_________|
;                 |  ^          |      ^
;                 |  |          v      |
;                 |  |          parameters: product, counter, max-count
;                 |  |          body: (if (> counter max-count)
;                 |  |                  product
;                 v  |                  (fact-iter (* counter product)
;           parameters: n                          (+ counter 1)
;           body: (fact-iter 1 1 n)                max-count))
;
;           ___________________________________________________________________________________________
; global    |                                                                                         |
; env ----->|                                                                                         |
;           |_________________________________________________________________________________________|
;             ^                    ^                    ^                    ^                    ^
;           __|__            ______|_____         ______|______        ______|_____         ______|_____
;       E1->|n:3|            |product:1  |        |product:1  |        |product 2  |        |product:6  |
;           -----        E2->|counter:1  |    E3->|counter:2  |    E4->|counter:3  |    E5->|counter:4  |
;     (fact-iter 1 1 3)      |max-count:3|        |max-count:3|        |max-count:3|        |max-count:3|
;                            -------------        -------------        -------------        -------------
;                          (fact-iter 1 2 3)    (fact-iter 2 3 3)    (fact-iter 6 4 3)           6

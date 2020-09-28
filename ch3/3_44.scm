; Louis Reasoner is wrong.
; In the exchange problem, we have to compute the amount to be transferred
; by accessing the balances of the two accounts. But then after we have done
; this, the balances may change and this previously-computed value is no longer
; valid.
; For the transfer problem, the amount to be transferred is independent of the
; initial balances of the accounts, so we do not need a more complicated
; serialisation strategy.

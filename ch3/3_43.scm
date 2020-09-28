; The initial balances of the accounts are $10, $20, $30 in some order.
; Any single exchange process will swap two of the balances, but the balances
; will still be $10, $20, $30 in some order.
; So if all exchanges are applied sequentially, then after an arbitrary number
; of exchanges we will always have balances $10, $20, $30 in some order.

; If the exchanges are implemented with the first version of the account-exchange
; program, the following may happen:
; Label the three accounts A, B, C with initial balances $10, $20, $30
; respectively. Suppose that (exchange A B) and (exchange B C) run concurrently.
; Then a posibble outcome is as follows:
; difference is bound to 10 - 20 = -10 in the first evaluation.
; The second evaluation swaps the balances of B and C, so
; (A, B, C) = ($10, $30, $20).
; The first evaluation completes, so, (A, B, C) = ($20, $20, $20).
; So now all accounts have the same balance of $20.

; Even with the failure above, any call to exchange will still withdraw the same
; amount from account1 as it deposits into account2, so the total money in the
; system is conserved.

; If nothing is serialised, then we could have a situation where the result of
; ((account2 'deposit) difference) is overriden, and money that was withdrawn
; from account1 does not appear in the balance of account2. So the total money
; in the system will have decreased.

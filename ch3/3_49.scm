; Suppose that we must transfer from an account A to either account B or account
; C, with the choice depending on the balance of account A. Then we must acquire
; the lock on account A first, before we know whether to acquire a lock on B or
; C. This could force the process to acquire locks out of order.

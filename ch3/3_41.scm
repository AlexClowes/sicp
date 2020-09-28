; Accessing the balance doesn't change the state of the account, so there is no
; need to serialise it. Each call to withdraw or deposit will only result in one
; call to set!, so balance can only return a "before" or "after" value with 
; respect to a change in balance, and this is the case regardless of whether
; serialisation is used.

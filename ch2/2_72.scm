; It takes O(n) time to encode a symbol on each level of the tree, and there
; are somewhere between n and log_2(n) levels in the tree.
; So the worst-case runtime is somewhere between O(nlog(n)) and O(n^2),
; depending on the structure of the tree.

; For the kind of tree in ex 2.71, encoding the most-frequest symbol takes O(n)
; time, and encoding the least-frequent symbol takes O(n^2) time.

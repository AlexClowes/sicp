; With Louis's changes, the call to serialized-exchange will now get stuck in a
; deadlock, as it would now be trying to use the same serialiser twice at the
; same time.
